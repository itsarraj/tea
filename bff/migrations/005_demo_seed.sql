-- Friendzy: richer demo data so every table has something in it.
--
-- Builds on the 12 demo users from 004 and adds 12 more (demo13..demo24, password demo1234).
-- demo1@friendzy.local (Halima) is the intended "log in as" account: she has matches,
-- an unread chat, a fresh match with no messages yet, incoming likes and a full swipe deck.
--
-- Everything is idempotent (ON CONFLICT / NOT EXISTS) and scoped to *@friendzy.local.
-- Remove in prod with:  DELETE FROM auth.users WHERE email LIKE 'demo%@friendzy.local';

-- ---------------------------------------------------------------------------
-- 1. More demo users (mostly Bengaluru so they land in demo1's deck)
-- ---------------------------------------------------------------------------
WITH demo(email, name, gender, looking_for, intent, birthday, city, lat, lng, about, interests, img) AS (
  VALUES
    ('demo13@friendzy.local','Riya Sharma','woman','{man}','partner',DATE '2003-08-11','Bengaluru',12.9279,77.6271,'Product designer by day, sketchbook hoarder by night.','{✍🏻 Writing,👗 Fashion,📸 Photography}',5),
    ('demo14@friendzy.local','Arjun Mehta','man','{woman}','both',DATE '2002-04-03','Bengaluru',12.9345,77.6101,'Trail runs on Sunday, filter coffee always.','{💪 Gym & Fitness,🍃 Nature,🙂 People}',11),
    ('demo15@friendzy.local','Neha Iyer','woman','{man,woman}','friends',DATE '2005-01-25','Bengaluru',12.9850,77.5533,'Carnatic playlists and stand-up shows.','{🎵 Music,🗣 Language}',9),
    ('demo16@friendzy.local','Kabir Singh','man','{woman}','partner',DATE '2001-12-19','Bengaluru',12.9081,77.6476,'Cooks a mean biryani. Will prove it.','{🏝 Travel,🙂 People}',53),
    ('demo17@friendzy.local','Sara Thomas','woman','{man}','both',DATE '2004-06-07','Bengaluru',13.0100,77.5500,'Med student who still finds time for football.','{⚽️ Football,🍃 Nature}',25),
    ('demo18@friendzy.local','Dev Patel','man','{woman,man}','friends',DATE '2003-10-30','Bengaluru',12.9500,77.7000,'Photographer. Ask me about golden hour spots.','{📸 Photography,🏝 Travel}',68),
    ('demo19@friendzy.local','Ananya Rao','woman','{man}','partner',DATE '2002-09-14','Bengaluru',12.9180,77.5800,'Bookstores, rain, and slow Sundays.','{✍🏻 Writing,🍃 Nature,🎵 Music}',16),
    ('demo20@friendzy.local','Rohan Verma','man','{woman}','both',DATE '2004-02-28','Bengaluru',12.9700,77.6500,'Learning guitar badly but enthusiastically.','{🎵 Music,💪 Gym & Fitness}',61),
    ('demo21@friendzy.local','Meera Nair','woman','{woman}','partner',DATE '2003-05-22','Bengaluru',12.9400,77.5700,'Yoga teacher, plant parent, tea snob.','{🍃 Nature,💪 Gym & Fitness}',36),
    ('demo22@friendzy.local','Ishaan Kapoor','man','{woman}','friends',DATE '2005-07-16','Bengaluru',12.9950,77.6200,'Board games night host. BYO snacks.','{🙂 People,🗣 Language}',57),
    ('demo23@friendzy.local','Zoya Khan','woman','{man,woman}','both',DATE '2004-11-02','Mysuru',12.2958,76.6394,'Weekend road trips and street food.','{🏝 Travel,📸 Photography,🙂 People}',29),
    ('demo24@friendzy.local','Aditya Bose','man','{woman}','partner',DATE '2002-01-08','Bengaluru',12.9600,77.6000,'Startup engineer. Yes, I have a side project.','{✍🏻 Writing,🎵 Music}',14)
),
ins AS (
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  SELECT email, crypt('demo1234', gen_salt('bf', 10)), name, TRUE, birthday FROM demo
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name
  RETURNING id, email
),
prof AS (
  INSERT INTO dating.profiles (user_id, display_name, gender, looking_for, intent, birthday, city, lat, lng, about, interests, onboarding_complete, last_active_at)
  SELECT i.id, d.name, d.gender, d.looking_for::text[], d.intent, d.birthday, d.city, d.lat, d.lng, d.about, d.interests::text[], TRUE,
         NOW() - (random() * interval '48 hours')
  FROM demo d JOIN ins i ON i.email = d.email
  ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat, lng = EXCLUDED.lng,
    about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE
  RETURNING user_id
)
INSERT INTO dating.photos (user_id, url, position)
SELECT i.id, 'https://i.pravatar.cc/600?img=' || d.img, 0
FROM demo d JOIN ins i ON i.email = d.email
WHERE NOT EXISTS (SELECT 1 FROM dating.photos p WHERE p.user_id = i.id);

-- ---------------------------------------------------------------------------
-- 2. Second and third photo for every demo user (portrait + lifestyle shot)
-- ---------------------------------------------------------------------------
WITH d AS (
  SELECT u.id, u.email, p.gender,
         (regexp_replace(u.email, '\D', '', 'g'))::int AS n
  FROM auth.users u JOIN dating.profiles p ON p.user_id = u.id
  WHERE u.email LIKE 'demo%@friendzy.local'
)
INSERT INTO dating.photos (user_id, url, position)
SELECT d.id,
       'https://randomuser.me/api/portraits/' || CASE WHEN d.gender = 'woman' THEN 'women' ELSE 'men' END || '/' || ((d.n * 7) % 100) || '.jpg',
       1
FROM d
WHERE NOT EXISTS (SELECT 1 FROM dating.photos p WHERE p.user_id = d.id AND p.position = 1)
UNION ALL
SELECT d.id, 'https://picsum.photos/seed/tea-' || d.n || '/600/800', 2
FROM d
WHERE NOT EXISTS (SELECT 1 FROM dating.photos p WHERE p.user_id = d.id AND p.position = 2);

-- ---------------------------------------------------------------------------
-- 3. Swipes, matches, conversations, messages, reads, blocks, reports, devices
-- ---------------------------------------------------------------------------
DO $$
DECLARE
  u     UUID[];
  a     UUID; b UUID; lo UUID; hi UUID;
  mid   UUID; cid UUID;
  t0    TIMESTAMPTZ;
  -- mutual likes -> match + conversation
  mutual INT[][] := ARRAY[
    [1,3], [1,5], [1,7], [1,11], [1,14],
    [2,3], [2,5], [4,12], [8,10], [13,14], [15,18], [16,19], [20,21]
  ];
  -- one-way likes (shows up as "liked you" for the target)
  oneway INT[][] := ARRAY[
    [8,1], [9,1], [13,1], [15,1], [20,1], [24,1],
    [3,7], [5,13], [14,19], [16,13], [22,15], [18,9]
  ];
  passes INT[][] := ARRAY[ [1,6], [1,12], [3,9], [5,10], [14,2] ];
BEGIN
  -- Resolve demo1..demo24 ids into an array (index = demo number).
  SELECT array_agg(id ORDER BY n) INTO u
  FROM (
    SELECT id, (regexp_replace(email, '\D', '', 'g'))::int AS n
    FROM auth.users WHERE email LIKE 'demo%@friendzy.local'
  ) s;
  IF u IS NULL OR array_length(u, 1) < 24 THEN
    RAISE NOTICE 'demo users missing, skipping relational seed';
    RETURN;
  END IF;

  -- Passes
  FOR i IN 1..array_length(passes, 1) LOOP
    INSERT INTO dating.swipes (from_user_id, to_user_id, action, created_at)
    VALUES (u[passes[i][1]], u[passes[i][2]], 'pass', NOW() - (i * interval '5 hours'))
    ON CONFLICT DO NOTHING;
  END LOOP;

  -- One-way likes
  FOR i IN 1..array_length(oneway, 1) LOOP
    INSERT INTO dating.swipes (from_user_id, to_user_id, action, created_at)
    VALUES (u[oneway[i][1]], u[oneway[i][2]], CASE WHEN i % 4 = 0 THEN 'superlike' ELSE 'like' END, NOW() - (i * interval '3 hours'))
    ON CONFLICT DO NOTHING;
  END LOOP;

  -- Mutual likes -> matches -> conversations
  FOR i IN 1..array_length(mutual, 1) LOOP
    a := u[mutual[i][1]]; b := u[mutual[i][2]];
    lo := LEAST(a, b); hi := GREATEST(a, b);
    t0 := NOW() - (i * interval '26 hours');

    INSERT INTO dating.swipes (from_user_id, to_user_id, action, created_at)
    VALUES (a, b, 'like', t0 - interval '20 minutes'), (b, a, 'like', t0)
    ON CONFLICT DO NOTHING;

    INSERT INTO dating.matches (user_a, user_b, created_at)
    VALUES (lo, hi, t0)
    ON CONFLICT (user_a, user_b) DO NOTHING;
    SELECT id INTO mid FROM dating.matches WHERE user_a = lo AND user_b = hi;

    INSERT INTO dating.conversations (match_id, user_a, user_b, last_message_at, created_at)
    VALUES (mid, lo, hi, t0, t0)
    ON CONFLICT (match_id) DO NOTHING;
  END LOOP;

  -- Halima (1) <-> James (3): active chat, James sent last -> unread for Halima
  SELECT c.id INTO cid FROM dating.conversations c JOIN dating.matches m ON m.id = c.match_id
   WHERE m.user_a = LEAST(u[1], u[3]) AND m.user_b = GREATEST(u[1], u[3]);
  IF cid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dating.messages WHERE conversation_id = cid) THEN
    INSERT INTO dating.messages (conversation_id, sender_id, body, created_at) VALUES
      (cid, u[3], 'Hey Halima! Nature and writing — do you journal on hikes or is that just me?', NOW() - interval '25 hours'),
      (cid, u[1], 'Haha only when the view is worth it. Nandi Hills at sunrise counts.', NOW() - interval '24 hours 40 minutes'),
      (cid, u[3], 'Okay that is exactly my Sunday plan. Coffee after?', NOW() - interval '24 hours 20 minutes'),
      (cid, u[1], 'Third Wave on the way back, obviously.', NOW() - interval '23 hours'),
      (cid, u[3], 'Deal. I’ll bring the bad jokes, you bring the playlist.', NOW() - interval '35 minutes');
    UPDATE dating.conversations SET last_message_at = NOW() - interval '35 minutes',
      last_preview = 'Deal. I’ll bring the bad jokes, you bring the playlist.', last_sender_id = u[3] WHERE id = cid;
    INSERT INTO dating.message_reads (conversation_id, user_id, last_read_at) VALUES
      (cid, u[1], NOW() - interval '22 hours'), (cid, u[3], NOW() - interval '30 minutes')
    ON CONFLICT DO NOTHING;
  END IF;

  -- Halima (1) <-> Alfredo (5): Halima sent last, read by both
  SELECT c.id INTO cid FROM dating.conversations c JOIN dating.matches m ON m.id = c.match_id
   WHERE m.user_a = LEAST(u[1], u[5]) AND m.user_b = GREATEST(u[1], u[5]);
  IF cid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dating.messages WHERE conversation_id = cid) THEN
    INSERT INTO dating.messages (conversation_id, sender_id, body, created_at) VALUES
      (cid, u[5], 'We have five interests in common, that has to be a record 😄', NOW() - interval '2 days 3 hours'),
      (cid, u[1], 'The algorithm is showing off. Which one do you actually do most?', NOW() - interval '2 days 2 hours'),
      (cid, u[5], 'Travel, easily. Just back from Gokarna.', NOW() - interval '2 days 1 hour'),
      (cid, u[1], 'Jealous. Send pictures and I’ll forgive you.', NOW() - interval '2 days');
    UPDATE dating.conversations SET last_message_at = NOW() - interval '2 days',
      last_preview = 'Jealous. Send pictures and I’ll forgive you.', last_sender_id = u[1] WHERE id = cid;
    INSERT INTO dating.message_reads (conversation_id, user_id, last_read_at) VALUES
      (cid, u[1], NOW() - interval '2 days'), (cid, u[5], NOW() - interval '1 day 20 hours')
    ON CONFLICT DO NOTHING;
  END IF;

  -- Halima (1) <-> Miranda (11): short exchange, Miranda last -> unread
  SELECT c.id INTO cid FROM dating.conversations c JOIN dating.matches m ON m.id = c.match_id
   WHERE m.user_a = LEAST(u[1], u[11]) AND m.user_b = GREATEST(u[1], u[11]);
  IF cid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dating.messages WHERE conversation_id = cid) THEN
    INSERT INTO dating.messages (conversation_id, sender_id, body, created_at) VALUES
      (cid, u[1], 'Saw your “live anywhere” post. Lisbon. You?', NOW() - interval '4 days'),
      (cid, u[11], 'Kyoto, no contest. Also hi 👋', NOW() - interval '3 days 22 hours');
    UPDATE dating.conversations SET last_message_at = NOW() - interval '3 days 22 hours',
      last_preview = 'Kyoto, no contest. Also hi 👋', last_sender_id = u[11] WHERE id = cid;
    INSERT INTO dating.message_reads (conversation_id, user_id, last_read_at) VALUES
      (cid, u[1], NOW() - interval '4 days'), (cid, u[11], NOW() - interval '3 days 22 hours')
    ON CONFLICT DO NOTHING;
  END IF;

  -- Halima (1) <-> Clara (7) and Halima <-> Arjun (14): matched, nobody has said hi yet.

  -- Vanessa (2) <-> James (3)
  SELECT c.id INTO cid FROM dating.conversations c JOIN dating.matches m ON m.id = c.match_id
   WHERE m.user_a = LEAST(u[2], u[3]) AND m.user_b = GREATEST(u[2], u[3]);
  IF cid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dating.messages WHERE conversation_id = cid) THEN
    INSERT INTO dating.messages (conversation_id, sender_id, body, created_at) VALUES
      (cid, u[2], 'Pickup game this weekend? I’m terrible but enthusiastic.', NOW() - interval '6 days'),
      (cid, u[3], 'Enthusiastic is all we ask. Cubbon Park, 7am Saturday.', NOW() - interval '5 days 23 hours');
    UPDATE dating.conversations SET last_message_at = NOW() - interval '5 days 23 hours',
      last_preview = 'Enthusiastic is all we ask. Cubbon Park, 7am Saturday.', last_sender_id = u[3] WHERE id = cid;
    INSERT INTO dating.message_reads (conversation_id, user_id, last_read_at) VALUES
      (cid, u[2], NOW() - interval '5 days 22 hours'), (cid, u[3], NOW() - interval '5 days 23 hours')
    ON CONFLICT DO NOTHING;
  END IF;

  -- Kate (4) <-> Finn (12)
  SELECT c.id INTO cid FROM dating.conversations c JOIN dating.matches m ON m.id = c.match_id
   WHERE m.user_a = LEAST(u[4], u[12]) AND m.user_b = GREATEST(u[4], u[12]);
  IF cid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dating.messages WHERE conversation_id = cid) THEN
    INSERT INTO dating.messages (conversation_id, sender_id, body, created_at) VALUES
      (cid, u[12], 'Board games and German practice in the same evening?', NOW() - interval '8 days'),
      (cid, u[4], 'Nur wenn du verlierst 😏', NOW() - interval '7 days 20 hours'),
      (cid, u[12], 'I understood none of that and I accept.', NOW() - interval '7 days 19 hours');
    UPDATE dating.conversations SET last_message_at = NOW() - interval '7 days 19 hours',
      last_preview = 'I understood none of that and I accept.', last_sender_id = u[12] WHERE id = cid;
    INSERT INTO dating.message_reads (conversation_id, user_id, last_read_at) VALUES
      (cid, u[4], NOW() - interval '7 days'), (cid, u[12], NOW() - interval '7 days 19 hours')
    ON CONFLICT DO NOTHING;
  END IF;

  -- Riya (13) <-> Arjun (14)
  SELECT c.id INTO cid FROM dating.conversations c JOIN dating.matches m ON m.id = c.match_id
   WHERE m.user_a = LEAST(u[13], u[14]) AND m.user_b = GREATEST(u[13], u[14]);
  IF cid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dating.messages WHERE conversation_id = cid) THEN
    INSERT INTO dating.messages (conversation_id, sender_id, body, created_at) VALUES
      (cid, u[14], 'Sketchbook hoarder — how many are we talking?', NOW() - interval '12 hours'),
      (cid, u[13], 'Fourteen. Two are full. Don’t judge.', NOW() - interval '11 hours');
    UPDATE dating.conversations SET last_message_at = NOW() - interval '11 hours',
      last_preview = 'Fourteen. Two are full. Don’t judge.', last_sender_id = u[13] WHERE id = cid;
    INSERT INTO dating.message_reads (conversation_id, user_id, last_read_at) VALUES
      (cid, u[13], NOW() - interval '11 hours'), (cid, u[14], NOW() - interval '10 hours')
    ON CONFLICT DO NOTHING;
  END IF;

  -- An unmatched pair, kept for history: Savanna (10) unmatched Brandon (8)
  UPDATE dating.matches SET unmatched_at = NOW() - interval '3 days', unmatched_by = u[10]
   WHERE user_a = LEAST(u[8], u[10]) AND user_b = GREATEST(u[8], u[10]) AND unmatched_at IS NULL;

  -- Blocks and reports
  INSERT INTO dating.blocks (blocker_id, blocked_id, created_at) VALUES
    (u[12], u[6], NOW() - interval '9 days'),
    (u[21], u[16], NOW() - interval '2 days')
  ON CONFLICT DO NOTHING;

  IF NOT EXISTS (SELECT 1 FROM dating.reports WHERE reporter_id = u[4] AND reported_id = u[6]) THEN
    INSERT INTO dating.reports (reporter_id, reported_id, reason, details, status, created_at) VALUES
      (u[4], u[6], 'spam', 'Kept sending links to a Telegram channel.', 'open', NOW() - interval '9 days'),
      (u[21], u[16], 'inappropriate', NULL, 'reviewed', NOW() - interval '2 days');
  END IF;

  -- Push devices (fake tokens; Expo will report DeviceNotRegistered and the BFF prunes them)
  INSERT INTO dating.devices (expo_push_token, user_id, platform, updated_at) VALUES
    ('ExponentPushToken[demo-seed-halima-0001]', u[1], 'android', NOW() - interval '1 hour'),
    ('ExponentPushToken[demo-seed-james-0003]',  u[3], 'android', NOW() - interval '3 hours')
  ON CONFLICT (expo_push_token) DO NOTHING;

  -- Auth sessions so the auth tables are not empty either
  INSERT INTO auth.user_sessions (user_id, user_agent, ip, created_at, last_seen_at)
  SELECT u[1], 'Tea/1.0.0 (Android 14; Pixel 7)', '10.0.0.12'::inet, NOW() - interval '3 days', NOW() - interval '1 hour'
  WHERE NOT EXISTS (SELECT 1 FROM auth.user_sessions WHERE user_id = u[1]);
  INSERT INTO auth.user_sessions (user_id, user_agent, ip, created_at, last_seen_at)
  SELECT u[3], 'Tea/1.0.0 (Android 13; OnePlus 11)', '10.0.0.44'::inet, NOW() - interval '5 days', NOW() - interval '30 minutes'
  WHERE NOT EXISTS (SELECT 1 FROM auth.user_sessions WHERE user_id = u[3]);
END $$;

-- ---------------------------------------------------------------------------
-- 4. Feed: more prompts, spread over the last week, with likes and comments
-- ---------------------------------------------------------------------------
INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
SELECT u.id, v.mode, v.category, v.question, NOW() - (v.hours_ago * interval '1 hour')
FROM (VALUES
  ('demo13@friendzy.local','friends','✍🏻 Writing','What’s a hobby you picked up this year that stuck?', 2),
  ('demo14@friendzy.local','friends','💪 Gym & Fitness','Best running route in Bengaluru that isn’t Cubbon Park?', 5),
  ('demo1@friendzy.local','partner','🍃 Nature','Beach person or mountain person — and why are you wrong?', 9),
  ('demo19@friendzy.local','partner','✍🏻 Writing','What song do you put on when you need to reset?', 14),
  ('demo18@friendzy.local','friends','📸 Photography','Phone camera or a real one? Convince me.', 20),
  ('demo16@friendzy.local','partner','🏝 Travel','One dish you’d travel across the country for?', 30),
  ('demo22@friendzy.local','friends','🙂 People','Hosting a game night Friday. What game should I not buy?', 41),
  ('demo21@friendzy.local','friends','🍃 Nature','Anyone else keeping plants alive purely out of spite?', 55),
  ('demo5@friendzy.local','partner','🏝 Travel','Solo trip you’d recommend to a first-timer?', 70),
  ('demo9@friendzy.local','friends','📸 Photography','Most underrated street food stall in the city?', 96)
) AS v(email, mode, category, question, hours_ago)
JOIN auth.users u ON u.email = v.email
WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts f WHERE f.author_id = u.id AND f.question = v.question);

-- Likes: each demo user likes a deterministic spread of other people's posts.
INSERT INTO dating.post_likes (post_id, user_id, created_at)
SELECT f.id, u.id, f.created_at + interval '20 minutes' + (n * interval '7 minutes')
FROM dating.feed_posts f
JOIN auth.users au ON au.id = f.author_id AND au.email LIKE 'demo%@friendzy.local'
JOIN LATERAL (
  SELECT x.id, x.n FROM (
    SELECT id, (regexp_replace(email, '\D', '', 'g'))::int AS n
    FROM auth.users WHERE email LIKE 'demo%@friendzy.local'
  ) x
  WHERE x.id <> f.author_id
    AND (x.n + (('x' || substr(f.id::text, 1, 6))::bit(24)::int)) % 3 = 0
) u ON TRUE
ON CONFLICT DO NOTHING;

-- Comments on a few posts
INSERT INTO dating.post_comments (post_id, user_id, body, created_at)
SELECT f.id, cu.id, v.body, f.created_at + (v.mins * interval '1 minute')
FROM (VALUES
  ('If you could live anywhere in the world, where would you pick?', 'demo1@friendzy.local',  'Lisbon. Tiles, trams, pastries. Done.', 40),
  ('If you could live anywhere in the world, where would you pick?', 'demo7@friendzy.local',  'Somewhere it rains and nobody minds.', 95),
  ('If you could live anywhere in the world, where would you pick?', 'demo14@friendzy.local', 'Wherever the trail starts at the front door.', 180),
  ('Who do you think will win the next World Cup?', 'demo3@friendzy.local',  'France. Fight me.', 30),
  ('Who do you think will win the next World Cup?', 'demo17@friendzy.local', 'Argentina back to back, calling it now.', 75),
  ('Best running route in Bengaluru that isn’t Cubbon Park?', 'demo1@friendzy.local',  'Sankey Tank loop before 6:30, after that it’s a queue.', 50),
  ('Best running route in Bengaluru that isn’t Cubbon Park?', 'demo20@friendzy.local', 'Kaikondrahalli lake if you like birds judging you.', 120),
  ('Beach person or mountain person — and why are you wrong?', 'demo5@friendzy.local',  'Beach, and I’m not wrong, I’m tanned.', 25),
  ('Beach person or mountain person — and why are you wrong?', 'demo3@friendzy.local',  'Mountains. Beaches are just wet deserts.', 60),
  ('Beach person or mountain person — and why are you wrong?', 'demo19@friendzy.local', 'Hill station with a bookshop. Best of both.', 130),
  ('Hosting a game night Friday. What game should I not buy?', 'demo12@friendzy.local', 'Monopoly, unless you want to end friendships.', 15),
  ('Hosting a game night Friday. What game should I not buy?', 'demo15@friendzy.local', 'Codenames is the safe pick. Also I’m free Friday 👀', 48),
  ('Most underrated street food stall in the city?', 'demo16@friendzy.local', 'The idli cart outside Malleshwaram station. No sign, huge line.', 33),
  ('What song do you put on when you need to reset?', 'demo20@friendzy.local', 'Anything by Prateek Kuhad and a long walk.', 22)
) AS v(question, email, body, mins)
JOIN dating.feed_posts f ON f.question = v.question
JOIN auth.users cu ON cu.email = v.email
WHERE NOT EXISTS (SELECT 1 FROM dating.post_comments c WHERE c.post_id = f.id AND c.user_id = cu.id AND c.body = v.body);
