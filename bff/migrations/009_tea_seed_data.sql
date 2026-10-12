-- Migration 009: Seed Tea Dating Advice Data
-- Rich authentic seed data for users, top advisors, dilemmas, advice comments, votes, notes, conversations, and notifications.

-- Relax check constraints from 004 to accommodate Tea dating advice modes and intents
ALTER TABLE dating.feed_posts DROP CONSTRAINT IF EXISTS feed_posts_mode_check;
ALTER TABLE dating.feed_posts ADD CONSTRAINT feed_posts_mode_check
  CHECK (mode IN ('advice', 'spill', 'all', 'friends', 'partner'));

ALTER TABLE dating.profiles DROP CONSTRAINT IF EXISTS profiles_intent_chk;
ALTER TABLE dating.profiles ADD CONSTRAINT profiles_intent_chk
  CHECK (intent IN ('seeking', 'giving', 'both', 'friends', 'partner'));

-- ---------------------------------------------------------------------------
-- 1. Insert Tea Users (Password: demo1234)
-- ---------------------------------------------------------------------------
WITH tea_users (id, email, name, handle, birthday, phone, city, country, about, rank_title, followers, following, posts, rating, quote, specialty, interests) AS (
  VALUES
    (
      '00000000-0000-0000-0000-000000000001'::uuid,
      'marina@teadating.app',
      'Marina Jose',
      'Marina_Jose',
      DATE '1998-05-14',
      '+1 555-0199',
      'New York',
      'USA',
      'Dating coach & brutal truth teller. Here to save you from 6-month situationships.',
      'Certified Tea Advisor 🏆',
      5678,
      9101,
      1234,
      98,
      'If he wanted to, he would. Stop making excuses for bare minimum effort.',
      'Situationships & Mixed Signals',
      ARRAY['🚩 Red Flags', '☕ First Date', '🤔 Am I Overreacting?', '💡 Dating Advice']
    ),
    (
      '00000000-0000-0000-0000-000000000002'::uuid,
      'jack@teadating.app',
      'Jack James',
      'Jack.James',
      DATE '1996-03-22',
      '+44 20 7946 0912',
      'London',
      'UK',
      'Men’s perspective decoded. I tell you what his texts actually mean.',
      'Senior Advisor ★',
      4210,
      89,
      890,
      96,
      'If he only texts after 10 PM, you are not his roster priority, you are his convenience.',
      'Texting Psychology',
      ARRAY['📱 Texting Rules', '👻 Ghosted', '🚩 Red Flags']
    ),
    (
      '00000000-0000-0000-0000-000000000003'::uuid,
      'sylvia@teadating.app',
      'Sylvia Agostino',
      'Sylvia_A',
      DATE '1997-11-08',
      '+39 06 698 12345',
      'Rome',
      'Italy',
      'Relationship therapist in training. Helping you spot narcissists before date 3.',
      'Tea Master 🫖',
      3890,
      152,
      654,
      95,
      'Notice how they react when you set a small, healthy boundary. That tells you everything.',
      'Red Flags & Boundaries',
      ARRAY['🚩 Red Flags', '💚 Green Flags', '💡 Dating Advice']
    ),
    (
      '00000000-0000-0000-0000-000000000004'::uuid,
      'williams@teadating.app',
      'Williams K',
      'Williams_K',
      DATE '1992-07-19',
      '+1 312 555 0144',
      'Chicago',
      'USA',
      'Married 12 years. Providing grounded advice in a sea of toxic modern dating games.',
      'Dating Sage 🦉',
      3120,
      76,
      512,
      97,
      'Chemistry is a spark, but emotional safety is the fireplace. Don’t settle for just smoke.',
      'Long-term Compatibility',
      ARRAY['💔 Breakups', '✨ Relationship Goals', '💡 Dating Advice']
    ),
    (
      '00000000-0000-0000-0000-000000000005'::uuid,
      'jessica@teadating.app',
      'Jessica Cole',
      'Jessica_09',
      DATE '1999-01-30',
      '+1 416 555 0188',
      'Toronto',
      'Canada',
      'No games, no drama. Rules for high-value first dates and healthy vetting.',
      'Dating Strategist ✨',
      2780,
      110,
      420,
      94,
      'Never accept a last-minute Friday night invite as your first date.',
      'First Dates & Standards',
      ARRAY['☕ First Date', '🚩 Red Flags', '🫖 Spill The Tea']
    ),
    (
      '00000000-0000-0000-0000-000000000006'::uuid,
      'edward@teadating.app',
      'Edward Miller',
      'Edward_M',
      DATE '1995-09-14',
      '+49 30 1234567',
      'Berlin',
      'Germany',
      'Direct, honest, constructive advice. You deserve clear answers.',
      'Advisor 💡',
      2190,
      95,
      340,
      93,
      'When someone shows you who they are the first time, believe them.',
      'Breakups & Healing',
      ARRAY['💔 Breakups', '💡 Dating Advice']
    ),
    (
      '00000000-0000-0000-0000-000000000007'::uuid,
      'michael@teadating.app',
      'Michael',
      'Michael_01',
      DATE '1997-04-12',
      '+44 20 7946 0999',
      'London',
      'UK',
      'Seeking advice after getting out of a 4-year relationship.',
      'Tea Seeker 🔍',
      480,
      210,
      45,
      91,
      'Trying to navigate the modern dating scene without losing my mind.',
      'Modern Dating',
      ARRAY['☕ First Date', '🤔 Am I Overreacting?']
    ),
    (
      '00000000-0000-0000-0000-000000000008'::uuid,
      'maria@teadating.app',
      'Maria Jones',
      'Maria_Jones',
      DATE '1998-08-25',
      '+1 415 555 0177',
      'San Francisco',
      'USA',
      'Spilling dating stories and analyzing text red flags.',
      'Tea Contributor 🍵',
      920,
      340,
      112,
      93,
      'If he leaves you on delivered for 12 hours, you are not busy, you are deprioritized.',
      'Text Red Flags',
      ARRAY['🚩 Red Flags', '📱 Texting Rules', '🫖 Spill The Tea']
    ),
    (
      '00000000-0000-0000-0000-000000000009'::uuid,
      'libby@teadating.app',
      'Libby Liz',
      'Libby_liz',
      DATE '2000-02-17',
      '+61 2 9876 5432',
      'Sydney',
      'Australia',
      'Here for the brutal tea and honest reality checks.',
      'Tea Seeker 🔍',
      310,
      180,
      28,
      90,
      'Learning to stop romanticizing potential.',
      'Ghosting & Red Flags',
      ARRAY['👻 Ghosted', '🚩 Red Flags']
    ),
    (
      '00000000-0000-0000-0000-000000000010'::uuid,
      'emily@teadating.app',
      'Emily Johnson',
      'Emiley_J',
      DATE '1999-12-03',
      '+33 1 42 68 55 55',
      'Paris',
      'France',
      'Sharing first date debriefs and looking for honest feedback.',
      'Tea Contributor 🍵',
      640,
      290,
      64,
      92,
      'First dates should feel like conversations, not job interviews.',
      'First Dates',
      ARRAY['☕ First Date', '✨ Relationship Goals']
    ),
    (
      '00000000-0000-0000-0000-000000000099'::uuid,
      'playstore@teadating.app',
      'Tea Reviewer',
      'PlayReviewer',
      DATE '1995-01-01',
      '+1 555-0199',
      'San Francisco',
      'USA',
      'Google Play Console QA Review Account for Tea Brutalist Dating Advice.',
      'Master Advisor 🫖',
      1820,
      140,
      68,
      99,
      'Candid reality checks, crowd-sourced verdicts, and no fluff.',
      'Situationships & First Dates',
      ARRAY['🚩 Red Flags', '☕ First Date', '🤔 Am I Overreacting?', '💡 Dating Advice']
    )
),
ins_users AS (
  INSERT INTO auth.users (id, email, password_hash, name, handle, birthday, phone, email_verified)
  SELECT
    id,
    email,
    CASE
      WHEN email = 'playstore@teadating.app' THEN crypt('TeaReview2026!', gen_salt('bf', 10))
      ELSE crypt('demo1234', gen_salt('bf', 10))
    END,
    name,
    handle,
    birthday,
    phone,
    TRUE
  FROM tea_users
  ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    handle = EXCLUDED.handle,
    birthday = EXCLUDED.birthday,
    phone = EXCLUDED.phone
  RETURNING id, email
)
INSERT INTO dating.profiles (
  user_id, display_name, handle, gender, looking_for, intent, birthday, city, country,
  about, interests, rank_title, followers_count, following_count, posts_count,
  helpful_rating, specialty, recent_advice_quote, onboarding_complete, last_active_at
)
SELECT
  t.id, t.name, t.handle, 'other', ARRAY['seeking', 'giving'], 'both', t.birthday, t.city, t.country,
  t.about, t.interests, t.rank_title, t.followers, t.following, t.posts,
  t.rating, t.specialty, t.quote, TRUE, NOW()
FROM tea_users t
ON CONFLICT (user_id) DO UPDATE SET
  display_name = EXCLUDED.display_name,
  handle = EXCLUDED.handle,
  about = EXCLUDED.about,
  interests = EXCLUDED.interests,
  rank_title = EXCLUDED.rank_title,
  followers_count = EXCLUDED.followers_count,
  following_count = EXCLUDED.following_count,
  posts_count = EXCLUDED.posts_count,
  helpful_rating = EXCLUDED.helpful_rating,
  specialty = EXCLUDED.specialty,
  recent_advice_quote = EXCLUDED.recent_advice_quote;

-- ---------------------------------------------------------------------------
-- 2. Insert Dilemma Feed Posts
-- ---------------------------------------------------------------------------
INSERT INTO dating.feed_posts (
  id, author_id, mode, category, title, question,
  red_flags, green_flags, valid_count, helpful_count, created_at
)
VALUES
  (
    'a0000000-0000-0000-0000-000000000001'::uuid,
    '00000000-0000-0000-0000-000000000002'::uuid, -- Jack James
    'advice',
    '🤔 Am I Overreacting?',
    'He hasn’t texted for 48 hours after an amazing 3rd date. What should I do?',
    'We had an incredible dinner, he talked about our future plans for next weekend, and kissed me goodnight. Since Monday morning, radio silence. Not even a "good morning" or "hope your week is good". Am I overreacting, or should I reach out first?',
    65, 12, 23, 96,
    NOW() - INTERVAL '30 minutes'
  ),
  (
    'a0000000-0000-0000-0000-000000000002'::uuid,
    '00000000-0000-0000-0000-000000000001'::uuid, -- Marina Jose
    'advice',
    '☕ First Date',
    'Splitting the bill on the first date: my golden rule that never fails',
    'Here is the brutal truth on first date bills: Whoever initiated the date should always offer to pay. However, the other person must ALWAYS make a genuine offer to split. If they don’t even reach for their wallet or say thank you, that is an immediate entitlement test failed. Thoughts?',
    18, 140, 15, 210,
    NOW() - INTERVAL '2 hours'
  ),
  (
    'a0000000-0000-0000-0000-000000000003'::uuid,
    '00000000-0000-0000-0000-000000000005'::uuid, -- Jessica Cole
    'spill',
    '🚩 Red Flags',
    'Spill: He said he’s "not looking for anything serious" 3 months in 🚩',
    'We’ve been acting like boyfriend and girlfriend for 90 days. Cooking together, meeting his friends, staying over 4 nights a week. Last night I asked where this was going and he said: "I really like you but I’m just not in a place for a relationship right now." What does this actually mean?!',
    180, 4, 8, 310,
    NOW() - INTERVAL '4 hours'
  ),
  (
    'a0000000-0000-0000-0000-000000000004'::uuid,
    '00000000-0000-0000-0000-000000000004'::uuid, -- Williams K
    'advice',
    '💔 Breakups',
    'Why you should NEVER stalk an ex on social media: a psychological reality check',
    'Every time you check their follower count, their stories, or who commented on their new post, your brain resets the breakup grief timer to Day 1. You are actively seeking pain. Block them or mute them completely if you actually want to heal.',
    5, 190, 12, 350,
    NOW() - INTERVAL '8 hours'
  ),
  (
    'a0000000-0000-0000-0000-000000000005'::uuid,
    '00000000-0000-0000-0000-000000000003'::uuid, -- Sylvia Agostino
    'advice',
    '💚 Green Flags',
    'Green flags people overlook: consistency beats grand romantic gestures every time',
    'Watch out for the difference between a love bomber and a consistent partner. A green flag isn’t expensive roses on week one. It’s someone who calls when they said they would, respects your bedtime, and remembers how you take your coffee.',
    2, 240, 8, 430,
    NOW() - INTERVAL '14 hours'
  )
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  question = EXCLUDED.question,
  red_flags = EXCLUDED.red_flags,
  green_flags = EXCLUDED.green_flags,
  valid_count = EXCLUDED.valid_count,
  helpful_count = EXCLUDED.helpful_count;

-- ---------------------------------------------------------------------------
-- 3. Insert Post Verdict Votes & Likes & Saves
-- ---------------------------------------------------------------------------
INSERT INTO dating.post_votes (post_id, user_id, vote)
VALUES
  ('a0000000-0000-0000-0000-000000000001'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'red'),
  ('a0000000-0000-0000-0000-000000000002'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'green'),
  ('a0000000-0000-0000-0000-000000000003'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'red'),
  ('a0000000-0000-0000-0000-000000000004'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'green'),
  ('a0000000-0000-0000-0000-000000000005'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'green')
ON CONFLICT (post_id, user_id) DO UPDATE SET vote = EXCLUDED.vote;

INSERT INTO dating.post_likes (post_id, user_id)
VALUES
  ('a0000000-0000-0000-0000-000000000001'::uuid, '00000000-0000-0000-0000-000000000001'::uuid),
  ('a0000000-0000-0000-0000-000000000003'::uuid, '00000000-0000-0000-0000-000000000001'::uuid),
  ('a0000000-0000-0000-0000-000000000005'::uuid, '00000000-0000-0000-0000-000000000001'::uuid)
ON CONFLICT (post_id, user_id) DO NOTHING;

INSERT INTO dating.post_saves (post_id, user_id)
VALUES
  ('a0000000-0000-0000-0000-000000000002'::uuid, '00000000-0000-0000-0000-000000000001'::uuid),
  ('a0000000-0000-0000-0000-000000000004'::uuid, '00000000-0000-0000-0000-000000000001'::uuid)
ON CONFLICT (post_id, user_id) DO NOTHING;

-- ---------------------------------------------------------------------------
-- 4. Insert Comments & Top Advice
-- ---------------------------------------------------------------------------
INSERT INTO dating.post_comments (
  id, post_id, user_id, body, advisor_rank, helpful_count, is_top_advice, created_at
)
VALUES
  (
    'c0000000-0000-0000-0000-000000000001'::uuid,
    'a0000000-0000-0000-0000-000000000001'::uuid,
    '00000000-0000-0000-0000-000000000001'::uuid, -- Marina Jose
    'Do not text him. If a guy is genuinely interested after date 3, he will not leave room for another man to step in. 48h silence is communication in itself.',
    'Certified Tea Advisor 🏆',
    45, TRUE,
    NOW() - INTERVAL '25 minutes'
  ),
  (
    'c0000000-0000-0000-0000-000000000002'::uuid,
    'a0000000-0000-0000-0000-000000000001'::uuid,
    '00000000-0000-0000-0000-000000000004'::uuid, -- Williams K
    'Match his energy. If he takes 2 days to text, don’t reply within 2 minutes. Focus on your life and your hobbies.',
    'Dating Sage 🦉',
    28, FALSE,
    NOW() - INTERVAL '15 minutes'
  ),
  (
    'c0000000-0000-0000-0000-000000000003'::uuid,
    'a0000000-0000-0000-0000-000000000001'::uuid,
    '00000000-0000-0000-0000-000000000006'::uuid, -- Edward Miller
    'Give him the benefit of the doubt until Friday. If no plan is made for the weekend, archive and move forward.',
    'Advisor 💡',
    16, FALSE,
    NOW() - INTERVAL '8 minutes'
  ),
  (
    'c0000000-0000-0000-0000-000000000004'::uuid,
    'a0000000-0000-0000-0000-000000000002'::uuid,
    '00000000-0000-0000-0000-000000000006'::uuid, -- Edward Miller
    '100% agreed. It’s not about the money, it is about basic manners and consideration.',
    'Advisor 💡',
    52, TRUE,
    NOW() - INTERVAL '1 hour 45 minutes'
  ),
  (
    'c0000000-0000-0000-0000-000000000005'::uuid,
    'a0000000-0000-0000-0000-000000000003'::uuid,
    '00000000-0000-0000-0000-000000000003'::uuid, -- Sylvia Agostino
    'It means he wants all relationship benefits with zero accountability. Walk away immediately and watch how fast he panics.',
    'Tea Master 🫖',
    88, TRUE,
    NOW() - INTERVAL '3 hours 30 minutes'
  ),
  (
    'c0000000-0000-0000-0000-000000000006'::uuid,
    'a0000000-0000-0000-0000-000000000004'::uuid,
    '00000000-0000-0000-0000-000000000002'::uuid, -- Jack James
    'Out of sight, out of mind. The peace of mind you get after a 30-day digital detox is unmatched.',
    'Senior Advisor ★',
    64, TRUE,
    NOW() - INTERVAL '7 hours'
  ),
  (
    'c0000000-0000-0000-0000-000000000007'::uuid,
    'a0000000-0000-0000-0000-000000000005'::uuid,
    '00000000-0000-0000-0000-000000000001'::uuid, -- Marina Jose
    'Consistency is peaceful, but people addicted to chaos often mistake peace for boredom. Learn to love the calm.',
    'Certified Tea Advisor 🏆',
    78, TRUE,
    NOW() - INTERVAL '13 hours'
  )
ON CONFLICT (id) DO UPDATE SET
  body = EXCLUDED.body,
  helpful_count = EXCLUDED.helpful_count,
  is_top_advice = EXCLUDED.is_top_advice;

-- ---------------------------------------------------------------------------
-- 5. Insert Quick Status Notes (Feed Rail)
-- ---------------------------------------------------------------------------
INSERT INTO dating.quick_notes (id, user_id, author, name, note, emoji, created_at)
VALUES
  ('bb000000-0000-0000-0000-000000000001'::uuid, '00000000-0000-0000-0000-000000000002'::uuid, 'Jack.James', 'Jack.James', 'Heya!', '🙌', NOW() - INTERVAL '1 hour'),
  ('bb000000-0000-0000-0000-000000000002'::uuid, '00000000-0000-0000-0000-000000000004'::uuid, 'Williams_', 'Williams_', 'Love', '❤️', NOW() - INTERVAL '2 hours'),
  ('bb000000-0000-0000-0000-000000000003'::uuid, '00000000-0000-0000-0000-000000000006'::uuid, 'Alex.B', 'Alex.B', 'I feel it coming!', '🔥', NOW() - INTERVAL '3 hours'),
  ('bb000000-0000-0000-0000-000000000004'::uuid, '00000000-0000-0000-0000-000000000003'::uuid, 'Sylvia_A', 'Sylvia_A', 'Trust your gut 🚩', '👀', NOW() - INTERVAL '4 hours'),
  ('bb000000-0000-0000-0000-000000000005'::uuid, '00000000-0000-0000-0000-000000000005'::uuid, 'Jessica_09', 'Jessica_09', 'Never double text!', '📵', NOW() - INTERVAL '5 hours')
ON CONFLICT (id) DO NOTHING;


-- ---------------------------------------------------------------------------
-- 6. Insert Fan Follows
-- ---------------------------------------------------------------------------
INSERT INTO dating.follows (follower_id, following_id, status)
VALUES
  ('00000000-0000-0000-0000-000000000001'::uuid, '00000000-0000-0000-0000-000000000002'::uuid, 'active'), -- Marina follows Jack
  ('00000000-0000-0000-0000-000000000001'::uuid, '00000000-0000-0000-0000-000000000005'::uuid, 'active'), -- Marina follows Jessica
  ('00000000-0000-0000-0000-000000000007'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'active'), -- Michael follows Marina
  ('00000000-0000-0000-0000-000000000006'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'active'), -- Edward follows Marina
  ('00000000-0000-0000-0000-000000000009'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'active'), -- Libby follows Marina
  ('00000000-0000-0000-0000-000000000008'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'active'), -- Maria follows Marina
  ('00000000-0000-0000-0000-000000000004'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'pending'), -- Williams pending request
  ('00000000-0000-0000-0000-000000000010'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'pending')  -- Emily pending request
ON CONFLICT (follower_id, following_id) DO NOTHING;

-- ---------------------------------------------------------------------------
-- 7. Insert Chat Matches, Conversations, and Dialog Messages
-- ---------------------------------------------------------------------------
-- Match between Marina (user 1) and Sylvia (user 3)
INSERT INTO dating.matches (id, user_a, user_b, created_at)
VALUES (
  'ba000000-0000-0000-0000-000000000001'::uuid,
  '00000000-0000-0000-0000-000000000001'::uuid,
  '00000000-0000-0000-0000-000000000003'::uuid,
  NOW() - INTERVAL '1 day'
)
ON CONFLICT (user_a, user_b) DO NOTHING;

INSERT INTO dating.conversations (
  id, match_id, user_a, user_b, last_message_at, last_preview, last_sender_id, request_status
)
VALUES (
  'd0000000-0000-0000-0000-000000000001'::uuid,
  'ba000000-0000-0000-0000-000000000001'::uuid,
  '00000000-0000-0000-0000-000000000001'::uuid,
  '00000000-0000-0000-0000-000000000003'::uuid,
  NOW() - INTERVAL '10 minutes',
  'Everyone is doing good.',
  '00000000-0000-0000-0000-000000000003'::uuid,
  'active'
)
ON CONFLICT (match_id) DO NOTHING;

-- Sylvia dialog messages matching Brutalist chat HTML snippet
INSERT INTO dating.messages (id, conversation_id, sender_id, body, created_at)
VALUES
  ('e0000000-0000-0000-0000-000000000001'::uuid, 'd0000000-0000-0000-0000-000000000001'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'Hello!', NOW() - INTERVAL '18 minutes'),
  ('e0000000-0000-0000-0000-000000000002'::uuid, 'd0000000-0000-0000-0000-000000000001'::uuid, '00000000-0000-0000-0000-000000000003'::uuid, 'Hello marina!', NOW() - INTERVAL '17 minutes'),
  ('e0000000-0000-0000-0000-000000000003'::uuid, 'd0000000-0000-0000-0000-000000000001'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'How are you sylvia?', NOW() - INTERVAL '16 minutes'),
  ('e0000000-0000-0000-0000-000000000004'::uuid, 'd0000000-0000-0000-0000-000000000001'::uuid, '00000000-0000-0000-0000-000000000003'::uuid, 'I’m good, how about you?', NOW() - INTERVAL '15 minutes'),
  ('e0000000-0000-0000-0000-000000000005'::uuid, 'd0000000-0000-0000-0000-000000000001'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'I’m also good. Where are you nowadays?', NOW() - INTERVAL '14 minutes'),
  ('e0000000-0000-0000-0000-000000000006'::uuid, 'd0000000-0000-0000-0000-000000000001'::uuid, '00000000-0000-0000-0000-000000000003'::uuid, 'I’m in Italy, working there.', NOW() - INTERVAL '13 minutes'),
  ('e0000000-0000-0000-0000-000000000007'::uuid, 'd0000000-0000-0000-0000-000000000001'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'Oh great! How’s your family?', NOW() - INTERVAL '12 minutes'),
  ('e0000000-0000-0000-0000-000000000008'::uuid, 'd0000000-0000-0000-0000-000000000001'::uuid, '00000000-0000-0000-0000-000000000003'::uuid, 'Everyone is doing good.', NOW() - INTERVAL '11 minutes'),
  ('e0000000-0000-0000-0000-000000000009'::uuid, 'd0000000-0000-0000-0000-000000000001'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'Glad to hear that sylvia! :)', NOW() - INTERVAL '10 minutes')
ON CONFLICT (id) DO NOTHING;

-- Match & Conversation for Reviewer (user 99) with Marina (user 1)
INSERT INTO dating.matches (id, user_a, user_b, created_at)
VALUES (
  'ba000000-0000-0000-0000-000000000099'::uuid,
  '00000000-0000-0000-0000-000000000001'::uuid,
  '00000000-0000-0000-0000-000000000099'::uuid,
  NOW() - INTERVAL '2 days'
)
ON CONFLICT (user_a, user_b) DO NOTHING;

INSERT INTO dating.conversations (
  id, match_id, user_a, user_b, last_message_at, last_preview, last_sender_id, request_status
)
VALUES (
  'd0000000-0000-0000-0000-000000000099'::uuid,
  'ba000000-0000-0000-0000-000000000099'::uuid,
  '00000000-0000-0000-0000-000000000001'::uuid,
  '00000000-0000-0000-0000-000000000099'::uuid,
  NOW() - INTERVAL '5 minutes',
  'Welcome to Tea! Excited to share candid advice.',
  '00000000-0000-0000-0000-000000000001'::uuid,
  'active'
)
ON CONFLICT (match_id) DO NOTHING;

INSERT INTO dating.messages (id, conversation_id, sender_id, body, created_at)
VALUES
  ('e0000000-0000-0000-0000-000000000090'::uuid, 'd0000000-0000-0000-0000-000000000099'::uuid, '00000000-0000-0000-0000-000000000099'::uuid, 'Hey Marina, how does the 3-date rule work here?', NOW() - INTERVAL '15 minutes'),
  ('e0000000-0000-0000-0000-000000000091'::uuid, 'd0000000-0000-0000-0000-000000000099'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'Welcome to Tea! Excited to share candid advice. Look at actions, not words!', NOW() - INTERVAL '5 minutes')
ON CONFLICT (id) DO NOTHING;

-- ---------------------------------------------------------------------------
-- 8. Insert Notifications (Matching Brutalist Notifications UI)
-- ---------------------------------------------------------------------------
INSERT INTO dating.notifications (
  id, user_id, actor_id, actor_name, actor_handle, type, text,
  post_snippet, post_category, read, confirmed, created_at
)
VALUES
  (
    'f0000000-0000-0000-0000-000000000001'::uuid,
    '00000000-0000-0000-0000-000000000001'::uuid,
    '00000000-0000-0000-0000-000000000007'::uuid, -- Michael
    'Michael', 'Michael_01', 'follow', 'started following you.',
    NULL, NULL, FALSE, FALSE,
    NOW() - INTERVAL '1 hour'
  ),
  (
    'f0000000-0000-0000-0000-000000000002'::uuid,
    '00000000-0000-0000-0000-000000000001'::uuid,
    '00000000-0000-0000-0000-000000000006'::uuid, -- Edward
    'Edward', 'Edward_M', 'like', 'liked your post.',
    'Split $4 coffee on first date...', 'First Date', FALSE, FALSE,
    NOW() - INTERVAL '1 hour 15 minutes'
  ),
  (
    'f0000000-0000-0000-0000-000000000003'::uuid,
    '00000000-0000-0000-0000-000000000001'::uuid,
    '00000000-0000-0000-0000-000000000006'::uuid, -- Edward
    'Edward', 'Edward_M', 'follow', 'started following you.',
    NULL, NULL, FALSE, FALSE,
    NOW() - INTERVAL '1 hour 30 minutes'
  ),
  (
    'f0000000-0000-0000-0000-000000000004'::uuid,
    '00000000-0000-0000-0000-000000000001'::uuid,
    '00000000-0000-0000-0000-000000000009'::uuid, -- Libby
    'Libby', 'Libby_liz', 'like', 'liked your post.',
    'Never text twice in 12 hours...', 'Ghosting', TRUE, FALSE,
    NOW() - INTERVAL '2 hours'
  ),
  (
    'f0000000-0000-0000-0000-000000000005'::uuid,
    '00000000-0000-0000-0000-000000000001'::uuid,
    '00000000-0000-0000-0000-000000000009'::uuid, -- Libby
    'Libby', 'Libby_liz', 'follow', 'started following you.',
    NULL, NULL, TRUE, FALSE,
    NOW() - INTERVAL '2 hours 10 minutes'
  ),
  (
    'f0000000-0000-0000-0000-000000000006'::uuid,
    '00000000-0000-0000-0000-000000000001'::uuid,
    '00000000-0000-0000-0000-000000000004'::uuid, -- Williams
    'Williams', 'Williams_K', 'follow_request', 'requested to follow you.',
    NULL, NULL, TRUE, FALSE,
    NOW() - INTERVAL '3 hours'
  ),
  (
    'f0000000-0000-0000-0000-000000000007'::uuid,
    '00000000-0000-0000-0000-000000000001'::uuid,
    '00000000-0000-0000-0000-000000000010'::uuid, -- Emily
    'Emily', 'Emiley_J', 'follow_request', 'requested to follow you.',
    NULL, NULL, TRUE, FALSE,
    NOW() - INTERVAL '3 hours 15 minutes'
  ),
  (
    'f0000000-0000-0000-0000-000000000008'::uuid,
    '00000000-0000-0000-0000-000000000001'::uuid,
    '00000000-0000-0000-0000-000000000005'::uuid, -- Jessica
    'Jessica', 'Jessica_09', 'follow_request', 'requested to follow you.',
    NULL, NULL, TRUE, FALSE,
    NOW() - INTERVAL '3 hours 30 minutes'
  ),
  (
    'f0000000-0000-0000-0000-000000000009'::uuid,
    '00000000-0000-0000-0000-000000000001'::uuid,
    '00000000-0000-0000-0000-000000000008'::uuid, -- Maria
    'Maria', 'Maria_Jones', 'like', 'liked your post.',
    'He hid his phone during dinner...', 'Red Flags', TRUE, FALSE,
    NOW() - INTERVAL '4 hours'
  ),
  (
    'f0000000-0000-0000-0000-000000000010'::uuid,
    '00000000-0000-0000-0000-000000000001'::uuid,
    '00000000-0000-0000-0000-000000000008'::uuid, -- Maria
    'Maria', 'Maria_Jones', 'like', 'liked your post.',
    'Situationship for 9 months with no label...', 'Situationship', TRUE, FALSE,
    NOW() - INTERVAL '4 hours 30 minutes'
  )
ON CONFLICT (id) DO NOTHING;
