-- Migration 016: Comprehensive Seed for Google Play Store QA Reviewer Account
-- Reviewer credentials: playstore@teadating.app / TeaReview2026!
-- User ID: 00000000-0000-0000-0000-000000000099 (@PlayReviewer)
-- Includes: Verified profile, 4 HD photos, authored dilemmas & advice posts,
-- multi-turn chat consultations with top advisors, consultation requests,
-- interactive notifications (follow requests, replies, likes), stories/quick notes, and follow graphs.

DO $$
DECLARE
  v_rev_id     UUID := '00000000-0000-0000-0000-000000000099'::uuid;
  v_marina_id  UUID := '00000000-0000-0000-0000-000000000001'::uuid;
  v_jack_id    UUID := '00000000-0000-0000-0000-000000000002'::uuid;
  v_sylvia_id  UUID := '00000000-0000-0000-0000-000000000003'::uuid;
  v_jessica_id UUID := '00000000-0000-0000-0000-000000000005'::uuid;
  v_edward_id  UUID := '00000000-0000-0000-0000-000000000006'::uuid;
  v_michael_id UUID := '00000000-0000-0000-0000-000000000007'::uuid;
  v_maria_id   UUID := '00000000-0000-0000-0000-000000000008'::uuid;
  v_libby_id   UUID := '00000000-0000-0000-0000-000000000009'::uuid;

  v_m_marina   UUID;
  v_m_jack     UUID;
  v_m_sylvia   UUID;
  v_m_jessica  UUID;

  v_c_marina   UUID := 'd0000000-0000-0000-0000-000000000091'::uuid;
  v_c_jack     UUID := 'd0000000-0000-0000-0000-000000000092'::uuid;
  v_c_sylvia   UUID := 'd0000000-0000-0000-0000-000000000093'::uuid;
  v_c_jessica  UUID := 'd0000000-0000-0000-0000-000000000094'::uuid;

  v_post_1     UUID := 'a0000000-0000-0000-0000-000000000091'::uuid;
  v_post_2     UUID := 'a0000000-0000-0000-0000-000000000092'::uuid;

  v_now        TIMESTAMPTZ := NOW();
BEGIN
  -- 1. Ensure Reviewer in auth.users
  INSERT INTO auth.users (id, email, password_hash, name, handle, birthday, phone, email_verified)
  VALUES (
    v_rev_id,
    'playstore@teadating.app',
    crypt('TeaReview2026!', gen_salt('bf', 10)),
    'Tea Reviewer',
    'PlayReviewer',
    DATE '1995-01-01',
    '+1 555-0199',
    TRUE
  )
  ON CONFLICT (id) DO UPDATE SET
    email = EXCLUDED.email,
    password_hash = crypt('TeaReview2026!', gen_salt('bf', 10)),
    name = EXCLUDED.name,
    handle = EXCLUDED.handle,
    birthday = EXCLUDED.birthday,
    email_verified = TRUE;

  -- 2. Ensure dating profile is complete, verified 18+, top rank
  INSERT INTO dating.profiles (
    user_id, display_name, handle, gender, looking_for, intent, birthday,
    city, country, lat, lng, min_age, max_age, max_distance_km,
    about, rank_title, helpful_rating, followers_count, following_count,
    posts_count, advice_given_count, specialty, recent_advice_quote,
    interests, onboarding_complete, last_active_at
  )
  VALUES (
    v_rev_id,
    'Tea Reviewer',
    'PlayReviewer',
    'woman',
    ARRAY['man', 'woman']::text[],
    'both',
    DATE '1995-01-01',
    'Bengaluru',
    'India',
    12.9716,
    77.5946,
    18,
    45,
    100,
    'Official Google Play QA Reviewer Account for Tea: Brutalist Dating Advice. Certified advisor testing community dilemmas, verdict voting, and 1-on-1 consultations.',
    'Master Advisor 🫖',
    99,
    1420,
    68,
    14,
    92,
    'Situationships & Mixed Signals',
    'Candid reality checks, crowd-sourced verdicts, and zero fluff.',
    ARRAY['🚩 Red Flags', '☕ First Date', '🤔 Am I Overreacting?', '💡 Dating Advice']::text[],
    TRUE,
    v_now
  )
  ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name,
    handle = EXCLUDED.handle,
    gender = EXCLUDED.gender,
    looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent,
    birthday = EXCLUDED.birthday,
    city = EXCLUDED.city,
    lat = EXCLUDED.lat,
    lng = EXCLUDED.lng,
    onboarding_complete = TRUE,
    rank_title = EXCLUDED.rank_title,
    helpful_rating = EXCLUDED.helpful_rating,
    followers_count = EXCLUDED.followers_count,
    following_count = EXCLUDED.following_count,
    posts_count = EXCLUDED.posts_count,
    advice_given_count = EXCLUDED.advice_given_count,
    specialty = EXCLUDED.specialty,
    recent_advice_quote = EXCLUDED.recent_advice_quote,
    interests = EXCLUDED.interests;

  -- 3. Reviewer Photos
  DELETE FROM dating.photos WHERE user_id = v_rev_id;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES
    (v_rev_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=600&auto=format&fit=crop&q=80', 0),
    (v_rev_id, 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=600&auto=format&fit=crop&q=80', 1),
    (v_rev_id, 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=600&auto=format&fit=crop&q=80', 2),
    (v_rev_id, 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=600&auto=format&fit=crop&q=80', 3);

  -- 4. Authored Feed Posts / Dilemmas
  INSERT INTO dating.feed_posts (id, author_id, mode, category, title, question, red_flags, green_flags, valid_count, helpful_count, created_at)
  VALUES
    (
      v_post_1,
      v_rev_id,
      'advice',
      '☕ First Date',
      'He offered to split the bill on a dinner date he chose',
      'We went to an upscale Italian restaurant he insisted on picking. When the check arrived, he immediately asked the waiter for separate checks. Is this a red flag or fair modern dating?',
      42, 12, 68, 55,
      v_now - INTERVAL '2 days'
    ),
    (
      v_post_2,
      v_rev_id,
      'spill',
      '🚩 Red Flags',
      'Still FaceTimes his ex every night "as friends"',
      'He says they broke up 2 years ago and have no romantic feelings, but they FaceTime every evening to catch up. Am I overreacting to be uncomfortable with this boundary?',
      89, 3, 14, 76,
      v_now - INTERVAL '1 day'
    )
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    question = EXCLUDED.question,
    red_flags = EXCLUDED.red_flags,
    green_flags = EXCLUDED.green_flags,
    valid_count = EXCLUDED.valid_count,
    helpful_count = EXCLUDED.helpful_count;

  -- Comments on Reviewer Post 1
  DELETE FROM dating.post_comments WHERE post_id IN (v_post_1, v_post_2);
  INSERT INTO dating.post_comments (post_id, user_id, body, advisor_rank, helpful_count, is_top_advice, created_at)
  VALUES
    (
      v_post_1,
      v_marina_id,
      'Whoever insists on a pricey venue should offer to cover or at least communicate beforehand. Red flag if he pressured you to order.',
      'Certified Tea Advisor 🏆',
      34,
      TRUE,
      v_now - INTERVAL '1 day 20 hours'
    ),
    (
      v_post_1,
      v_jack_id,
      'From a guy''s perspective: if he chose it to impress you, then splitting without asking first shows poor planning and mixed signals.',
      'Senior Advisor ★',
      22,
      FALSE,
      v_now - INTERVAL '1 day 18 hours'
    ),
    (
      v_post_1,
      v_sylvia_id,
      'Setting financial expectations on date 1 is critical. Not necessarily a dealbreaker, but reveals his communication style.',
      'Tea Master 🫖',
      18,
      FALSE,
      v_now - INTERVAL '1 day 10 hours'
    ),
    (
      v_post_2,
      v_jessica_id,
      'Daily FaceTime with an ex is an emotional relationship. You are completely valid in holding that boundary.',
      'Dating Strategist ✨',
      56,
      TRUE,
      v_now - INTERVAL '18 hours'
    ),
    (
      v_post_2,
      v_edward_id,
      'Huge red flag. He hasn''t fully untangled from that past dynamic.',
      'Advisor',
      29,
      FALSE,
      v_now - INTERVAL '12 hours'
    );

  -- Votes on Reviewer Posts
  DELETE FROM dating.post_votes WHERE post_id IN (v_post_1, v_post_2);
  INSERT INTO dating.post_votes (post_id, user_id, vote)
  VALUES
    (v_post_1, v_marina_id, 'valid'),
    (v_post_1, v_jack_id, 'red'),
    (v_post_1, v_sylvia_id, 'valid'),
    (v_post_2, v_jessica_id, 'red'),
    (v_post_2, v_edward_id, 'red')
  ON CONFLICT (post_id, user_id) DO UPDATE SET vote = EXCLUDED.vote;

  -- 5. Mutual Matches & Consultations with Top Advisors
  -- Clean existing matches involving reviewer to rebuild cleanly
  DELETE FROM dating.matches WHERE user_a = v_rev_id OR user_b = v_rev_id;

  -- Match 1: Marina & Reviewer
  INSERT INTO dating.matches (user_a, user_b, created_at)
  VALUES (LEAST(v_marina_id, v_rev_id), GREATEST(v_marina_id, v_rev_id), v_now - INTERVAL '5 days')
  RETURNING id INTO v_m_marina;

  -- Match 2: Jack & Reviewer
  INSERT INTO dating.matches (user_a, user_b, created_at)
  VALUES (LEAST(v_jack_id, v_rev_id), GREATEST(v_jack_id, v_rev_id), v_now - INTERVAL '4 days')
  RETURNING id INTO v_m_jack;

  -- Match 3: Sylvia & Reviewer
  INSERT INTO dating.matches (user_a, user_b, created_at)
  VALUES (LEAST(v_sylvia_id, v_rev_id), GREATEST(v_sylvia_id, v_rev_id), v_now - INTERVAL '3 days')
  RETURNING id INTO v_m_sylvia;

  -- Match 4: Jessica & Reviewer (Pending Consultation Request)
  INSERT INTO dating.matches (user_a, user_b, created_at)
  VALUES (LEAST(v_jessica_id, v_rev_id), GREATEST(v_jessica_id, v_rev_id), v_now - INTERVAL '1 day')
  RETURNING id INTO v_m_jessica;

  -- Conversations
  -- Delete old conversations for reviewer
  DELETE FROM dating.conversations WHERE user_a = v_rev_id OR user_b = v_rev_id;

  -- Conversation with Marina
  INSERT INTO dating.conversations (id, match_id, user_a, user_b, last_preview, last_message_at, last_sender_id, request_status, created_at)
  VALUES (
    v_c_marina,
    v_m_marina,
    LEAST(v_marina_id, v_rev_id),
    GREATEST(v_marina_id, v_rev_id),
    'Agreed! Clarity is kindness in dating. Talk soon! ☕',
    v_now - INTERVAL '15 minutes',
    v_marina_id,
    'active',
    v_now - INTERVAL '5 days'
  );

  -- Conversation with Jack
  INSERT INTO dating.conversations (id, match_id, user_a, user_b, last_preview, last_message_at, last_sender_id, request_status, created_at)
  VALUES (
    v_c_jack,
    v_m_jack,
    LEAST(v_jack_id, v_rev_id),
    GREATEST(v_jack_id, v_rev_id),
    'Never double-text after midnight. Let him reach out.',
    v_now - INTERVAL '1 hour',
    v_jack_id,
    'active',
    v_now - INTERVAL '4 days'
  );

  -- Conversation with Sylvia
  INSERT INTO dating.conversations (id, match_id, user_a, user_b, last_preview, last_message_at, last_sender_id, request_status, created_at)
  VALUES (
    v_c_sylvia,
    v_m_sylvia,
    LEAST(v_sylvia_id, v_rev_id),
    GREATEST(v_sylvia_id, v_rev_id),
    'Setting boundaries early on saves months of heartache.',
    v_now - INTERVAL '3 hours',
    v_sylvia_id,
    'active',
    v_now - INTERVAL '3 days'
  );

  -- Conversation with Jessica (Consultation Request)
  INSERT INTO dating.conversations (id, match_id, user_a, user_b, last_preview, last_message_at, last_sender_id, request_status, created_at)
  VALUES (
    v_c_jessica,
    v_m_jessica,
    LEAST(v_jessica_id, v_rev_id),
    GREATEST(v_jessica_id, v_rev_id),
    'Hey, need urgent advice on a 4-month situationship!',
    v_now - INTERVAL '45 minutes',
    v_jessica_id,
    'request',
    v_now - INTERVAL '1 day'
  );

  -- Chat Messages
  INSERT INTO dating.messages (conversation_id, sender_id, body, created_at)
  VALUES
    -- Marina Thread
    (v_c_marina, v_rev_id, 'Hi Marina! Testing the consultation channel for Google Play QA audit.', v_now - INTERVAL '2 days'),
    (v_c_marina, v_marina_id, 'Welcome to Tea! Excited to have you review our brutalist dating advice flow.', v_now - INTERVAL '1 day'),
    (v_c_marina, v_rev_id, 'The crowd-sourced verdict voting and advisor badges feel really clean.', v_now - INTERVAL '2 hours'),
    (v_c_marina, v_marina_id, 'Agreed! Clarity is kindness in dating. Talk soon! ☕', v_now - INTERVAL '15 minutes'),

    -- Jack Thread
    (v_c_jack, v_rev_id, 'Hey Jack, what''s your take on ambiguous 11 PM text messages?', v_now - INTERVAL '4 hours'),
    (v_c_jack, v_jack_id, 'Classic low-effort convenience ping. Don''t take the bait!', v_now - INTERVAL '2 hours'),
    (v_c_jack, v_jack_id, 'Never double-text after midnight. Let him reach out.', v_now - INTERVAL '1 hour'),

    -- Sylvia Thread
    (v_c_sylvia, v_rev_id, 'Hi Sylvia, reviewing the advisor response workflow.', v_now - INTERVAL '6 hours'),
    (v_c_sylvia, v_sylvia_id, 'Hi there! I help people decode early relationship red flags.', v_now - INTERVAL '5 hours'),
    (v_c_sylvia, v_sylvia_id, 'Setting boundaries early on saves months of heartache.', v_now - INTERVAL '3 hours'),

    -- Jessica Request Thread
    (v_c_jessica, v_jessica_id, 'Hey, need urgent advice on a 4-month situationship!', v_now - INTERVAL '45 minutes');

  -- Message reads (Marina is UNREAD, Jack & Sylvia READ)
  DELETE FROM dating.message_reads WHERE user_id = v_rev_id;
  INSERT INTO dating.message_reads (conversation_id, user_id, last_read_at)
  VALUES
    (v_c_marina, v_rev_id, v_now - INTERVAL '1 hour'),
    (v_c_jack, v_rev_id, v_now),
    (v_c_sylvia, v_rev_id, v_now);

  -- 6. Notifications for Reviewer
  DELETE FROM dating.notifications WHERE user_id = v_rev_id;
  INSERT INTO dating.notifications (
    user_id, actor_id, actor_name, actor_handle, type, text,
    post_id, post_snippet, post_category, read, confirmed, created_at
  )
  VALUES
    (
      v_rev_id,
      v_michael_id,
      'Michael',
      'Michael_01',
      'follow_request',
      'requested to follow you.',
      NULL, NULL, NULL,
      FALSE, FALSE,
      v_now - INTERVAL '20 minutes'
    ),
    (
      v_rev_id,
      v_edward_id,
      'Edward Miller',
      'Edward_M',
      'follow_request',
      'requested to follow you.',
      NULL, NULL, NULL,
      FALSE, FALSE,
      v_now - INTERVAL '1 hour'
    ),
    (
      v_rev_id,
      v_jack_id,
      'Jack James',
      'Jack.James',
      'like',
      'liked your post: He offered to split the bill on a dinner date he chose',
      v_post_1,
      'He offered to split the bill on a dinner date',
      '☕ First Date',
      FALSE, TRUE,
      v_now - INTERVAL '2 hours'
    ),
    (
      v_rev_id,
      v_sylvia_id,
      'Sylvia Agostino',
      'Sylvia_A',
      'advice_reply',
      'replied: "Whoever insists on a pricey venue should communicate beforehand."',
      v_post_1,
      'He offered to split the bill',
      '☕ First Date',
      TRUE, TRUE,
      v_now - INTERVAL '3 hours'
    ),
    (
      v_rev_id,
      v_libby_id,
      'Libby Liz',
      'Libby_liz',
      'follow',
      'started following you.',
      NULL, NULL, NULL,
      TRUE, TRUE,
      v_now - INTERVAL '1 day'
    );

  -- 7. Stories / Quick Notes
  DELETE FROM dating.quick_notes WHERE user_id = v_rev_id;
  INSERT INTO dating.quick_notes (user_id, author, name, note, emoji, created_at)
  VALUES (
    v_rev_id,
    'Tea Reviewer',
    'PlayReviewer',
    'Mixed signals are always a NO. Energy and clarity speak louder than words. 🫖',
    '🫖',
    v_now - INTERVAL '2 hours'
  );

  -- 8. Follows
  DELETE FROM dating.follows WHERE follower_id = v_rev_id OR following_id = v_rev_id;
  INSERT INTO dating.follows (follower_id, following_id, status)
  VALUES
    (v_rev_id, v_marina_id, 'active'),
    (v_rev_id, v_jack_id, 'active'),
    (v_rev_id, v_sylvia_id, 'active'),
    (v_rev_id, v_jessica_id, 'active'),
    (v_libby_id, v_rev_id, 'active'),
    (v_maria_id, v_rev_id, 'active'),
    (v_michael_id, v_rev_id, 'pending'),
    (v_edward_id, v_rev_id, 'pending');

  -- 9. Clear Swipes so Discover Deck is fresh with 20+ nearby cards
  DELETE FROM dating.swipes WHERE from_user_id = v_rev_id;

END $$;
