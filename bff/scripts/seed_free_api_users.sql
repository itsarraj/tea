-- ===========================================================================
-- Palora Seed: 100+ Mock Users from free-api-backend
-- Generated on: 2026-09-26T12:43:02.884219+00:00
-- Total users: 120
-- Password for all seeded accounts: demo1234
-- Idempotent: ON CONFLICT updates existing profiles
-- ===========================================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

DO $$
DECLARE
  u_id UUID;
BEGIN
  -- User #1: Eugene Dach (eugene_dachyahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('eugene_dachyahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Eugene Dach', TRUE, DATE '2003-05-23')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Eugene Dach', 'man', ARRAY['woman','man']::text[], 'partner', DATE '2003-05-23',
    'Bengaluru', 'India', 12.9128, 77.6494, 'Marathon training in progress. Will run for good pastries.', ARRAY['👗 Fashion', '🗣 Language', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #1
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/2.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-1-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-1-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #2: Charity Kuhic (charity_kuhic40hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('charity_kuhic40hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Charity Kuhic', TRUE, DATE '2000-12-21')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Charity Kuhic', 'woman', ARRAY['man']::text[], 'partner', DATE '2000-12-21',
    'Koramangala', 'India', 13.0752, 77.5407, 'Data scientist with a weak spot for dog memes and Sunday morning hikes.', ARRAY['👗 Fashion', '✍🏻 Writing', '🍃 Nature', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #2
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/25154415', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-2-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-2-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #3: Jazmin Schneider (jazmin.schneidergmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jazmin.schneidergmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Jazmin Schneider', TRUE, DATE '1997-01-24')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jazmin Schneider', 'woman', ARRAY['man']::text[], 'both', DATE '1997-01-24',
    'Whitefield', 'India', 13.0572, 77.6131, 'Marathon training in progress. Will run for good pastries.', ARRAY['🎵 Music', '🙂 People', '✍🏻 Writing', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #3
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/28784029', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-3-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-3-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #4: Serenity Bernier-Bahringer (serenity_bernier-bahringeryahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('serenity_bernier-bahringeryahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Serenity Bernier-Bahringer', TRUE, DATE '2000-11-21')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Serenity Bernier-Bahringer', 'woman', ARRAY['man']::text[], 'partner', DATE '2000-11-21',
    'Bengaluru', 'India', 13.0144, 77.5083, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['👗 Fashion', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #4
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/69.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-4-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-4-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #5: Silas Schuster (silas.schuster22hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('silas.schuster22hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Silas Schuster', TRUE, DATE '2005-11-11')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Silas Schuster', 'woman', ARRAY['man']::text[], 'both', DATE '2005-11-11',
    'Indiranagar', 'India', 12.9278, 77.5799, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['🗣 Language', '🎵 Music', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #5
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/69.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-5-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-5-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Silas Schuster
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'dating', 'What makes a conversation instantly click for you?', NOW() - interval '44 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What makes a conversation instantly click for you?');

  -- User #6: Treva Reilly (treva_reilly65gmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('treva_reilly65gmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Treva Reilly', TRUE, DATE '1994-12-12')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Treva Reilly', 'woman', ARRAY['man']::text[], 'both', DATE '1994-12-12',
    'Whitefield', 'India', 12.9442, 77.4834, 'Architect obsessed with brutalist buildings, house plants, and jazz vinyl.', ARRAY['📸 Photography', '🍃 Nature', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #6
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/91255601', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-6-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-6-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #7: Ciara Little (ciara.littleyahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('ciara.littleyahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Ciara Little', TRUE, DATE '1994-10-05')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Ciara Little', 'man', ARRAY['woman','man']::text[], 'both', DATE '1994-10-05',
    'Bengaluru', 'India', 13.039, 77.5756, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['⚽️ Football', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #7
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/80230105', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-7-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-7-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #8: Kacie Mann (kacie.mann54hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('kacie.mann54hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Kacie Mann', TRUE, DATE '2003-02-19')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Kacie Mann', 'man', ARRAY['woman','man']::text[], 'both', DATE '2003-02-19',
    'Bengaluru', 'India', 12.9657, 77.5808, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['🗣 Language', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #8
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/66.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-8-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-8-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #9: Emory Cole (emory_coleyahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('emory_coleyahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Emory Cole', TRUE, DATE '2001-11-13')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Emory Cole', 'man', ARRAY['woman','man']::text[], 'both', DATE '2001-11-13',
    'Bengaluru', 'India', 12.9019, 77.5813, 'Architect obsessed with brutalist buildings, house plants, and jazz vinyl.', ARRAY['📸 Photography', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #9
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/72670349', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-9-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-9-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #10: Malinda Nienow (malinda.nienowhotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('malinda.nienowhotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Malinda Nienow', TRUE, DATE '2001-09-07')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Malinda Nienow', 'man', ARRAY['woman']::text[], 'both', DATE '2001-09-07',
    'Bengaluru', 'India', 12.9717, 77.5802, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['💪 Gym & Fitness', '✍🏻 Writing', '📸 Photography', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #10
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/98.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-10-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-10-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Malinda Nienow
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'travel', 'If you could catch a flight to anywhere right now, where would you go?', NOW() - interval '23 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'If you could catch a flight to anywhere right now, where would you go?');

  -- User #11: Mitchel Bruen (mitchel.bruen97gmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('mitchel.bruen97gmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Mitchel Bruen', TRUE, DATE '2002-09-03')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Mitchel Bruen', 'woman', ARRAY['man']::text[], 'partner', DATE '2002-09-03',
    'Bengaluru', 'India', 12.8668, 77.5651, 'Badminton player, sourdough baker, and trivia night enthusiast.', ARRAY['🏝 Travel', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #11
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/46.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-11-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-11-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #12: Madilyn Wisoky (madilyn_wisokygmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('madilyn_wisokygmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Madilyn Wisoky', TRUE, DATE '1998-02-26')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Madilyn Wisoky', 'man', ARRAY['woman']::text[], 'friends', DATE '1998-02-26',
    'Koramangala', 'India', 12.9216, 77.5394, 'Learning guitar and cooking regional curries from scratch.', ARRAY['💪 Gym & Fitness', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #12
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/70.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-12-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-12-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #13: Gerry Carter (gerry.carter92yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('gerry.carter92yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Gerry Carter', TRUE, DATE '2005-02-27')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Gerry Carter', 'woman', ARRAY['woman','man']::text[], 'partner', DATE '2005-02-27',
    'Whitefield', 'India', 12.8902, 77.6222, 'Med researcher who loves scuba diving, museums, and chai stalls.', ARRAY['🍃 Nature', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #13
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/49.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-13-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-13-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #14: Aurelie Bins (aurelie_bins39gmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('aurelie_bins39gmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Aurelie Bins', TRUE, DATE '1994-10-18')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Aurelie Bins', 'man', ARRAY['woman','man']::text[], 'both', DATE '1994-10-18',
    'Jayanagar', 'India', 12.8978, 77.5676, 'Product designer by day, indie concert hunter by night.', ARRAY['✍🏻 Writing', '🎵 Music', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #14
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/4985236', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-14-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-14-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #15: Jacey Reichel (jacey.reichel82hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jacey.reichel82hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Jacey Reichel', TRUE, DATE '2000-03-16')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jacey Reichel', 'man', ARRAY['woman','man']::text[], 'both', DATE '2000-03-16',
    'Bengaluru', 'India', 13.0033, 77.4936, 'Badminton player, sourdough baker, and trivia night enthusiast.', ARRAY['🎵 Music', '🙂 People', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #15
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/62.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-15-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-15-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Jacey Reichel
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'nature', 'Mountains, beaches, or quiet forest trails? Pick your sanctuary.', NOW() - interval '34 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Mountains, beaches, or quiet forest trails? Pick your sanctuary.');

  -- User #16: Patsy Bernier (patsy.bernier99yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('patsy.bernier99yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Patsy Bernier', TRUE, DATE '2002-09-05')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Patsy Bernier', 'man', ARRAY['woman']::text[], 'friends', DATE '2002-09-05',
    'Bengaluru', 'India', 12.8876, 77.5402, 'Tech startup dev. Passionate about open-source, bouldering, and board games.', ARRAY['⚽️ Football', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #16
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/95.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-16-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-16-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #17: Omari Jaskolski (omari_jaskolskigmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('omari_jaskolskigmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Omari Jaskolski', TRUE, DATE '2000-11-10')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Omari Jaskolski', 'woman', ARRAY['man']::text[], 'friends', DATE '2000-11-10',
    'Bengaluru', 'India', 13.0092, 77.7139, 'Tech startup dev. Passionate about open-source, bouldering, and board games.', ARRAY['🗣 Language', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #17
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/61.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-17-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-17-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #18: Bettie Hyatt (bettie_hyatt69gmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('bettie_hyatt69gmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Bettie Hyatt', TRUE, DATE '2003-06-10')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Bettie Hyatt', 'woman', ARRAY['man']::text[], 'both', DATE '2003-06-10',
    'Jayanagar', 'India', 13.0404, 77.7126, 'Badminton player, sourdough baker, and trivia night enthusiast.', ARRAY['🎵 Music', '✍🏻 Writing', '📸 Photography', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #18
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/91076031', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-18-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-18-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #19: Allan Kreiger (allan_kreiger6yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('allan_kreiger6yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Allan Kreiger', TRUE, DATE '2004-10-11')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Allan Kreiger', 'woman', ARRAY['man']::text[], 'friends', DATE '2004-10-11',
    'Bengaluru', 'India', 13.0558, 77.4783, 'Product designer by day, indie concert hunter by night.', ARRAY['🙂 People', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #19
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/5689547', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-19-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-19-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #20: Jabari Balistreri (jabari_balistreri68gmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jabari_balistreri68gmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Jabari Balistreri', TRUE, DATE '1997-07-18')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jabari Balistreri', 'woman', ARRAY['woman','man']::text[], 'both', DATE '1997-07-18',
    'Bengaluru', 'India', 13.0381, 77.5336, 'Learning guitar and cooking regional curries from scratch.', ARRAY['🗣 Language', '⚽️ Football', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #20
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/28259228', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-20-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-20-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Jabari Balistreri
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'food', 'The best cafe or street food spot in town that nobody talks about?', NOW() - interval '34 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'The best cafe or street food spot in town that nobody talks about?');

  -- User #21: Antonetta Bergstrom (antonetta_bergstromgmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('antonetta_bergstromgmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Antonetta Bergstrom', TRUE, DATE '2003-11-12')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Antonetta Bergstrom', 'woman', ARRAY['man']::text[], 'both', DATE '2003-11-12',
    'Koramangala', 'India', 12.9719, 77.6735, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['🗣 Language', '🙂 People', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #21
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/30875378', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-21-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-21-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #22: Andreanne Kuhlman (andreanne_kuhlmangmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('andreanne_kuhlmangmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Andreanne Kuhlman', TRUE, DATE '1999-04-23')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Andreanne Kuhlman', 'woman', ARRAY['man']::text[], 'friends', DATE '1999-04-23',
    'Bengaluru', 'India', 13.0802, 77.6121, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['⚽️ Football', '🙂 People', '🍃 Nature', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #22
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/13.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-22-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-22-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #23: Zaria Schiller (zaria_schillergmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('zaria_schillergmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Zaria Schiller', TRUE, DATE '1999-05-06')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Zaria Schiller', 'man', ARRAY['woman','man']::text[], 'partner', DATE '1999-05-06',
    'Whitefield', 'India', 12.9469, 77.5181, 'Tech startup dev. Passionate about open-source, bouldering, and board games.', ARRAY['🗣 Language', '💪 Gym & Fitness', '👗 Fashion', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #23
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/89.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-23-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-23-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #24: Ethan Rolfson (ethan.rolfsongmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('ethan.rolfsongmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Ethan Rolfson', TRUE, DATE '2003-01-04')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Ethan Rolfson', 'man', ARRAY['woman']::text[], 'both', DATE '2003-01-04',
    'Bengaluru', 'India', 12.9311, 77.4783, 'Always in search of the best specialty coffee and quiet reading nooks.', ARRAY['🍃 Nature', '💪 Gym & Fitness', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #24
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/66.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-24-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-24-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #25: Chelsea Spinka (chelsea.spinka72hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('chelsea.spinka72hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Chelsea Spinka', TRUE, DATE '2005-09-18')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Chelsea Spinka', 'man', ARRAY['woman','man']::text[], 'both', DATE '2005-09-18',
    'Bengaluru', 'India', 12.8769, 77.4844, 'Always in search of the best specialty coffee and quiet reading nooks.', ARRAY['💪 Gym & Fitness', '⚽️ Football', '👗 Fashion', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #25
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/63.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-25-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-25-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Chelsea Spinka
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'lifestyle', 'What does your absolute ideal, completely unscheduled Sunday look like?', NOW() - interval '48 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What does your absolute ideal, completely unscheduled Sunday look like?');

  -- User #26: Reese Schmeler (reese_schmeleryahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('reese_schmeleryahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Reese Schmeler', TRUE, DATE '2001-06-20')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Reese Schmeler', 'woman', ARRAY['man']::text[], 'friends', DATE '2001-06-20',
    'Koramangala', 'India', 12.9584, 77.671, 'Architect obsessed with brutalist buildings, house plants, and jazz vinyl.', ARRAY['🙂 People', '⚽️ Football', '🗣 Language', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #26
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/37036813', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-26-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-26-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #27: Ellie Rath (ellie.rathhotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('ellie.rathhotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Ellie Rath', TRUE, DATE '1996-05-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Ellie Rath', 'man', ARRAY['woman']::text[], 'both', DATE '1996-05-28',
    'Whitefield', 'India', 12.9087, 77.4896, 'Med researcher who loves scuba diving, museums, and chai stalls.', ARRAY['⚽️ Football', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #27
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/81389900', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-27-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-27-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #28: Kamron Abernathy (kamron_abernathygmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('kamron_abernathygmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Kamron Abernathy', TRUE, DATE '1999-03-23')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Kamron Abernathy', 'man', ARRAY['woman']::text[], 'both', DATE '1999-03-23',
    'Jayanagar', 'India', 13.0766, 77.6303, 'Med researcher who loves scuba diving, museums, and chai stalls.', ARRAY['👗 Fashion', '🎵 Music', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #28
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/8.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-28-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-28-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #29: Earlene Buckridge (earlene_buckridge10yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('earlene_buckridge10yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Earlene Buckridge', TRUE, DATE '1994-10-24')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Earlene Buckridge', 'woman', ARRAY['man']::text[], 'both', DATE '1994-10-24',
    'Koramangala', 'India', 13.0643, 77.5057, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['👗 Fashion', '✍🏻 Writing', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #29
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/59.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-29-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-29-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #30: Abe Cremin (abe_creminyahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('abe_creminyahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Abe Cremin', TRUE, DATE '2005-08-25')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Abe Cremin', 'man', ARRAY['woman']::text[], 'both', DATE '2005-08-25',
    'Jayanagar', 'India', 12.9638, 77.6626, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['⚽️ Football', '💪 Gym & Fitness', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #30
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/78934374', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-30-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-30-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Abe Cremin
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'fitness', 'Morning workout person or night owl runner? How do you stay active?', NOW() - interval '44 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Morning workout person or night owl runner? How do you stay active?');

  -- User #31: Corrine Harris (corrine.harris30hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('corrine.harris30hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Corrine Harris', TRUE, DATE '2000-06-17')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Corrine Harris', 'woman', ARRAY['man']::text[], 'partner', DATE '2000-06-17',
    'Bengaluru', 'India', 12.9435, 77.5918, 'Tech startup dev. Passionate about open-source, bouldering, and board games.', ARRAY['⚽️ Football', '🎵 Music', '✍🏻 Writing', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #31
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/98.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-31-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-31-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #32: Courtney Hessel (courtney_hessel23gmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('courtney_hessel23gmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Courtney Hessel', TRUE, DATE '2002-05-05')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Courtney Hessel', 'woman', ARRAY['man']::text[], 'both', DATE '2002-05-05',
    'Koramangala', 'India', 12.9224, 77.6537, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['🏝 Travel', '📸 Photography', '⚽️ Football', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #32
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/23895530', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-32-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-32-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #33: Orval Fadel (orval_fadelgmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('orval_fadelgmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Orval Fadel', TRUE, DATE '2005-01-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Orval Fadel', 'man', ARRAY['woman']::text[], 'both', DATE '2005-01-28',
    'Bengaluru', 'India', 12.868, 77.6636, 'Weekend road trips, film photography, and spicy street food.', ARRAY['🙂 People', '🗣 Language', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #33
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/50.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-33-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-33-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #34: Hermann Pollich-Ward (hermann_pollich-ward54yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('hermann_pollich-ward54yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Hermann Pollich-Ward', TRUE, DATE '2004-11-21')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Hermann Pollich-Ward', 'woman', ARRAY['man']::text[], 'both', DATE '2004-11-21',
    'Indiranagar', 'India', 13.0141, 77.7123, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['⚽️ Football', '💪 Gym & Fitness', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #34
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/33934853', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-34-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-34-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #35: Theodore Raynor (theodore.raynor99yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('theodore.raynor99yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Theodore Raynor', TRUE, DATE '1994-12-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Theodore Raynor', 'man', ARRAY['woman']::text[], 'partner', DATE '1994-12-02',
    'Jayanagar', 'India', 12.9876, 77.5093, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['🎵 Music', '✍🏻 Writing', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #35
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/9542981', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-35-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-35-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Theodore Raynor
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'creative', 'What book, movie, or song genuinely changed how you see things?', NOW() - interval '18 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What book, movie, or song genuinely changed how you see things?');

  -- User #36: Cecile Green (cecile_greengmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('cecile_greengmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Cecile Green', TRUE, DATE '2002-02-27')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Cecile Green', 'woman', ARRAY['man']::text[], 'partner', DATE '2002-02-27',
    'Bengaluru', 'India', 12.8824, 77.5074, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['🙂 People', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #36
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/47456945', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-36-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-36-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #37: Amparo Hettinger (amparo_hettingeryahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('amparo_hettingeryahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Amparo Hettinger', TRUE, DATE '2004-02-04')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Amparo Hettinger', 'woman', ARRAY['man']::text[], 'friends', DATE '2004-02-04',
    'Bengaluru', 'India', 13.0554, 77.5514, 'Data scientist with a weak spot for dog memes and Sunday morning hikes.', ARRAY['👗 Fashion', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #37
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/58079338', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-37-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-37-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #38: Ora Howell-Dickens (ora.howell-dickens33yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('ora.howell-dickens33yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Ora Howell-Dickens', TRUE, DATE '2004-09-20')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Ora Howell-Dickens', 'man', ARRAY['woman']::text[], 'both', DATE '2004-09-20',
    'Bengaluru', 'India', 13.0451, 77.5996, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['💪 Gym & Fitness', '🎵 Music', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #38
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/81.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-38-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-38-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #39: Amaya Grady (amaya.gradygmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('amaya.gradygmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Amaya Grady', TRUE, DATE '2003-08-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Amaya Grady', 'man', ARRAY['woman']::text[], 'both', DATE '2003-08-02',
    'Jayanagar', 'India', 12.9896, 77.6811, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['⚽️ Football', '🎵 Music', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #39
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/73.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-39-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-39-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #40: Jared Koch (jared.kochyahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jared.kochyahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Jared Koch', TRUE, DATE '2004-11-09')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jared Koch', 'man', ARRAY['woman']::text[], 'partner', DATE '2004-11-09',
    'HSR Layout', 'India', 12.8757, 77.4876, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['🗣 Language', '⚽️ Football', '💪 Gym & Fitness', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #40
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/30.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-40-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-40-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Jared Koch
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'travel', 'If you could catch a flight to anywhere right now, where would you go?', NOW() - interval '37 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'If you could catch a flight to anywhere right now, where would you go?');

  -- User #41: Dario Heidenreich (dario.heidenreich60yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('dario.heidenreich60yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Dario Heidenreich', TRUE, DATE '2005-09-27')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Dario Heidenreich', 'woman', ARRAY['man']::text[], 'friends', DATE '2005-09-27',
    'Jayanagar', 'India', 12.8565, 77.5659, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['✍🏻 Writing', '🗣 Language', '🏝 Travel', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #41
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/53911217', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-41-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-41-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #42: Lisandro Kub-Spencer (lisandro_kub-spencerhotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('lisandro_kub-spencerhotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Lisandro Kub-Spencer', TRUE, DATE '2002-04-27')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Lisandro Kub-Spencer', 'woman', ARRAY['woman','man']::text[], 'partner', DATE '2002-04-27',
    'Bengaluru', 'India', 13.0027, 77.6955, 'Learning guitar and cooking regional curries from scratch.', ARRAY['✍🏻 Writing', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #42
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/92315769', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-42-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-42-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #43: Pablo Rice (pablo.rice63hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('pablo.rice63hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Pablo Rice', TRUE, DATE '1995-07-05')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Pablo Rice', 'man', ARRAY['woman']::text[], 'both', DATE '1995-07-05',
    'Whitefield', 'India', 12.9215, 77.4841, 'Weekend road trips, film photography, and spicy street food.', ARRAY['✍🏻 Writing', '🙂 People', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #43
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/35.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-43-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-43-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #44: Susie Schmeler (susie_schmeler51gmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('susie_schmeler51gmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Susie Schmeler', TRUE, DATE '1995-10-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Susie Schmeler', 'man', ARRAY['woman']::text[], 'friends', DATE '1995-10-28',
    'Bengaluru', 'India', 12.9088, 77.6071, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['🎵 Music', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #44
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/24176407', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-44-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-44-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #45: Jodie Kling (jodie_klinghotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jodie_klinghotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Jodie Kling', TRUE, DATE '1997-06-12')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jodie Kling', 'woman', ARRAY['woman','man']::text[], 'friends', DATE '1997-06-12',
    'Bengaluru', 'India', 12.9338, 77.6834, 'Marathon training in progress. Will run for good pastries.', ARRAY['💪 Gym & Fitness', '🍃 Nature', '⚽️ Football', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #45
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/69.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-45-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-45-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Jodie Kling
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'philosophy', 'What is an unpopular opinion you are willing to defend forever?', NOW() - interval '30 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What is an unpopular opinion you are willing to defend forever?');

  -- User #46: Odessa Brakus (odessa.brakushotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('odessa.brakushotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Odessa Brakus', TRUE, DATE '1995-02-04')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Odessa Brakus', 'woman', ARRAY['man']::text[], 'partner', DATE '1995-02-04',
    'Bengaluru', 'India', 12.9561, 77.6678, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['🏝 Travel', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #46
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/77.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-46-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-46-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #47: Angie O''Conner (angie_oconner79yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('angie_oconner79yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Angie O''Conner', TRUE, DATE '2005-07-10')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Angie O''Conner', 'man', ARRAY['woman']::text[], 'friends', DATE '2005-07-10',
    'Koramangala', 'India', 12.9208, 77.5845, 'Architect obsessed with brutalist buildings, house plants, and jazz vinyl.', ARRAY['⚽️ Football', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #47
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/41449197', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-47-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-47-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #48: Madilyn Hintz (madilyn.hintz61hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('madilyn.hintz61hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Madilyn Hintz', TRUE, DATE '2001-04-14')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Madilyn Hintz', 'woman', ARRAY['man']::text[], 'partner', DATE '2001-04-14',
    'Indiranagar', 'India', 12.9859, 77.6667, 'Badminton player, sourdough baker, and trivia night enthusiast.', ARRAY['🎵 Music', '⚽️ Football', '🙂 People', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #48
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/96758886', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-48-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-48-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #49: Stephan King (stephan.king53yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('stephan.king53yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Stephan King', TRUE, DATE '1995-04-11')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Stephan King', 'woman', ARRAY['woman','man']::text[], 'partner', DATE '1995-04-11',
    'Koramangala', 'India', 13.0722, 77.5977, 'Tech startup dev. Passionate about open-source, bouldering, and board games.', ARRAY['🏝 Travel', '🎵 Music', '🍃 Nature', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #49
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/26.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-49-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-49-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #50: Alfred Ernser (alfred_ernser1yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('alfred_ernser1yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Alfred Ernser', TRUE, DATE '1996-02-23')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Alfred Ernser', 'man', ARRAY['woman']::text[], 'both', DATE '1996-02-23',
    'Bengaluru', 'India', 12.8815, 77.4871, 'Product designer by day, indie concert hunter by night.', ARRAY['🏝 Travel', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #50
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/73.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-50-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-50-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Alfred Ernser
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'philosophy', 'What is an unpopular opinion you are willing to defend forever?', NOW() - interval '30 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What is an unpopular opinion you are willing to defend forever?');

  -- User #51: Veronica Carroll (veronica_carroll18gmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('veronica_carroll18gmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Veronica Carroll', TRUE, DATE '2003-08-04')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Veronica Carroll', 'woman', ARRAY['man']::text[], 'partner', DATE '2003-08-04',
    'Koramangala', 'India', 12.8788, 77.6777, 'Learning guitar and cooking regional curries from scratch.', ARRAY['🙂 People', '🍃 Nature', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #51
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/69771297', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-51-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-51-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #52: Daren Morissette (daren_morissettehotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('daren_morissettehotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Daren Morissette', TRUE, DATE '2004-01-06')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Daren Morissette', 'man', ARRAY['woman']::text[], 'friends', DATE '2004-01-06',
    'Indiranagar', 'India', 13.0373, 77.6567, 'Marathon training in progress. Will run for good pastries.', ARRAY['⚽️ Football', '🏝 Travel', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #52
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/91.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-52-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-52-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #53: George Kovacek (george.kovacekgmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('george.kovacekgmail.com', crypt('demo1234', gen_salt('bf', 10)), 'George Kovacek', TRUE, DATE '1995-04-26')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'George Kovacek', 'man', ARRAY['woman']::text[], 'both', DATE '1995-04-26',
    'Bengaluru', 'India', 12.9989, 77.4787, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['👗 Fashion', '💪 Gym & Fitness', '⚽️ Football', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #53
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/5803360', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-53-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-53-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #54: Jalyn Feest (jalyn_feest93hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jalyn_feest93hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Jalyn Feest', TRUE, DATE '2000-10-24')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jalyn Feest', 'man', ARRAY['woman']::text[], 'both', DATE '2000-10-24',
    'Koramangala', 'India', 13.0683, 77.4754, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['💪 Gym & Fitness', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #54
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/19713522', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-54-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-54-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #55: Rey Leuschke (rey_leuschke64hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('rey_leuschke64hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Rey Leuschke', TRUE, DATE '2001-05-08')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Rey Leuschke', 'woman', ARRAY['man']::text[], 'both', DATE '2001-05-08',
    'Bengaluru', 'India', 12.8576, 77.647, 'Weekend road trips, film photography, and spicy street food.', ARRAY['🙂 People', '🎵 Music', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #55
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/90.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-55-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-55-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Rey Leuschke
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'dating', 'What makes a conversation instantly click for you?', NOW() - interval '28 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What makes a conversation instantly click for you?');

  -- User #56: Cecil Greenholt (cecil_greenholthotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('cecil_greenholthotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Cecil Greenholt', TRUE, DATE '2002-04-19')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Cecil Greenholt', 'woman', ARRAY['man']::text[], 'partner', DATE '2002-04-19',
    'Whitefield', 'India', 12.9255, 77.5141, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['✍🏻 Writing', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #56
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/29.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-56-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-56-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #57: Jameson DuBuque (jameson.dubuque71gmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jameson.dubuque71gmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Jameson DuBuque', TRUE, DATE '1998-09-11')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jameson DuBuque', 'man', ARRAY['woman']::text[], 'both', DATE '1998-09-11',
    'Bengaluru', 'India', 12.942, 77.6382, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['🍃 Nature', '🏝 Travel', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #57
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/25094184', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-57-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-57-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #58: Sherwood Beier (sherwood_beier16yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('sherwood_beier16yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Sherwood Beier', TRUE, DATE '2002-12-03')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Sherwood Beier', 'man', ARRAY['woman']::text[], 'both', DATE '2002-12-03',
    'Indiranagar', 'India', 12.9573, 77.6507, 'Med researcher who loves scuba diving, museums, and chai stalls.', ARRAY['💪 Gym & Fitness', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #58
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/38335201', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-58-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-58-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #59: Davin Hilpert (davin.hilpert43yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('davin.hilpert43yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Davin Hilpert', TRUE, DATE '1999-01-27')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Davin Hilpert', 'woman', ARRAY['man']::text[], 'both', DATE '1999-01-27',
    'Whitefield', 'India', 12.9011, 77.585, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['🏝 Travel', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #59
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/70489418', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-59-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-59-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #60: Chanel Farrell (chanel_farrell73hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('chanel_farrell73hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Chanel Farrell', TRUE, DATE '1995-02-10')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Chanel Farrell', 'woman', ARRAY['woman','man']::text[], 'both', DATE '1995-02-10',
    'Jayanagar', 'India', 12.9425, 77.5207, 'Architect obsessed with brutalist buildings, house plants, and jazz vinyl.', ARRAY['👗 Fashion', '🙂 People', '⚽️ Football', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #60
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/9.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-60-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-60-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Chanel Farrell
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'philosophy', 'What is an unpopular opinion you are willing to defend forever?', NOW() - interval '30 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What is an unpopular opinion you are willing to defend forever?');

  -- User #61: Matt Rolfson (matt.rolfson86yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('matt.rolfson86yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Matt Rolfson', TRUE, DATE '2002-10-13')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Matt Rolfson', 'man', ARRAY['woman','man']::text[], 'friends', DATE '2002-10-13',
    'Koramangala', 'India', 13.0221, 77.5308, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['🎵 Music', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #61
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/72.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-61-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-61-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #62: Hermann Gibson (hermann_gibson2hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('hermann_gibson2hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Hermann Gibson', TRUE, DATE '2002-10-21')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Hermann Gibson', 'woman', ARRAY['man']::text[], 'partner', DATE '2002-10-21',
    'Bengaluru', 'India', 13.0194, 77.5635, 'Weekend road trips, film photography, and spicy street food.', ARRAY['🎵 Music', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #62
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/60780621', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-62-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-62-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #63: Mittie Kuphal (mittie_kuphalgmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('mittie_kuphalgmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Mittie Kuphal', TRUE, DATE '1994-12-04')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Mittie Kuphal', 'man', ARRAY['woman','man']::text[], 'friends', DATE '1994-12-04',
    'HSR Layout', 'India', 13.0026, 77.688, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['🙂 People', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #63
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/86.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-63-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-63-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #64: Marisa Swaniawski (marisa_swaniawskiyahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('marisa_swaniawskiyahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Marisa Swaniawski', TRUE, DATE '1995-12-01')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Marisa Swaniawski', 'woman', ARRAY['woman','man']::text[], 'friends', DATE '1995-12-01',
    'Jayanagar', 'India', 12.8647, 77.5044, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['🗣 Language', '📸 Photography', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #64
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/75663582', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-64-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-64-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #65: Donald Hermann (donald_hermannhotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('donald_hermannhotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Donald Hermann', TRUE, DATE '1995-07-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Donald Hermann', 'man', ARRAY['woman']::text[], 'friends', DATE '1995-07-02',
    'Bengaluru', 'India', 13.0893, 77.5744, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['👗 Fashion', '🏝 Travel', '🗣 Language', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #65
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/555449', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-65-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-65-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Donald Hermann
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'nature', 'Mountains, beaches, or quiet forest trails? Pick your sanctuary.', NOW() - interval '9 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Mountains, beaches, or quiet forest trails? Pick your sanctuary.');

  -- User #66: Josefa Grimes (josefa.grimes40yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('josefa.grimes40yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Josefa Grimes', TRUE, DATE '1997-02-23')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Josefa Grimes', 'man', ARRAY['woman']::text[], 'friends', DATE '1997-02-23',
    'HSR Layout', 'India', 12.9495, 77.5366, 'Tech startup dev. Passionate about open-source, bouldering, and board games.', ARRAY['🏝 Travel', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #66
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/76.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-66-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-66-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #67: Rex Collier (rex.collier12yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('rex.collier12yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Rex Collier', TRUE, DATE '2003-06-26')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Rex Collier', 'man', ARRAY['woman']::text[], 'both', DATE '2003-06-26',
    'Koramangala', 'India', 12.939, 77.543, 'Always in search of the best specialty coffee and quiet reading nooks.', ARRAY['🗣 Language', '⚽️ Football', '✍🏻 Writing', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #67
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/30636913', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-67-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-67-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #68: Elliot Osinski (elliot_osinski38hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('elliot_osinski38hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Elliot Osinski', TRUE, DATE '1995-08-14')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Elliot Osinski', 'woman', ARRAY['man']::text[], 'partner', DATE '1995-08-14',
    'HSR Layout', 'India', 13.0075, 77.5402, 'Marathon training in progress. Will run for good pastries.', ARRAY['🍃 Nature', '⚽️ Football', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #68
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/9019197', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-68-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-68-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #69: Robb Bechtelar (robb_bechtelar94yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('robb_bechtelar94yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Robb Bechtelar', TRUE, DATE '2001-10-15')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Robb Bechtelar', 'man', ARRAY['woman']::text[], 'both', DATE '2001-10-15',
    'Jayanagar', 'India', 12.9911, 77.4825, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['🙂 People', '⚽️ Football', '🗣 Language', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #69
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/59573038', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-69-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-69-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #70: Brenden Hyatt (brenden_hyatt21yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('brenden_hyatt21yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Brenden Hyatt', TRUE, DATE '2003-12-06')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Brenden Hyatt', 'man', ARRAY['woman','man']::text[], 'both', DATE '2003-12-06',
    'Bengaluru', 'India', 12.8882, 77.7062, 'Product designer by day, indie concert hunter by night.', ARRAY['🍃 Nature', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #70
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/76173394', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-70-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-70-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Brenden Hyatt
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'lifestyle', 'What does your absolute ideal, completely unscheduled Sunday look like?', NOW() - interval '7 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What does your absolute ideal, completely unscheduled Sunday look like?');

  -- User #71: Alene Parisian (alene.parisiangmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('alene.parisiangmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Alene Parisian', TRUE, DATE '1997-04-03')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Alene Parisian', 'man', ARRAY['woman']::text[], 'friends', DATE '1997-04-03',
    'Whitefield', 'India', 12.9136, 77.6579, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['🏝 Travel', '🍃 Nature', '📸 Photography', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #71
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/97230141', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-71-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-71-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #72: Sherwood Shields (sherwood_shieldsyahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('sherwood_shieldsyahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Sherwood Shields', TRUE, DATE '2003-07-04')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Sherwood Shields', 'woman', ARRAY['man']::text[], 'partner', DATE '2003-07-04',
    'Whitefield', 'India', 13.0814, 77.6815, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['👗 Fashion', '🗣 Language', '🍃 Nature', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #72
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/34.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-72-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-72-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #73: Edwardo Zieme (edwardo_ziemeyahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('edwardo_ziemeyahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Edwardo Zieme', TRUE, DATE '1998-02-06')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Edwardo Zieme', 'woman', ARRAY['woman','man']::text[], 'partner', DATE '1998-02-06',
    'HSR Layout', 'India', 12.8698, 77.6285, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['👗 Fashion', '💪 Gym & Fitness', '🏝 Travel', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #73
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/39896085', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-73-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-73-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #74: Tate Carter (tate_carter82hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('tate_carter82hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Tate Carter', TRUE, DATE '2005-09-25')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Tate Carter', 'man', ARRAY['woman']::text[], 'both', DATE '2005-09-25',
    'Koramangala', 'India', 12.9727, 77.6753, 'Architect obsessed with brutalist buildings, house plants, and jazz vinyl.', ARRAY['🏝 Travel', '✍🏻 Writing', '💪 Gym & Fitness', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #74
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/51.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-74-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-74-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #75: Sydney Deckow (sydney_deckowgmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('sydney_deckowgmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Sydney Deckow', TRUE, DATE '2005-08-18')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Sydney Deckow', 'woman', ARRAY['woman','man']::text[], 'partner', DATE '2005-08-18',
    'Indiranagar', 'India', 12.8772, 77.7124, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['👗 Fashion', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #75
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/79952356', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-75-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-75-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Sydney Deckow
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'language', 'If you could instantly speak any language fluently, which one and why?', NOW() - interval '20 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'If you could instantly speak any language fluently, which one and why?');

  -- User #76: Dane Batz (dane_batzhotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('dane_batzhotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Dane Batz', TRUE, DATE '1997-10-05')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Dane Batz', 'woman', ARRAY['woman','man']::text[], 'friends', DATE '1997-10-05',
    'Indiranagar', 'India', 13.0182, 77.6061, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['🍃 Nature', '🙂 People', '🏝 Travel', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #76
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/50645178', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-76-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-76-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #77: Carole Pollich (carole.pollichhotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('carole.pollichhotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Carole Pollich', TRUE, DATE '2004-05-12')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Carole Pollich', 'man', ARRAY['woman']::text[], 'partner', DATE '2004-05-12',
    'Indiranagar', 'India', 12.8525, 77.6831, 'Tech startup dev. Passionate about open-source, bouldering, and board games.', ARRAY['💪 Gym & Fitness', '✍🏻 Writing', '📸 Photography', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #77
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/81.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-77-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-77-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #78: Pascale Kuphal (pascale_kuphal45hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('pascale_kuphal45hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Pascale Kuphal', TRUE, DATE '2002-02-01')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Pascale Kuphal', 'man', ARRAY['woman']::text[], 'both', DATE '2002-02-01',
    'Whitefield', 'India', 12.8823, 77.6416, 'Data scientist with a weak spot for dog memes and Sunday morning hikes.', ARRAY['✍🏻 Writing', '👗 Fashion', '📸 Photography', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #78
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/52437326', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-78-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-78-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #79: Sim Kozey (sim.kozeyyahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('sim.kozeyyahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Sim Kozey', TRUE, DATE '2004-08-25')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Sim Kozey', 'man', ARRAY['woman']::text[], 'both', DATE '2004-08-25',
    'Jayanagar', 'India', 12.964, 77.6655, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['🎵 Music', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #79
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/96304149', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-79-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-79-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #80: Jimmie Lockman (jimmie_lockmanyahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jimmie_lockmanyahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Jimmie Lockman', TRUE, DATE '1995-05-08')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jimmie Lockman', 'woman', ARRAY['woman','man']::text[], 'both', DATE '1995-05-08',
    'Jayanagar', 'India', 12.9647, 77.54, 'Data scientist with a weak spot for dog memes and Sunday morning hikes.', ARRAY['🙂 People', '💪 Gym & Fitness', '✍🏻 Writing', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #80
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/16020996', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-80-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-80-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Jimmie Lockman
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'food', 'The best cafe or street food spot in town that nobody talks about?', NOW() - interval '28 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'The best cafe or street food spot in town that nobody talks about?');

  -- User #81: Vella Howe (vella.howe50hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('vella.howe50hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Vella Howe', TRUE, DATE '2000-07-09')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Vella Howe', 'woman', ARRAY['man']::text[], 'partner', DATE '2000-07-09',
    'Whitefield', 'India', 13.0211, 77.5421, 'Architect obsessed with brutalist buildings, house plants, and jazz vinyl.', ARRAY['🏝 Travel', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #81
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/45498473', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-81-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-81-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #82: Kenya Dicki (kenya_dicki62yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('kenya_dicki62yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Kenya Dicki', TRUE, DATE '1994-08-19')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Kenya Dicki', 'man', ARRAY['woman']::text[], 'friends', DATE '1994-08-19',
    'HSR Layout', 'India', 12.9089, 77.5561, 'Architect obsessed with brutalist buildings, house plants, and jazz vinyl.', ARRAY['👗 Fashion', '⚽️ Football', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #82
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/73.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-82-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-82-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #83: Cortez Wyman (cortez_wyman29yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('cortez_wyman29yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Cortez Wyman', TRUE, DATE '1996-03-04')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Cortez Wyman', 'woman', ARRAY['man']::text[], 'friends', DATE '1996-03-04',
    'Whitefield', 'India', 12.8795, 77.5376, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['🍃 Nature', '👗 Fashion', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #83
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/31134772', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-83-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-83-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #84: Geo Lueilwitz (geo_lueilwitzhotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('geo_lueilwitzhotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Geo Lueilwitz', TRUE, DATE '1994-03-27')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Geo Lueilwitz', 'man', ARRAY['woman','man']::text[], 'both', DATE '1994-03-27',
    'Bengaluru', 'India', 13.0508, 77.4757, 'Learning guitar and cooking regional curries from scratch.', ARRAY['🙂 People', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #84
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/77.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-84-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-84-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #85: Benjamin Hyatt (benjamin.hyattyahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('benjamin.hyattyahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Benjamin Hyatt', TRUE, DATE '1996-05-17')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Benjamin Hyatt', 'man', ARRAY['woman']::text[], 'both', DATE '1996-05-17',
    'HSR Layout', 'India', 12.9161, 77.6719, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['✍🏻 Writing', '🎵 Music', '⚽️ Football', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #85
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/24.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-85-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-85-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Benjamin Hyatt
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'dating', 'What makes a conversation instantly click for you?', NOW() - interval '8 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What makes a conversation instantly click for you?');

  -- User #86: Corine Douglas (corine.douglashotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('corine.douglashotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Corine Douglas', TRUE, DATE '2002-01-27')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Corine Douglas', 'man', ARRAY['woman']::text[], 'friends', DATE '2002-01-27',
    'Bengaluru', 'India', 13.0108, 77.66, 'Tech startup dev. Passionate about open-source, bouldering, and board games.', ARRAY['⚽️ Football', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #86
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/57826224', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-86-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-86-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #87: Ari Kuvalis (ari_kuvalis59gmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('ari_kuvalis59gmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Ari Kuvalis', TRUE, DATE '1999-05-09')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Ari Kuvalis', 'man', ARRAY['woman']::text[], 'friends', DATE '1999-05-09',
    'Jayanagar', 'India', 12.8915, 77.712, 'Weekend road trips, film photography, and spicy street food.', ARRAY['🏝 Travel', '🙂 People', '🗣 Language', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #87
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/61511278', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-87-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-87-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #88: Velda Tremblay (velda_tremblayhotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('velda_tremblayhotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Velda Tremblay', TRUE, DATE '1996-10-13')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Velda Tremblay', 'man', ARRAY['woman','man']::text[], 'partner', DATE '1996-10-13',
    'Bengaluru', 'India', 13.0717, 77.6586, 'Marathon training in progress. Will run for good pastries.', ARRAY['🙂 People', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #88
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/45.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-88-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-88-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #89: Nikolas Braun (nikolas.braunhotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('nikolas.braunhotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Nikolas Braun', TRUE, DATE '2004-04-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Nikolas Braun', 'man', ARRAY['woman']::text[], 'both', DATE '2004-04-02',
    'Bengaluru', 'India', 13.09, 77.6176, 'Weekend road trips, film photography, and spicy street food.', ARRAY['🎵 Music', '🍃 Nature', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #89
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/83755477', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-89-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-89-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #90: Alexzander Kovacek (alexzander_kovacekyahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('alexzander_kovacekyahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Alexzander Kovacek', TRUE, DATE '1998-11-14')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Alexzander Kovacek', 'man', ARRAY['woman']::text[], 'both', DATE '1998-11-14',
    'Indiranagar', 'India', 12.9722, 77.6501, 'Product designer by day, indie concert hunter by night.', ARRAY['⚽️ Football', '🎵 Music', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #90
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/82.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-90-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-90-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Alexzander Kovacek
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'travel', 'If you could catch a flight to anywhere right now, where would you go?', NOW() - interval '41 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'If you could catch a flight to anywhere right now, where would you go?');

  -- User #91: Zion Rodriguez (zion.rodriguez1gmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('zion.rodriguez1gmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Zion Rodriguez', TRUE, DATE '2004-07-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Zion Rodriguez', 'man', ARRAY['woman']::text[], 'partner', DATE '2004-07-02',
    'HSR Layout', 'India', 13.0565, 77.6105, 'Marathon training in progress. Will run for good pastries.', ARRAY['🎵 Music', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #91
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/1376008', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-91-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-91-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #92: Clare Nikolaus (clare_nikolaus60yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('clare_nikolaus60yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Clare Nikolaus', TRUE, DATE '2002-06-20')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Clare Nikolaus', 'man', ARRAY['woman']::text[], 'both', DATE '2002-06-20',
    'Koramangala', 'India', 13.0617, 77.5354, 'Learning guitar and cooking regional curries from scratch.', ARRAY['🍃 Nature', '👗 Fashion', '📸 Photography', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #92
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/45.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-92-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-92-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #93: Brooks Tillman (brooks.tillman91yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('brooks.tillman91yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Brooks Tillman', TRUE, DATE '2003-06-10')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Brooks Tillman', 'woman', ARRAY['man']::text[], 'friends', DATE '2003-06-10',
    'Whitefield', 'India', 13.054, 77.6393, 'Weekend road trips, film photography, and spicy street food.', ARRAY['💪 Gym & Fitness', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #93
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/54917195', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-93-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-93-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #94: Cletus Dicki (cletus.dicki39yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('cletus.dicki39yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Cletus Dicki', TRUE, DATE '1995-10-27')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Cletus Dicki', 'woman', ARRAY['woman','man']::text[], 'both', DATE '1995-10-27',
    'Koramangala', 'India', 13.0338, 77.6945, 'Always in search of the best specialty coffee and quiet reading nooks.', ARRAY['👗 Fashion', '🗣 Language', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #94
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/43.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-94-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-94-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #95: Newell Walter (newell.walter58gmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('newell.walter58gmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Newell Walter', TRUE, DATE '2003-04-16')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Newell Walter', 'man', ARRAY['woman']::text[], 'both', DATE '2003-04-16',
    'Whitefield', 'India', 13.0669, 77.6722, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['🍃 Nature', '💪 Gym & Fitness', '✍🏻 Writing', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #95
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/80.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-95-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-95-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Newell Walter
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'fitness', 'Morning workout person or night owl runner? How do you stay active?', NOW() - interval '46 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Morning workout person or night owl runner? How do you stay active?');

  -- User #96: Jeremie Ryan (jeremie_ryangmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jeremie_ryangmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Jeremie Ryan', TRUE, DATE '2000-09-21')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jeremie Ryan', 'man', ARRAY['woman']::text[], 'both', DATE '2000-09-21',
    'Bengaluru', 'India', 13.0174, 77.6609, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['🏝 Travel', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #96
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/54.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-96-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-96-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #97: Cynthia Waters (cynthia_waters34yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('cynthia_waters34yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Cynthia Waters', TRUE, DATE '1997-02-20')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Cynthia Waters', 'woman', ARRAY['man']::text[], 'both', DATE '1997-02-20',
    'Bengaluru', 'India', 13.0332, 77.504, 'Marathon training in progress. Will run for good pastries.', ARRAY['📸 Photography', '🙂 People', '🏝 Travel', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #97
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/55701439', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-97-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-97-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #98: Will Okuneva (will.okuneva57gmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('will.okuneva57gmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Will Okuneva', TRUE, DATE '2001-03-19')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Will Okuneva', 'woman', ARRAY['man']::text[], 'both', DATE '2001-03-19',
    'Bengaluru', 'India', 12.8957, 77.6817, 'Badminton player, sourdough baker, and trivia night enthusiast.', ARRAY['👗 Fashion', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #98
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/92023125', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-98-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-98-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #99: Toney Littel (toney_littel36hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('toney_littel36hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Toney Littel', TRUE, DATE '2000-09-05')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Toney Littel', 'man', ARRAY['woman']::text[], 'both', DATE '2000-09-05',
    'Koramangala', 'India', 12.9839, 77.5493, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['🙂 People', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #99
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/56.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-99-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-99-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #100: Alessia Shields (alessia_shields45gmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('alessia_shields45gmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Alessia Shields', TRUE, DATE '2002-03-13')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Alessia Shields', 'woman', ARRAY['man']::text[], 'both', DATE '2002-03-13',
    'Whitefield', 'India', 12.986, 77.5734, 'Badminton player, sourdough baker, and trivia night enthusiast.', ARRAY['✍🏻 Writing', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #100
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/68740594', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-100-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-100-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Alessia Shields
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'dating', 'What makes a conversation instantly click for you?', NOW() - interval '33 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What makes a conversation instantly click for you?');

  -- User #101: Rahul Adams (rahul.adamsgmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('rahul.adamsgmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Rahul Adams', TRUE, DATE '1996-02-16')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Rahul Adams', 'woman', ARRAY['man']::text[], 'both', DATE '1996-02-16',
    'Bengaluru', 'India', 12.8805, 77.6116, 'Always in search of the best specialty coffee and quiet reading nooks.', ARRAY['🍃 Nature', '✍🏻 Writing', '🙂 People', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #101
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/8.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-101-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-101-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #102: Jaron Fisher (jaron.fisheryahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jaron.fisheryahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Jaron Fisher', TRUE, DATE '2005-11-01')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jaron Fisher', 'man', ARRAY['woman']::text[], 'both', DATE '2005-11-01',
    'Bengaluru', 'India', 12.9549, 77.5072, 'Always in search of the best specialty coffee and quiet reading nooks.', ARRAY['🗣 Language', '⚽️ Football', '👗 Fashion', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #102
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/60.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-102-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-102-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #103: Derrick Littel (derrick.littel77yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('derrick.littel77yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Derrick Littel', TRUE, DATE '2000-09-27')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Derrick Littel', 'woman', ARRAY['man']::text[], 'partner', DATE '2000-09-27',
    'Bengaluru', 'India', 13.083, 77.5786, 'Product designer by day, indie concert hunter by night.', ARRAY['🍃 Nature', '✍🏻 Writing', '🏝 Travel', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #103
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/5070878', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-103-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-103-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #104: Lavina Olson (lavina.olson59gmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('lavina.olson59gmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Lavina Olson', TRUE, DATE '2005-05-14')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Lavina Olson', 'man', ARRAY['woman','man']::text[], 'partner', DATE '2005-05-14',
    'Jayanagar', 'India', 12.921, 77.6287, 'Learning guitar and cooking regional curries from scratch.', ARRAY['🏝 Travel', '🍃 Nature', '🗣 Language', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #104
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/33641327', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-104-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-104-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #105: Marina Gusikowski (marina_gusikowskihotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('marina_gusikowskihotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Marina Gusikowski', TRUE, DATE '2002-06-22')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Marina Gusikowski', 'man', ARRAY['woman']::text[], 'both', DATE '2002-06-22',
    'Bengaluru', 'India', 13.057, 77.6319, 'Tech startup dev. Passionate about open-source, bouldering, and board games.', ARRAY['🍃 Nature', '🙂 People', '🏝 Travel', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #105
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/46.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-105-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-105-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Marina Gusikowski
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'fitness', 'Morning workout person or night owl runner? How do you stay active?', NOW() - interval '34 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Morning workout person or night owl runner? How do you stay active?');

  -- User #106: Kenyon Smith (kenyon.smithyahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('kenyon.smithyahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Kenyon Smith', TRUE, DATE '2005-12-16')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Kenyon Smith', 'man', ARRAY['woman']::text[], 'both', DATE '2005-12-16',
    'Bengaluru', 'India', 13.0364, 77.5607, 'Product designer by day, indie concert hunter by night.', ARRAY['📸 Photography', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #106
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/15473533', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-106-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-106-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #107: Donato Hane (donato.hane54yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('donato.hane54yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Donato Hane', TRUE, DATE '1995-07-05')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Donato Hane', 'man', ARRAY['woman','man']::text[], 'friends', DATE '1995-07-05',
    'Bengaluru', 'India', 12.9154, 77.5945, 'Product designer by day, indie concert hunter by night.', ARRAY['👗 Fashion', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #107
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/35.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-107-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-107-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #108: Jordi Weimann (jordi_weimannhotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jordi_weimannhotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Jordi Weimann', TRUE, DATE '2004-09-18')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jordi Weimann', 'man', ARRAY['woman']::text[], 'both', DATE '2004-09-18',
    'Koramangala', 'India', 12.8696, 77.6382, 'Product designer by day, indie concert hunter by night.', ARRAY['⚽️ Football', '🗣 Language', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #108
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/57.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-108-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-108-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #109: Bernadette Ward (bernadette.wardyahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('bernadette.wardyahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Bernadette Ward', TRUE, DATE '2002-10-21')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Bernadette Ward', 'man', ARRAY['woman']::text[], 'partner', DATE '2002-10-21',
    'Bengaluru', 'India', 12.9562, 77.6397, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['👗 Fashion', '🗣 Language', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #109
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/53686540', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-109-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-109-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #110: Michael Larkin (michael_larkin33yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('michael_larkin33yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Michael Larkin', TRUE, DATE '1998-09-21')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Michael Larkin', 'man', ARRAY['woman']::text[], 'both', DATE '1998-09-21',
    'Koramangala', 'India', 12.9813, 77.6689, 'Learning guitar and cooking regional curries from scratch.', ARRAY['🏝 Travel', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #110
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/17.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-110-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-110-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Michael Larkin
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'dating', 'What makes a conversation instantly click for you?', NOW() - interval '24 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What makes a conversation instantly click for you?');

  -- User #111: Carolyn Leannon (carolyn.leannon7hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('carolyn.leannon7hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Carolyn Leannon', TRUE, DATE '2002-09-13')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Carolyn Leannon', 'woman', ARRAY['man']::text[], 'both', DATE '2002-09-13',
    'Koramangala', 'India', 12.8726, 77.6033, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['🗣 Language', '🎵 Music', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #111
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/3848985', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-111-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-111-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #112: Solon Farrell (solon_farrellhotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('solon_farrellhotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Solon Farrell', TRUE, DATE '2002-04-21')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Solon Farrell', 'woman', ARRAY['woman','man']::text[], 'both', DATE '2002-04-21',
    'Bengaluru', 'India', 12.8681, 77.6379, 'Med researcher who loves scuba diving, museums, and chai stalls.', ARRAY['🏝 Travel', '✍🏻 Writing', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #112
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/2993631', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-112-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-112-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #113: Yvonne Davis (yvonne_davis5yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('yvonne_davis5yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Yvonne Davis', TRUE, DATE '1999-03-06')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Yvonne Davis', 'woman', ARRAY['man']::text[], 'friends', DATE '1999-03-06',
    'Bengaluru', 'India', 12.9986, 77.6884, 'Always in search of the best specialty coffee and quiet reading nooks.', ARRAY['💪 Gym & Fitness', '✍🏻 Writing', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #113
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/95956139', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-113-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-113-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #114: Ursula Boehm (ursula.boehm45yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('ursula.boehm45yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Ursula Boehm', TRUE, DATE '1998-08-05')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Ursula Boehm', 'man', ARRAY['woman']::text[], 'friends', DATE '1998-08-05',
    'Koramangala', 'India', 12.9866, 77.5454, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['🏝 Travel', '👗 Fashion', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #114
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/53863027', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-114-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-114-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #115: Everett Schumm (everett.schumm28hotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('everett.schumm28hotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Everett Schumm', TRUE, DATE '2002-09-20')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Everett Schumm', 'man', ARRAY['woman']::text[], 'both', DATE '2002-09-20',
    'Indiranagar', 'India', 13.0584, 77.5946, 'Badminton player, sourdough baker, and trivia night enthusiast.', ARRAY['📸 Photography', '🙂 People', '👗 Fashion', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #115
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/35072495', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-115-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-115-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Everett Schumm
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'lifestyle', 'What does your absolute ideal, completely unscheduled Sunday look like?', NOW() - interval '21 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What does your absolute ideal, completely unscheduled Sunday look like?');

  -- User #116: Litzy Toy (litzy.toygmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('litzy.toygmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Litzy Toy', TRUE, DATE '1996-08-17')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Litzy Toy', 'woman', ARRAY['man']::text[], 'both', DATE '1996-08-17',
    'Whitefield', 'India', 13.0754, 77.523, 'Tech startup dev. Passionate about open-source, bouldering, and board games.', ARRAY['👗 Fashion', '🎵 Music', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #116
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/15482039', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-116-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-116-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #117: Rupert Crooks (rupert.crookshotmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('rupert.crookshotmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Rupert Crooks', TRUE, DATE '1996-04-17')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Rupert Crooks', 'woman', ARRAY['man']::text[], 'friends', DATE '1996-04-17',
    'Bengaluru', 'India', 12.9834, 77.5643, 'Architect obsessed with brutalist buildings, house plants, and jazz vinyl.', ARRAY['🙂 People', '🍃 Nature', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #117
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/16.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-117-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-117-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #118: Ardella Wintheiser (ardella.wintheisergmail.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('ardella.wintheisergmail.com', crypt('demo1234', gen_salt('bf', 10)), 'Ardella Wintheiser', TRUE, DATE '1999-11-07')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Ardella Wintheiser', 'woman', ARRAY['man']::text[], 'both', DATE '1999-11-07',
    'Bengaluru', 'India', 12.9935, 77.636, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['👗 Fashion', '🗣 Language', '🙂 People', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #118
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/49.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-118-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-118-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #119: Freeman Johnson (freeman_johnson87yahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('freeman_johnson87yahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Freeman Johnson', TRUE, DATE '1994-12-20')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Freeman Johnson', 'woman', ARRAY['woman','man']::text[], 'friends', DATE '1994-12-20',
    'HSR Layout', 'India', 13.049, 77.5223, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['💪 Gym & Fitness', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #119
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/57665343', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-119-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-119-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- User #120: Michelle Blick (michelle_blickyahoo.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('michelle_blickyahoo.com', crypt('demo1234', gen_salt('bf', 10)), 'Michelle Blick', TRUE, DATE '1995-06-24')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Michelle Blick', 'woman', ARRAY['man']::text[], 'friends', DATE '1995-06-24',
    'Jayanagar', 'India', 12.883, 77.4882, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['💪 Gym & Fitness', '🍃 Nature', '👗 Fashion', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '72 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for user #120
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://avatars.githubusercontent.com/u/52905991', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-120-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-freeapi-120-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Michelle Blick
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'travel', 'If you could catch a flight to anywhere right now, where would you go?', NOW() - interval '2 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'If you could catch a flight to anywhere right now, where would you go?');

END $$;
