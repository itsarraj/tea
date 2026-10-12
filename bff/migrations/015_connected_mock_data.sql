-- Migration 015: Connected Logical Mock Data for End-to-End Testing
-- Covers: Profiles normalization, Discover deck, Feed categories, Verdict votes, Comments,
-- Advisors leaderboard, Stories/Quick notes, Matches, Multi-turn Conversations, and Notifications.

-- ---------------------------------------------------------------------------
-- 1. Normalize Advisors & Profiles (Gender & Looking For Fix)
-- ---------------------------------------------------------------------------
-- Fix Marina's profile
UPDATE dating.profiles SET
  gender = 'woman',
  looking_for = ARRAY['man', 'woman'],
  intent = 'both',
  onboarding_complete = TRUE,
  city = 'Bengaluru',
  country = 'India',
  lat = 12.9716,
  lng = 77.5946,
  min_age = 18,
  max_age = 99
WHERE user_id = '00000000-0000-0000-0000-000000000001';

-- Update advisor genders and preferences
UPDATE dating.profiles SET gender = 'man', looking_for = ARRAY['woman'], intent = 'both', onboarding_complete = TRUE, lat = 12.9784, lng = 77.6408, min_age = 18, max_age = 99 WHERE user_id = '00000000-0000-0000-0000-000000000002'; -- Jack James
UPDATE dating.profiles SET gender = 'woman', looking_for = ARRAY['man'], intent = 'both', onboarding_complete = TRUE, lat = 12.9352, lng = 77.6245, min_age = 18, max_age = 99 WHERE user_id = '00000000-0000-0000-0000-000000000003'; -- Sylvia Agostino
UPDATE dating.profiles SET gender = 'man', looking_for = ARRAY['woman'], intent = 'both', onboarding_complete = TRUE, lat = 12.9850, lng = 77.5533, min_age = 18, max_age = 99 WHERE user_id = '00000000-0000-0000-0000-000000000004'; -- Williams K
UPDATE dating.profiles SET gender = 'woman', looking_for = ARRAY['man'], intent = 'both', onboarding_complete = TRUE, lat = 12.9279, lng = 77.6271, min_age = 18, max_age = 99 WHERE user_id = '00000000-0000-0000-0000-000000000005'; -- Jessica Cole
UPDATE dating.profiles SET gender = 'man', looking_for = ARRAY['woman'], intent = 'both', onboarding_complete = TRUE, lat = 12.9141, lng = 77.6100, min_age = 18, max_age = 99 WHERE user_id = '00000000-0000-0000-0000-000000000006'; -- Edward Miller
UPDATE dating.profiles SET gender = 'man', looking_for = ARRAY['woman'], intent = 'both', onboarding_complete = TRUE, lat = 12.9569, lng = 77.7011, min_age = 18, max_age = 99 WHERE user_id = '00000000-0000-0000-0000-000000000007'; -- Michael
UPDATE dating.profiles SET gender = 'woman', looking_for = ARRAY['man'], intent = 'both', onboarding_complete = TRUE, lat = 12.9698, lng = 77.7500, min_age = 18, max_age = 99 WHERE user_id = '00000000-0000-0000-0000-000000000008'; -- Maria Jones
UPDATE dating.profiles SET gender = 'woman', looking_for = ARRAY['man'], intent = 'both', onboarding_complete = TRUE, lat = 12.9950, lng = 77.6200, min_age = 18, max_age = 99 WHERE user_id = '00000000-0000-0000-0000-000000000009'; -- Libby Liz
UPDATE dating.profiles SET gender = 'woman', looking_for = ARRAY['man'], intent = 'both', onboarding_complete = TRUE, lat = 12.9400, lng = 77.5700, min_age = 18, max_age = 99 WHERE user_id = '00000000-0000-0000-0000-000000000010'; -- Emily Johnson

-- Ensure all demo users are open to matches and onboarding complete
UPDATE dating.profiles SET
  onboarding_complete = TRUE,
  intent = 'both',
  min_age = 18,
  max_age = 99,
  looking_for = ARRAY['man', 'woman']
WHERE onboarding_complete = FALSE OR cardinality(looking_for) = 0 OR looking_for = ARRAY['seeking', 'giving'];

-- Remove any old test swipes by Marina so Discover deck has fresh candidate cards
DELETE FROM dating.swipes WHERE from_user_id = '00000000-0000-0000-0000-000000000001';

-- ---------------------------------------------------------------------------
-- 2. Multi-photo Backfill for Advisors
-- ---------------------------------------------------------------------------
INSERT INTO dating.photos (user_id, url, position)
VALUES
  ('00000000-0000-0000-0000-000000000001', '/media/fakeusers/women/11.jpg', 1),
  ('00000000-0000-0000-0000-000000000001', '/media/fakeusers/women/21.jpg', 2),
  ('00000000-0000-0000-0000-000000000002', '/media/fakeusers/men/12.jpg', 1),
  ('00000000-0000-0000-0000-000000000002', '/media/fakeusers/men/22.jpg', 2),
  ('00000000-0000-0000-0000-000000000003', '/media/fakeusers/women/13.jpg', 1),
  ('00000000-0000-0000-0000-000000000003', '/media/fakeusers/women/23.jpg', 2),
  ('00000000-0000-0000-0000-000000000004', '/media/fakeusers/men/14.jpg', 1),
  ('00000000-0000-0000-0000-000000000005', '/media/fakeusers/women/15.jpg', 1),
  ('00000000-0000-0000-0000-000000000006', '/media/fakeusers/men/16.jpg', 1),
  ('00000000-0000-0000-0000-000000000007', '/media/fakeusers/men/17.jpg', 1),
  ('00000000-0000-0000-0000-000000000008', '/media/fakeusers/women/18.jpg', 1),
  ('00000000-0000-0000-0000-000000000009', '/media/fakeusers/women/19.jpg', 1),
  ('00000000-0000-0000-0000-000000000010', '/media/fakeusers/women/20.jpg', 1)
ON CONFLICT DO NOTHING;

-- ---------------------------------------------------------------------------
-- 3. Mutual Matches & Conversations
-- ---------------------------------------------------------------------------
-- Canonical helper to insert match and conversation cleanly
-- Match 1: Marina (User 1) & Sylvia (User 3) - already exists ba000000-0000-0000-0000-000000000001
-- Match 2: Marina (User 1) & Jack (User 2)
INSERT INTO dating.matches (id, user_a, user_b, created_at)
VALUES ('ba000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', NOW() - INTERVAL '3 days')
ON CONFLICT (user_a, user_b) DO NOTHING;

INSERT INTO dating.conversations (id, match_id, user_a, user_b, last_preview, last_message_at, request_status)
VALUES (
  'd0000000-0000-0000-0000-000000000002',
  'ba000000-0000-0000-0000-000000000002',
  '00000000-0000-0000-0000-000000000001',
  '00000000-0000-0000-0000-000000000002',
  'What do you think about his text?',
  NOW() - INTERVAL '15 minutes',
  'active'
)
ON CONFLICT (id) DO UPDATE SET last_preview = EXCLUDED.last_preview, last_message_at = EXCLUDED.last_message_at;

-- Match 3: Marina (User 1) & Jessica (User 5)
INSERT INTO dating.matches (id, user_a, user_b, created_at)
VALUES ('ba000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000005', NOW() - INTERVAL '4 days')
ON CONFLICT (user_a, user_b) DO NOTHING;

INSERT INTO dating.conversations (id, match_id, user_a, user_b, last_preview, last_message_at, request_status)
VALUES (
  'd0000000-0000-0000-0000-000000000003',
  'ba000000-0000-0000-0000-000000000003',
  '00000000-0000-0000-0000-000000000001',
  '00000000-0000-0000-0000-000000000005',
  'You were totally right about date 2! 🎉',
  NOW() - INTERVAL '2 hours',
  'active'
)
ON CONFLICT (id) DO UPDATE SET last_preview = EXCLUDED.last_preview, last_message_at = EXCLUDED.last_message_at;

-- Match 4: Marina (User 1) & Edward (User 6)
INSERT INTO dating.matches (id, user_a, user_b, created_at)
VALUES ('ba000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000006', NOW() - INTERVAL '5 days')
ON CONFLICT (user_a, user_b) DO NOTHING;

INSERT INTO dating.conversations (id, match_id, user_a, user_b, last_preview, last_message_at, request_status)
VALUES (
  'd0000000-0000-0000-0000-000000000004',
  'ba000000-0000-0000-0000-000000000004',
  '00000000-0000-0000-0000-000000000001',
  '00000000-0000-0000-0000-000000000006',
  'Did you see the new dilemma posted on the feed?',
  NOW() - INTERVAL '5 hours',
  'active'
)
ON CONFLICT (id) DO UPDATE SET last_preview = EXCLUDED.last_preview, last_message_at = EXCLUDED.last_message_at;

-- Match 5: Marina (User 1) & Michael (User 7)
INSERT INTO dating.matches (id, user_a, user_b, created_at)
VALUES ('ba000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000007', NOW() - INTERVAL '6 days')
ON CONFLICT (user_a, user_b) DO NOTHING;

INSERT INTO dating.conversations (id, match_id, user_a, user_b, last_preview, last_message_at, request_status)
VALUES (
  'd0000000-0000-0000-0000-000000000005',
  'ba000000-0000-0000-0000-000000000005',
  '00000000-0000-0000-0000-000000000001',
  '00000000-0000-0000-0000-000000000007',
  'Coffee this weekend if you are free?',
  NOW() - INTERVAL '1 day',
  'active'
)
ON CONFLICT (id) DO UPDATE SET last_preview = EXCLUDED.last_preview, last_message_at = EXCLUDED.last_message_at;

-- Match 6: Marina (User 1) & Libby (User 9)
INSERT INTO dating.matches (id, user_a, user_b, created_at)
VALUES ('ba000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000009', NOW() - INTERVAL '7 days')
ON CONFLICT (user_a, user_b) DO NOTHING;

INSERT INTO dating.conversations (id, match_id, user_a, user_b, last_preview, last_message_at, request_status)
VALUES (
  'd0000000-0000-0000-0000-000000000006',
  'ba000000-0000-0000-0000-000000000006',
  '00000000-0000-0000-0000-000000000001',
  '00000000-0000-0000-0000-000000000009',
  'Omg no way! What happened next?? 😱',
  NOW() - INTERVAL '30 minutes',
  'active'
)
ON CONFLICT (id) DO UPDATE SET last_preview = EXCLUDED.last_preview, last_message_at = EXCLUDED.last_message_at;

-- ---------------------------------------------------------------------------
-- 4. Multi-turn Chat Messages
-- ---------------------------------------------------------------------------
-- Conversation with Jack James (d0000000-0000-0000-0000-000000000002)
INSERT INTO dating.messages (id, conversation_id, sender_id, body, created_at)
VALUES
  ('e0000000-0000-0000-0000-000000000010', 'd0000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 'Hey Jack! Quick question on male texting etiquette.', NOW() - INTERVAL '1 hour'),
  ('e0000000-0000-0000-0000-000000000011', 'd0000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000002', 'Always ready for tea. Lay it on me Marina.', NOW() - INTERVAL '50 minutes'),
  ('e0000000-0000-0000-0000-000000000012', 'd0000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 'A client got a "we should hang out sometime" text after 2 weeks of silence.', NOW() - INTERVAL '40 minutes'),
  ('e0000000-0000-0000-0000-000000000013', 'd0000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000002', 'Classic low-effort zombie text. He got bored on a Tuesday night.', NOW() - INTERVAL '30 minutes'),
  ('e0000000-0000-0000-0000-000000000014', 'd0000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000002', 'What do you think about his text?', NOW() - INTERVAL '15 minutes')
ON CONFLICT (id) DO NOTHING;

-- Conversation with Jessica Cole (d0000000-0000-0000-0000-000000000003)
INSERT INTO dating.messages (id, conversation_id, sender_id, body, created_at)
VALUES
  ('e0000000-0000-0000-0000-000000000020', 'd0000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000005', 'Marina! How did your consulting call go?', NOW() - INTERVAL '5 hours'),
  ('e0000000-0000-0000-0000-000000000021', 'd0000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', 'Amazing! She finally realized that three months without exclusivity is a situationship.', NOW() - INTERVAL '4 hours'),
  ('e0000000-0000-0000-0000-000000000022', 'd0000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000005', 'You were totally right about date 2! 🎉', NOW() - INTERVAL '2 hours')
ON CONFLICT (id) DO NOTHING;

-- Conversation with Libby Liz (d0000000-0000-0000-0000-000000000006)
INSERT INTO dating.messages (id, conversation_id, sender_id, body, created_at)
VALUES
  ('e0000000-0000-0000-0000-000000000030', 'd0000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000001', 'Libby you won’t believe the date story someone just sent in.', NOW() - INTERVAL '45 minutes'),
  ('e0000000-0000-0000-0000-000000000031', 'd0000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000009', 'Omg no way! What happened next?? 😱', NOW() - INTERVAL '30 minutes')
ON CONFLICT (id) DO NOTHING;

-- Conversation with Michael (d0000000-0000-0000-0000-000000000005)
INSERT INTO dating.messages (id, conversation_id, sender_id, body, created_at)
VALUES
  ('e0000000-0000-0000-0000-000000000040', 'd0000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000007', 'Hey Marina! Loved your post on first date bill splitting.', NOW() - INTERVAL '2 days'),
  ('e0000000-0000-0000-0000-000000000041', 'd0000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000001', 'Thanks Michael! Simple manners save a lot of headaches.', NOW() - INTERVAL '1 day'),
  ('e0000000-0000-0000-0000-000000000042', 'd0000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000007', 'Coffee this weekend if you are free?', NOW() - INTERVAL '1 day')
ON CONFLICT (id) DO NOTHING;

-- ---------------------------------------------------------------------------
-- 5. Stories / Quick Notes (Fresh 24h Feed)
-- ---------------------------------------------------------------------------
DELETE FROM dating.quick_notes WHERE created_at < NOW() - INTERVAL '24 hours';

INSERT INTO dating.quick_notes (id, user_id, author, name, note, emoji, created_at)
VALUES
  (
    'bb000000-0000-0000-0000-000000000011',
    '00000000-0000-0000-0000-000000000001',
    'Marina_Jose',
    'Marina Jose',
    'If his actions don’t match his words, believe the actions every single time.',
    '💡',
    NOW() - INTERVAL '20 minutes'
  ),
  (
    'bb000000-0000-0000-0000-000000000012',
    '00000000-0000-0000-0000-000000000002',
    'Jack.James',
    'Jack James',
    'Men who are actually into you do not play "who can reply slower" games.',
    '☕',
    NOW() - INTERVAL '1 hour'
  ),
  (
    'bb000000-0000-0000-0000-000000000013',
    '00000000-0000-0000-0000-000000000003',
    'Sylvia_A',
    'Sylvia Agostino',
    'Boundaries are not ultimatums. Learn the difference before date four.',
    '✨',
    NOW() - INTERVAL '2 hours'
  ),
  (
    'bb000000-0000-0000-0000-000000000014',
    '00000000-0000-0000-0000-000000000005',
    'Jessica_09',
    'Jessica Cole',
    'Three dates in and he hasn’t asked a single question about you? Run.',
    '🚩',
    NOW() - INTERVAL '3 hours'
  ),
  (
    'bb000000-0000-0000-0000-000000000015',
    '00000000-0000-0000-0000-000000000006',
    'Edward_M',
    'Edward Miller',
    'Texting cadence is an underrated compatibility metric.',
    '💭',
    NOW() - INTERVAL '4 hours'
  ),
  (
    'bb000000-0000-0000-0000-000000000016',
    '00000000-0000-0000-0000-000000000009',
    'Libby_liz',
    'Libby Liz',
    'Debriefing the most unhinged first date story in the group chat rn',
    '🔥',
    NOW() - INTERVAL '5 hours'
  ),
  (
    'bb000000-0000-0000-0000-000000000017',
    '00000000-0000-0000-0000-000000000007',
    'Michael_01',
    'Michael',
    'Why does everyone turn into a ghost right before the 4th date?',
    '👀',
    NOW() - INTERVAL '6 hours'
  ),
  (
    'bb000000-0000-0000-0000-000000000018',
    '00000000-0000-0000-0000-000000000008',
    'Maria_Jones',
    'Maria Jones',
    'Unfollowed my situationship. Instant mental clarity 💅',
    '💅',
    NOW() - INTERVAL '7 hours'
  )
ON CONFLICT (id) DO UPDATE SET note = EXCLUDED.note, emoji = EXCLUDED.emoji, created_at = EXCLUDED.created_at;

-- ---------------------------------------------------------------------------
-- 6. Follow Relationships
-- ---------------------------------------------------------------------------
INSERT INTO dating.follows (follower_id, following_id, status, created_at)
VALUES
  ('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', 'active', NOW() - INTERVAL '2 days'), -- Marina follows Jack
  ('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000003', 'active', NOW() - INTERVAL '2 days'), -- Marina follows Sylvia
  ('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000005', 'active', NOW() - INTERVAL '3 days'), -- Marina follows Jessica
  ('00000000-0000-0000-0000-000000000007', '00000000-0000-0000-0000-000000000001', 'pending', NOW() - INTERVAL '1 hour'), -- Michael requested to follow Marina
  ('00000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000001', 'pending', NOW() - INTERVAL '3 hours'), -- Edward requested to follow Marina
  ('00000000-0000-0000-0000-000000000009', '00000000-0000-0000-0000-000000000001', 'active', NOW() - INTERVAL '1 day'),  -- Libby follows Marina
  ('00000000-0000-0000-0000-000000000008', '00000000-0000-0000-0000-000000000001', 'active', NOW() - INTERVAL '2 days')   -- Maria follows Marina
ON CONFLICT (follower_id, following_id) DO UPDATE SET status = EXCLUDED.status;

-- ---------------------------------------------------------------------------
-- 7. Rich Feed Dilemma Posts (All 10 Categories)
-- ---------------------------------------------------------------------------
-- Clean out legacy posts with mismatched football/writing categories
DELETE FROM dating.feed_posts WHERE category NOT IN (
  '🚩 Red Flags', '💚 Green Flags', '☕ First Date', '🤔 Am I Overreacting?',
  '💔 Breakups', '🫖 Spill The Tea', '📱 Texting Rules', '👻 Ghosted',
  '💡 Dating Advice', '✨ Relationship Goals'
);

INSERT INTO dating.feed_posts (
  id, author_id, mode, category, title, question,
  red_flags, green_flags, valid_count, helpful_count, created_at
)
VALUES
  -- 1. Red Flags
  (
    'a0000000-0000-0000-0000-000000000010',
    '00000000-0000-0000-0000-000000000005',
    'advice',
    '🚩 Red Flags',
    'He claims every single one of his exes was "crazy and obsessed"',
    'We went on date 3 yesterday and he brought up his past relationships. According to him, his last 4 exes were all "clinically insane", "obsessed with him", and "ruined his life". None of it was ever his fault. Should I consider this a massive warning sign?',
    142, 4, 18, 98,
    NOW() - INTERVAL '1 hour'
  ),
  (
    'a0000000-0000-0000-0000-000000000011',
    '00000000-0000-0000-0000-000000000002',
    'advice',
    '🚩 Red Flags',
    'He refuses to be seen together in public but wants to hang out at his apartment',
    'It has been 2 months. Whenever I suggest getting dinner or going to a coffee shop, he makes an excuse and suggests watching Netflix at his place. He claims he is "just introverted". Am I being hidden away on a roster?',
    188, 2, 12, 120,
    NOW() - INTERVAL '8 hours'
  ),

  -- 2. Green Flags
  (
    'a0000000-0000-0000-0000-000000000012',
    '00000000-0000-0000-0000-000000000003',
    'advice',
    '💚 Green Flags',
    'He remembered an offhand comment I made on date 1 and surprised me with it',
    'On our very first date I briefly mentioned my favorite obscure tea blend from Kyoto. On date 3, he brought a tin of it from an authentic Japanese market across town. It felt genuinely thoughtful without being love-bombing. What do you all think?',
    3, 195, 14, 145,
    NOW() - INTERVAL '3 hours'
  ),
  (
    'a0000000-0000-0000-0000-000000000013',
    '00000000-0000-0000-0000-000000000006',
    'advice',
    '💚 Green Flags',
    'He communicated about being busy beforehand instead of disappearing',
    'He had a huge pitch meeting today and texted me at 7 AM saying: "Hey, work is going to be chaotic until 6 PM, will catch up properly tonight!" No guessing, no anxiety, no waiting for replies. Consistency is so refreshing.',
    1, 210, 8, 160,
    NOW() - INTERVAL '12 hours'
  ),

  -- 3. First Date
  (
    'a0000000-0000-0000-0000-000000000014',
    '00000000-0000-0000-0000-000000000001',
    'advice',
    '☕ First Date',
    'Splitting the bill on the first date: my golden rule that never fails',
    'Rule: If you invited them, offer to pay. If they offer to split, graciously accept half or offer dessert. Don’t play fake wallet reach games. Clean clarity from minute one sets the tone for the entire dynamic.',
    12, 164, 45, 230,
    NOW() - INTERVAL '1 day'
  ),
  (
    'a0000000-0000-0000-0000-000000000015',
    '00000000-0000-0000-0000-000000000010',
    'advice',
    '☕ First Date',
    'He ordered for me without asking what I wanted at dinner',
    'We went to an Italian bistro. Before I opened the menu, he told the waiter "she will have the risotto and a glass of house red". I laughed awkwardly, but inside I was slightly unnerved. Charming confidence or controlling behavior?',
    89, 15, 34, 82,
    NOW() - INTERVAL '18 hours'
  ),

  -- 4. Am I Overreacting?
  (
    'a0000000-0000-0000-0000-000000000016',
    '00000000-0000-0000-0000-000000000007',
    'advice',
    '🤔 Am I Overreacting?',
    'He hasn’t texted for 48 hours after an amazing 3rd date. What should I do?',
    'We had an incredible dinner, he talked about our future plans for next weekend, and kissed me goodnight. Since Monday morning, radio silence. Not even a "good morning" or "hope your week is good". Am I overreacting, or should I reach out first?',
    78, 14, 52, 110,
    NOW() - INTERVAL '2 days'
  ),
  (
    'a0000000-0000-0000-0000-000000000017',
    '00000000-0000-0000-0000-000000000009',
    'advice',
    '🤔 Am I Overreacting?',
    'He still likes his ex-girlfriend’s bikini pictures on Instagram',
    'They broke up 8 months ago. He claims they are "just on good terms and it means nothing". But every vacation photo she posts has his like within 10 minutes. It makes my stomach turn. Valid concern or insecure overthinking?',
    130, 8, 45, 95,
    NOW() - INTERVAL '1 day'
  ),

  -- 5. Texting Rules
  (
    'a0000000-0000-0000-0000-000000000018',
    '00000000-0000-0000-0000-000000000002',
    'advice',
    '📱 Texting Rules',
    'The 3-text rule: When to stop following up and let silence do the talking',
    'If you send two consecutive messages asking about plans and receive non-committal or one-word replies, DO NOT send a third text trying to fix the vibe. Match their energy. Silence is an answer, and usually a loud one.',
    6, 175, 22, 190,
    NOW() - INTERVAL '2 days'
  ),
  (
    'a0000000-0000-0000-0000-000000000019',
    '00000000-0000-0000-0000-000000000008',
    'advice',
    '📱 Texting Rules',
    'Replying within 30 seconds vs taking 8 hours: why false pacing ruins chemistry',
    'Why are people in 2026 still calculating how many minutes to wait before opening a message? If you are free, reply. If you are busy, reply later. Artificial delay games create fake mystery and real fatigue.',
    14, 182, 30, 140,
    NOW() - INTERVAL '3 days'
  ),

  -- 6. Ghosted
  (
    'a0000000-0000-0000-0000-000000000020',
    '00000000-0000-0000-0000-000000000009',
    'advice',
    '👻 Ghosted',
    'Ghosted after 6 months of dating: how do you close the loop yourself?',
    'We talked every single day for half a year, met each other’s close friends, and planned a trip for November. Last Thursday he stopped opening messages completely. No fight, no explanation. How do you find closure when they vanish?',
    195, 2, 8, 175,
    NOW() - INTERVAL '3 days'
  ),

  -- 7. Spill The Tea
  (
    'a0000000-0000-0000-0000-000000000021',
    '00000000-0000-0000-0000-000000000008',
    'spill',
    '🫖 Spill The Tea',
    'Spill: Caught my date using his girlfriend’s Netflix account on our date night',
    'He invited me over to watch a movie. He booted up Apple TV and clicked Netflix. The active profile was "Babe & Dave ❤️". When I asked who Babe was, he paused, panicked, and said "uh that is my sister". Y’all I grabbed my purse and booked an Uber immediately.',
    215, 3, 5, 260,
    NOW() - INTERVAL '4 days'
  ),

  -- 8. Breakups
  (
    'a0000000-0000-0000-0000-000000000022',
    '00000000-0000-0000-0000-000000000004',
    'advice',
    '💔 Breakups',
    'Why you should NEVER stalk an ex on social media: a psychological reality check',
    'Checking their Instagram doesn’t give you closure, it restarts the grief cycle. You are looking at a curated highlight reel designed to look unbothered. Block, mute, and choose your own peace of mind over digital self-harm.',
    4, 230, 12, 310,
    NOW() - INTERVAL '5 days'
  ),

  -- 9. Dating Advice
  (
    'a0000000-0000-0000-0000-000000000023',
    '00000000-0000-0000-0000-000000000003',
    'advice',
    '💡 Dating Advice',
    'Stop auditioning for people who haven’t proved they even like you',
    'Most dating anxiety comes from trying to impress someone before deciding whether YOU actually enjoy their company. Shift your mindset from "Do they like me?" to "Do I feel calm, respected, and heard around them?"',
    2, 248, 15, 290,
    NOW() - INTERVAL '5 days'
  ),

  -- 10. Relationship Goals
  (
    'a0000000-0000-0000-0000-000000000024',
    '00000000-0000-0000-0000-000000000004',
    'advice',
    '✨ Relationship Goals',
    'Boring love is underrated: why high drama is not passion',
    'Hollywood taught everyone that love has to be an exhausting rollercoaster of breakups and grand airport chases. Healthy love is peaceful, reliable, and sometimes predictable. Don’t mistake nervous system regulation for lack of chemistry.',
    5, 215, 20, 240,
    NOW() - INTERVAL '6 days'
  )
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  question = EXCLUDED.question,
  category = EXCLUDED.category,
  red_flags = EXCLUDED.red_flags,
  green_flags = EXCLUDED.green_flags,
  valid_count = EXCLUDED.valid_count,
  helpful_count = EXCLUDED.helpful_count;

-- ---------------------------------------------------------------------------
-- 8. Feed Comments & Expert Advice
-- ---------------------------------------------------------------------------
INSERT INTO dating.post_comments (
  id, post_id, user_id, body, advisor_rank, helpful_count, is_top_advice, created_at
)
VALUES
  -- On post a0000000-0000-0000-0000-000000000010 (Crazy Exes Red Flag)
  (
    'c0000000-0000-0000-0000-000000000001',
    'a0000000-0000-0000-0000-000000000010',
    '00000000-0000-0000-0000-000000000001', -- Marina Jose
    'Huge red flag. The common denominator in all his relationships is HIM. In 6 months you will be crazy ex #5.',
    'Certified Tea Advisor 🏆',
    84,
    TRUE,
    NOW() - INTERVAL '45 minutes'
  ),
  (
    'c0000000-0000-0000-0000-000000000002',
    'a0000000-0000-0000-0000-000000000010',
    '00000000-0000-0000-0000-000000000002', -- Jack James
    'Men who take zero accountability for relationship breakdowns are unable to handle adult conflict.',
    'Senior Advisor ★',
    42,
    FALSE,
    NOW() - INTERVAL '30 minutes'
  ),

  -- On post a0000000-0000-0000-0000-000000000014 (First date bill splitting)
  (
    'c0000000-0000-0000-0000-000000000003',
    'a0000000-0000-0000-0000-000000000014',
    '00000000-0000-0000-0000-000000000007', -- Michael
    'As a guy, I always plan to cover the first date. But seeing genuine willingness to split shows character.',
    'Tea Seeker 🔍',
    38,
    TRUE,
    NOW() - INTERVAL '18 hours'
  ),
  (
    'c0000000-0000-0000-0000-000000000004',
    'a0000000-0000-0000-0000-000000000014',
    '00000000-0000-0000-0000-000000000003', -- Sylvia Agostino
    'Exact right advice. It removes financial awkwardness immediately.',
    'Tea Master 🫖',
    29,
    FALSE,
    NOW() - INTERVAL '15 hours'
  ),

  -- On post a0000000-0000-0000-0000-000000000016 (48 hours radio silence)
  (
    'c0000000-0000-0000-0000-000000000005',
    'a0000000-0000-0000-0000-000000000016',
    '00000000-0000-0000-0000-000000000001', -- Marina Jose
    'You are not overreacting. If he was excited about seeing you again, you wouldn’t be wondering.',
    'Certified Tea Advisor 🏆',
    92,
    TRUE,
    NOW() - INTERVAL '1 day'
  ),
  (
    'c0000000-0000-0000-0000-000000000006',
    'a0000000-0000-0000-0000-000000000016',
    '00000000-0000-0000-0000-000000000006', -- Edward Miller
    'Give it until tonight. If nothing, send one casual message. If he takes another 24h, move on.',
    'Advisor 💡',
    41,
    FALSE,
    NOW() - INTERVAL '18 hours'
  )
ON CONFLICT (id) DO UPDATE SET
  body = EXCLUDED.body,
  helpful_count = EXCLUDED.helpful_count,
  is_top_advice = EXCLUDED.is_top_advice;

-- ---------------------------------------------------------------------------
-- 9. Post Verdict Votes (Percentage distributions)
-- ---------------------------------------------------------------------------
INSERT INTO dating.post_votes (post_id, user_id, vote, created_at)
VALUES
  -- Red flag votes
  ('a0000000-0000-0000-0000-000000000010', '00000000-0000-0000-0000-000000000001', 'red', NOW()),
  ('a0000000-0000-0000-0000-000000000010', '00000000-0000-0000-0000-000000000002', 'red', NOW()),
  ('a0000000-0000-0000-0000-000000000010', '00000000-0000-0000-0000-000000000003', 'red', NOW()),
  ('a0000000-0000-0000-0000-000000000010', '00000000-0000-0000-0000-000000000004', 'red', NOW()),
  ('a0000000-0000-0000-0000-000000000010', '00000000-0000-0000-0000-000000000006', 'valid', NOW()),

  -- Green flag votes
  ('a0000000-0000-0000-0000-000000000012', '00000000-0000-0000-0000-000000000001', 'green', NOW()),
  ('a0000000-0000-0000-0000-000000000012', '00000000-0000-0000-0000-000000000002', 'green', NOW()),
  ('a0000000-0000-0000-0000-000000000012', '00000000-0000-0000-0000-000000000005', 'green', NOW()),

  -- 48 hours silence votes
  ('a0000000-0000-0000-0000-000000000016', '00000000-0000-0000-0000-000000000001', 'red', NOW()),
  ('a0000000-0000-0000-0000-000000000016', '00000000-0000-0000-0000-000000000002', 'red', NOW()),
  ('a0000000-0000-0000-0000-000000000016', '00000000-0000-0000-0000-000000000006', 'valid', NOW())
ON CONFLICT (post_id, user_id) DO UPDATE SET vote = EXCLUDED.vote;

-- ---------------------------------------------------------------------------
-- 10. Likes & Saves by Marina (For Active State UI Testing)
-- ---------------------------------------------------------------------------
INSERT INTO dating.post_likes (post_id, user_id, created_at)
VALUES
  ('a0000000-0000-0000-0000-000000000010', '00000000-0000-0000-0000-000000000001', NOW() - INTERVAL '1 hour'),
  ('a0000000-0000-0000-0000-000000000012', '00000000-0000-0000-0000-000000000001', NOW() - INTERVAL '2 hours'),
  ('a0000000-0000-0000-0000-000000000016', '00000000-0000-0000-0000-000000000001', NOW() - INTERVAL '1 day')
ON CONFLICT DO NOTHING;

INSERT INTO dating.post_saves (post_id, user_id, created_at)
VALUES
  ('a0000000-0000-0000-0000-000000000014', '00000000-0000-0000-0000-000000000001', NOW() - INTERVAL '1 day'),
  ('a0000000-0000-0000-0000-000000000023', '00000000-0000-0000-0000-000000000001', NOW() - INTERVAL '2 days')
ON CONFLICT DO NOTHING;

-- ---------------------------------------------------------------------------
-- 11. Interactive Notifications for Marina
-- ---------------------------------------------------------------------------
INSERT INTO dating.notifications (
  id, user_id, actor_id, actor_name, actor_handle, type, text,
  post_id, post_snippet, post_category, read, confirmed, created_at
)
VALUES
  (
    'f0000000-0000-0000-0000-000000000010',
    '00000000-0000-0000-0000-000000000001',
    '00000000-0000-0000-0000-000000000007',
    'Michael',
    'Michael_01',
    'follow_request',
    'requested to follow you.',
    NULL, NULL, NULL,
    FALSE, FALSE,
    NOW() - INTERVAL '15 minutes'
  ),
  (
    'f0000000-0000-0000-0000-000000000011',
    '00000000-0000-0000-0000-000000000001',
    '00000000-0000-0000-0000-000000000006',
    'Edward Miller',
    'Edward_M',
    'follow_request',
    'requested to follow you.',
    NULL, NULL, NULL,
    FALSE, FALSE,
    NOW() - INTERVAL '1 hour'
  ),
  (
    'f0000000-0000-0000-0000-000000000012',
    '00000000-0000-0000-0000-000000000001',
    '00000000-0000-0000-0000-000000000002',
    'Jack James',
    'Jack.James',
    'like',
    'liked your post: Splitting the bill on the first date',
    'a0000000-0000-0000-0000-000000000014',
    'Splitting the bill on the first date: my golden rule that never fails',
    '☕ First Date',
    FALSE, TRUE,
    NOW() - INTERVAL '3 hours'
  ),
  (
    'f0000000-0000-0000-0000-000000000013',
    '00000000-0000-0000-0000-000000000001',
    '00000000-0000-0000-0000-000000000003',
    'Sylvia Agostino',
    'Sylvia_A',
    'advice_reply',
    'replied: "Exact right advice. It removes financial awkwardness immediately."',
    'a0000000-0000-0000-0000-000000000014',
    'Splitting the bill on the first date',
    '☕ First Date',
    TRUE, TRUE,
    NOW() - INTERVAL '6 hours'
  ),
  (
    'f0000000-0000-0000-0000-000000000014',
    '00000000-0000-0000-0000-000000000001',
    '00000000-0000-0000-0000-000000000009',
    'Libby Liz',
    'Libby_liz',
    'follow',
    'started following you.',
    NULL, NULL, NULL,
    TRUE, TRUE,
    NOW() - INTERVAL '1 day'
  ),
  (
    'f0000000-0000-0000-0000-000000000015',
    '00000000-0000-0000-0000-000000000001',
    '00000000-0000-0000-0000-000000000008',
    'Maria Jones',
    'Maria_Jones',
    'follow',
    'started following you.',
    NULL, NULL, NULL,
    TRUE, TRUE,
    NOW() - INTERVAL '2 days'
  )
ON CONFLICT (id) DO UPDATE SET
  read = EXCLUDED.read,
  confirmed = EXCLUDED.confirmed,
  created_at = EXCLUDED.created_at;
