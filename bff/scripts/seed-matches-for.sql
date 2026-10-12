-- Give a real account some demo matches, chats and incoming likes (dev only).
--
--   psql "$DATABASE_URL" -v email=you@example.com -f scripts/seed-matches-for.sql
--
-- Matches the user with 4 demo profiles (two with a chat, two fresh), and has 3 more
-- demo profiles like them. Idempotent. Picks demo users of the gender the account is
-- looking for; falls back to any demo user when the profile has no preference set.

-- psql does not expand :vars inside $$ bodies, so pass it through a session setting.
SELECT set_config('seed.email', :'email', false);

DO $$
DECLARE
  me      UUID;
  who     TEXT := current_setting('seed.email');
  want    TEXT[];
  pool    UUID[];
  other   UUID;
  lo UUID; hi UUID; mid UUID; cid UUID;
  t0      TIMESTAMPTZ;
  i       INT;
  first_name TEXT;
BEGIN
  SELECT u.id, p.looking_for INTO me, want
  FROM auth.users u JOIN dating.profiles p ON p.user_id = u.id
  WHERE lower(u.email) = lower(who);
  IF me IS NULL THEN
    RAISE EXCEPTION 'no user with email %', who;
  END IF;
  IF want IS NULL OR cardinality(want) = 0 THEN
    want := ARRAY['woman','man','nonbinary','other'];
  END IF;

  -- Demo candidates: right gender, not already swiped either way, not blocked, stable order.
  SELECT array_agg(p.user_id ORDER BY u.email) INTO pool
  FROM dating.profiles p JOIN auth.users u ON u.id = p.user_id
  WHERE u.email LIKE 'demo%@friendzy.local'
    AND p.gender = ANY(want)
    AND p.user_id <> me
    AND NOT EXISTS (SELECT 1 FROM dating.swipes s WHERE (s.from_user_id = me AND s.to_user_id = p.user_id) OR (s.from_user_id = p.user_id AND s.to_user_id = me))
    AND NOT EXISTS (SELECT 1 FROM dating.blocks b WHERE (b.blocker_id = me AND b.blocked_id = p.user_id) OR (b.blocker_id = p.user_id AND b.blocked_id = me));

  IF pool IS NULL OR cardinality(pool) < 7 THEN
    RAISE NOTICE 'only % unswiped demo candidates left for %, seeding what is available', coalesce(cardinality(pool), 0), who;
  END IF;

  SELECT split_part(display_name, ' ', 1) INTO first_name FROM dating.profiles WHERE user_id = me;

  -- 1..4: mutual matches
  FOR i IN 1..LEAST(4, coalesce(cardinality(pool), 0)) LOOP
    other := pool[i];
    lo := LEAST(me, other); hi := GREATEST(me, other);
    t0 := NOW() - (i * interval '9 hours');

    INSERT INTO dating.swipes (from_user_id, to_user_id, action, created_at)
    VALUES (me, other, 'like', t0 - interval '15 minutes'), (other, me, 'like', t0)
    ON CONFLICT DO NOTHING;

    INSERT INTO dating.matches (user_a, user_b, created_at) VALUES (lo, hi, t0)
    ON CONFLICT (user_a, user_b) DO UPDATE SET unmatched_at = NULL, unmatched_by = NULL;
    SELECT id INTO mid FROM dating.matches WHERE user_a = lo AND user_b = hi;

    INSERT INTO dating.conversations (match_id, user_a, user_b, last_message_at, created_at)
    VALUES (mid, lo, hi, t0, t0)
    ON CONFLICT (match_id) DO NOTHING;
    SELECT id INTO cid FROM dating.conversations WHERE match_id = mid;

    IF NOT EXISTS (SELECT 1 FROM dating.messages WHERE conversation_id = cid) THEN
      IF i = 1 THEN
        -- They wrote last: shows as unread for the user.
        INSERT INTO dating.messages (conversation_id, sender_id, body, created_at) VALUES
          (cid, other, 'Hey ' || first_name || '! We matched 🎉 What are you up to this weekend?', t0 + interval '10 minutes'),
          (cid, me,    'Hey! Probably chasing good coffee. You?', t0 + interval '40 minutes'),
          (cid, other, 'Same, honestly. Know any place that isn’t packed on Sunday?', NOW() - interval '25 minutes');
        UPDATE dating.conversations SET last_message_at = NOW() - interval '25 minutes',
          last_preview = 'Same, honestly. Know any place that isn’t packed on Sunday?', last_sender_id = other WHERE id = cid;
        INSERT INTO dating.message_reads (conversation_id, user_id, last_read_at) VALUES
          (cid, me, t0 + interval '41 minutes'), (cid, other, NOW() - interval '25 minutes')
        ON CONFLICT (conversation_id, user_id) DO UPDATE SET last_read_at = EXCLUDED.last_read_at;
      ELSIF i = 2 THEN
        -- User wrote last, already read by them.
        INSERT INTO dating.messages (conversation_id, sender_id, body, created_at) VALUES
          (cid, me,    'Your profile made me laugh, in a good way.', t0 + interval '30 minutes'),
          (cid, other, 'That’s the goal 😄 which part?', t0 + interval '2 hours'),
          (cid, me,    'The bit about proving the biryani. I’ll need evidence.', t0 + interval '3 hours');
        UPDATE dating.conversations SET last_message_at = t0 + interval '3 hours',
          last_preview = 'The bit about proving the biryani. I’ll need evidence.', last_sender_id = me WHERE id = cid;
        INSERT INTO dating.message_reads (conversation_id, user_id, last_read_at) VALUES
          (cid, me, t0 + interval '3 hours'), (cid, other, t0 + interval '4 hours')
        ON CONFLICT (conversation_id, user_id) DO UPDATE SET last_read_at = EXCLUDED.last_read_at;
      END IF;
      -- i = 3, 4: matched, nobody has said hi yet.
    END IF;
  END LOOP;

  -- Reciprocate up to 2 of the user's own unanswered likes (superlikes first): those become matches too.
  FOR other IN
    SELECT s.to_user_id
    FROM dating.swipes s JOIN auth.users u ON u.id = s.to_user_id
    WHERE s.from_user_id = me AND s.action <> 'pass' AND u.email LIKE 'demo%@friendzy.local'
      AND NOT EXISTS (SELECT 1 FROM dating.swipes r WHERE r.from_user_id = s.to_user_id AND r.to_user_id = me)
    ORDER BY (s.action = 'superlike') DESC, s.created_at DESC
    LIMIT 2
  LOOP
    lo := LEAST(me, other); hi := GREATEST(me, other);
    t0 := NOW() - interval '50 minutes';
    INSERT INTO dating.swipes (from_user_id, to_user_id, action, created_at) VALUES (other, me, 'like', t0)
    ON CONFLICT DO NOTHING;
    INSERT INTO dating.matches (user_a, user_b, created_at) VALUES (lo, hi, t0)
    ON CONFLICT (user_a, user_b) DO UPDATE SET unmatched_at = NULL, unmatched_by = NULL;
    SELECT id INTO mid FROM dating.matches WHERE user_a = lo AND user_b = hi;
    INSERT INTO dating.conversations (match_id, user_a, user_b, last_message_at, created_at)
    VALUES (mid, lo, hi, t0, t0)
    ON CONFLICT (match_id) DO NOTHING;
    RAISE NOTICE 'reciprocated like from % -> new match', (SELECT display_name FROM dating.profiles WHERE user_id = other);
  END LOOP;

  -- 5..7: they liked the user, waiting for a swipe back
  FOR i IN 5..LEAST(7, coalesce(cardinality(pool), 0)) LOOP
    INSERT INTO dating.swipes (from_user_id, to_user_id, action, created_at)
    VALUES (pool[i], me, CASE WHEN i = 6 THEN 'superlike' ELSE 'like' END, NOW() - ((i - 4) * interval '2 hours'))
    ON CONFLICT DO NOTHING;
  END LOOP;

  RAISE NOTICE 'seeded % matches and % incoming likes for %',
    LEAST(4, coalesce(cardinality(pool), 0)), GREATEST(0, LEAST(7, coalesce(cardinality(pool), 0)) - 4), who;
END $$;
