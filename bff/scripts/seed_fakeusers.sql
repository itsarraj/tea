-- ===========================================================================
-- Palora Seed: 200+ Fake Users from apps/palora/fakeusers
-- Generated on: 2026-09-26T12:44:44.294906+00:00
-- Total users: 209
-- Password for all accounts: demo1234
-- Idempotent: ON CONFLICT updates existing profiles
-- ===========================================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

DO $$
DECLARE
  u_id UUID;
BEGIN
  -- FakeUser #1: سارینا کوتی (yellowpeacock139@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('yellowpeacock139@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'سارینا کوتی', TRUE, DATE '2004-02-23')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'سارینا کوتی', 'woman', ARRAY['man']::text[], 'both', DATE '2004-02-23',
    'Jayanagar', 'India', 12.9021, 77.7043, 'Always in search of the best specialty coffee and quiet reading nooks.', ARRAY['👗 Fashion', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #1
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/38.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-1-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-1-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #2: Melissa Fleming (melissa.fleming@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('melissa.fleming@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Melissa Fleming', TRUE, DATE '1993-11-17')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Melissa Fleming', 'woman', ARRAY['man']::text[], 'partner', DATE '1993-11-17',
    'Winchester', 'India', 12.9367, 77.5995, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['🙂 People', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #2
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'http://localhost:8000/media/fakeusers/algolia/women/pragati.png', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-2-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-2-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #3: Christoffer Christiansen (christoffer.christiansen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('christoffer.christiansen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Christoffer Christiansen', TRUE, DATE '1993-09-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Christoffer Christiansen', 'man', ARRAY['woman']::text[], 'both', DATE '1993-09-28',
    'Overby Lyng', 'India', 13.013, 77.5198, 'Lover of old jazz records, thrift shops, and spontaneous road trips.', ARRAY['🎵 Music', '🗣 Language', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #3
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'http://localhost:8000/media/fakeusers/algolia/men/lucas.png', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-3-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-3-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #4: Valtteri Pulkkinen (valtteri.pulkkinen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('valtteri.pulkkinen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Valtteri Pulkkinen', TRUE, DATE '1993-04-22')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Valtteri Pulkkinen', 'man', ARRAY['woman']::text[], 'both', DATE '1993-04-22',
    'Parikkala', 'India', 13.0288, 77.5816, 'Tech startup dev. Passionate about open-source, bouldering, and board games.', ARRAY['✍🏻 Writing', '💪 Gym & Fitness', '🍃 Nature', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #4
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/49.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-4-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-4-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #5: Todd Beck (todd.beck@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('todd.beck@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Todd Beck', TRUE, DATE '1993-11-10')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Todd Beck', 'man', ARRAY['woman','man']::text[], 'both', DATE '1993-11-10',
    'Wakefield', 'India', 13.0629, 77.6192, 'Weekend road trips, film photography, and spicy street food.', ARRAY['🗣 Language', '💪 Gym & Fitness', '🏝 Travel', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #5
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/65.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-5-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-5-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #6: Kayla Hall (kayla.hall@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('kayla.hall@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Kayla Hall', TRUE, DATE '1993-04-08')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Kayla Hall', 'woman', ARRAY['man']::text[], 'partner', DATE '1993-04-08',
    'Whangarei', 'India', 12.9901, 77.4724, 'Lover of old jazz records, thrift shops, and spontaneous road trips.', ARRAY['🎵 Music', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #6
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/32.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-6-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-6-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Kayla Hall
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'philosophy', 'What is an underrated quality you cherish in friends and partners?', NOW() - interval '35 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What is an underrated quality you cherish in friends and partners?');

  -- FakeUser #7: Jimmie Simmons (jimmie.simmons@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jimmie.simmons@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Jimmie Simmons', TRUE, DATE '1993-12-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jimmie Simmons', 'man', ARRAY['woman']::text[], 'friends', DATE '1993-12-02',
    'Bangor', 'India', 13.0782, 77.5412, 'Software engineer, boba addict, and weekend hiker.', ARRAY['🗣 Language', '🍃 Nature', '👗 Fashion', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #7
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/25.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-7-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-7-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #8: Benedikt Hein (benedikt.hein@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('benedikt.hein@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Benedikt Hein', TRUE, DATE '1993-05-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Benedikt Hein', 'man', ARRAY['woman']::text[], 'both', DATE '1993-05-28',
    'HSR Layout', 'India', 12.9477, 77.6702, 'Here to meet interesting minds, share stories, and explore the city.', ARRAY['🎵 Music', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #8
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/56.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-8-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-8-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #9: Aloïs Moulin (silvergorilla196@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('silvergorilla196@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Aloïs Moulin', TRUE, DATE '1994-12-12')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Aloïs Moulin', 'man', ARRAY['woman','man']::text[], 'partner', DATE '1994-12-12',
    'Berolle', 'India', 13.1107, 77.5971, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['🎵 Music', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #9
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/28.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-9-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-9-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #10: Noah Smith (noah.smith@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('noah.smith@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Noah Smith', TRUE, DATE '1993-04-26')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Noah Smith', 'man', ARRAY['woman']::text[], 'both', DATE '1993-04-26',
    'Inverness', 'India', 13.0642, 77.6841, 'Here to meet interesting minds, share stories, and explore the city.', ARRAY['🗣 Language', '⚽️ Football', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #10
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/20.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-10-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-10-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #11: Noah Dupont (noah.dupont@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('noah.dupont@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Noah Dupont', TRUE, DATE '1997-03-08')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Noah Dupont', 'man', ARRAY['woman','man']::text[], 'both', DATE '1997-03-08',
    'Vucherens', 'India', 12.8915, 77.5624, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['👗 Fashion', '📸 Photography', '🎵 Music', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #11
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/52.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-11-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-11-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #12: Necati Nalbantoğlu (yellowduck640@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('yellowduck640@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Necati Nalbantoğlu', TRUE, DATE '2005-05-08')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Necati Nalbantoğlu', 'man', ARRAY['woman']::text[], 'both', DATE '2005-05-08',
    'Jayanagar', 'India', 13.0186, 77.4964, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['🙂 People', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #12
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/17.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-12-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-12-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Necati Nalbantoğlu
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'food', 'Late night street food or Sunday brunch? Drop your go-to order.', NOW() - interval '71 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Late night street food or Sunday brunch? Drop your go-to order.');

  -- FakeUser #13: Nerea Mendez (nerea.mendez@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('nerea.mendez@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Nerea Mendez', TRUE, DATE '1993-09-21')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Nerea Mendez', 'woman', ARRAY['man']::text[], 'friends', DATE '1993-09-21',
    'Guadalajara', 'India', 12.8946, 77.5014, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['🍃 Nature', '🙂 People', '🎵 Music', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #13
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/29.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-13-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-13-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #14: Arnold Gardner (arnold.gardner@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('arnold.gardner@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Arnold Gardner', TRUE, DATE '1993-06-23')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Arnold Gardner', 'man', ARRAY['woman']::text[], 'friends', DATE '1993-06-23',
    'Australian Capital Territory', 'India', 12.963, 77.6393, 'Software engineer, boba addict, and weekend hiker.', ARRAY['⚽️ Football', '💪 Gym & Fitness', '🏝 Travel', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #14
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/24.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-14-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-14-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #15: Julia Cano (julia.cano@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('julia.cano@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Julia Cano', TRUE, DATE '1993-05-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Julia Cano', 'woman', ARRAY['man']::text[], 'both', DATE '1993-05-02',
    'Bengaluru', 'India', 12.8745, 77.5772, 'Data scientist with a weak spot for dog memes and Sunday morning hikes.', ARRAY['🎵 Music', '🙂 People', '👗 Fashion', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #15
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/6.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-15-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-15-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #16: Annika Schulte (annika.schulte@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('annika.schulte@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Annika Schulte', TRUE, DATE '2005-05-19')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Annika Schulte', 'woman', ARRAY['man']::text[], 'both', DATE '2005-05-19',
    'Berchtesgadener Land', 'India', 13.0341, 77.4898, 'Software engineer, boba addict, and weekend hiker.', ARRAY['✍🏻 Writing', '👗 Fashion', '🏝 Travel', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #16
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/57.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-16-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-16-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #17: Justin Harcourt (justin.harcourt@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('justin.harcourt@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Justin Harcourt', TRUE, DATE '2005-04-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Justin Harcourt', 'man', ARRAY['woman','man']::text[], 'friends', DATE '2005-04-02',
    'Kingston', 'India', 12.9702, 77.4803, 'Product designer by day, indie concert hunter by night.', ARRAY['🏝 Travel', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #17
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/26.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-17-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-17-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #18: باران پارسا (purpleostrich818@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('purpleostrich818@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'باران پارسا', TRUE, DATE '1996-04-07')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'باران پارسا', 'woman', ARRAY['woman','man']::text[], 'friends', DATE '1996-04-07',
    'Indiranagar', 'India', 12.8337, 77.5522, 'Marathon training in progress. Will run for good pastries.', ARRAY['🗣 Language', '⚽️ Football', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #18
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/31.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-18-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-18-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by باران پارسا
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'philosophy', 'What is an underrated quality you cherish in friends and partners?', NOW() - interval '65 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What is an underrated quality you cherish in friends and partners?');

  -- FakeUser #19: Noah Bonnet (noah.bonnet@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('noah.bonnet@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Noah Bonnet', TRUE, DATE '1993-03-24')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Noah Bonnet', 'man', ARRAY['woman']::text[], 'both', DATE '1993-03-24',
    'Epesses', 'India', 12.97, 77.566, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['🙂 People', '🗣 Language', '📸 Photography', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #19
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/23.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-19-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-19-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #20: Eemil Neva (eemil.neva@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('eemil.neva@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Eemil Neva', TRUE, DATE '1993-12-21')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Eemil Neva', 'man', ARRAY['woman']::text[], 'partner', DATE '1993-12-21',
    'Juupajoki', 'India', 12.9561, 77.4585, 'Product designer by day, indie concert hunter by night.', ARRAY['✍🏻 Writing', '👗 Fashion', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #20
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/16.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-20-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-20-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #21: Léonard Arnaud (smallleopard952@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('smallleopard952@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Léonard Arnaud', TRUE, DATE '1993-07-19')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Léonard Arnaud', 'man', ARRAY['woman','man']::text[], 'partner', DATE '1993-07-19',
    'Reims', 'India', 12.8606, 77.6982, 'Casual gamer, dog enthusiast, and sunset chaser.', ARRAY['✍🏻 Writing', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #21
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/73.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-21-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-21-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #22: Leevi Wiitala (leevi.wiitala@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('leevi.wiitala@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Leevi Wiitala', TRUE, DATE '1993-05-27')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Leevi Wiitala', 'man', ARRAY['woman','man']::text[], 'both', DATE '1993-05-27',
    'Jayanagar', 'India', 13.0579, 77.5949, 'Product designer by day, indie concert hunter by night.', ARRAY['🏝 Travel', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #22
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/93.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-22-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-22-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #23: Alma Thomsen (alma.thomsen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('alma.thomsen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Alma Thomsen', TRUE, DATE '2005-03-12')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Alma Thomsen', 'woman', ARRAY['woman','man']::text[], 'friends', DATE '2005-03-12',
    'Juelsminde', 'India', 12.8322, 77.7185, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['🗣 Language', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #23
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/55.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-23-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-23-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #24: Mia Li (mia.li@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('mia.li@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Mia Li', TRUE, DATE '1993-04-16')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Mia Li', 'woman', ARRAY['woman','man']::text[], 'friends', DATE '1993-04-16',
    'Deer Lake', 'India', 12.9399, 77.6429, 'Marathon training in progress. Will run for good pastries.', ARRAY['🍃 Nature', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #24
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/28.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-24-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-24-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Mia Li
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'philosophy', 'What is an underrated quality you cherish in friends and partners?', NOW() - interval '8 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What is an underrated quality you cherish in friends and partners?');

  -- FakeUser #25: James Warren (james.warren@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('james.warren@example.com', crypt('demo1234', gen_salt('bf', 10)), 'James Warren', TRUE, DATE '1993-08-15')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'James Warren', 'man', ARRAY['woman']::text[], 'both', DATE '1993-08-15',
    'Dundee', 'India', 12.985, 77.5592, 'Obsessed with Japanese cuisine, sourdough experiments, and photography.', ARRAY['✍🏻 Writing', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #25
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/43.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-25-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-25-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #26: Signe Olsen (signe.olsen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('signe.olsen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Signe Olsen', TRUE, DATE '1993-09-11')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Signe Olsen', 'woman', ARRAY['man']::text[], 'friends', DATE '1993-09-11',
    'Sundby', 'India', 12.9411, 77.6106, 'Obsessed with Japanese cuisine, sourdough experiments, and photography.', ARRAY['🍃 Nature', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #26
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/88.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-26-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-26-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #27: Adam Porter (adam.porter@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('adam.porter@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Adam Porter', TRUE, DATE '2004-03-26')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Adam Porter', 'man', ARRAY['woman']::text[], 'friends', DATE '2004-03-26',
    'Australian Capital Territory', 'India', 13.0406, 77.5328, 'Badminton player, sourdough baker, and trivia night enthusiast.', ARRAY['🍃 Nature', '✍🏻 Writing', '💪 Gym & Fitness', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #27
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/86.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-27-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-27-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #28: Marcus Andersen (marcus.andersen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('marcus.andersen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Marcus Andersen', TRUE, DATE '1993-09-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Marcus Andersen', 'man', ARRAY['woman']::text[], 'both', DATE '1993-09-28',
    'Vesterborg', 'India', 12.9122, 77.4598, 'Med researcher who loves scuba diving, museums, and chai stalls.', ARRAY['🏝 Travel', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #28
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/33.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-28-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-28-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #29: Melissa Fritz (melissa.fritz@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('melissa.fritz@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Melissa Fritz', TRUE, DATE '2000-07-05')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Melissa Fritz', 'woman', ARRAY['woman','man']::text[], 'both', DATE '2000-07-05',
    'Schierbrok', 'India', 12.8801, 77.4793, 'Product designer by day, indie concert hunter by night.', ARRAY['🎵 Music', '🏝 Travel', '🗣 Language', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #29
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/89.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-29-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-29-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #30: Kasper Klessens (kasper.klessens@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('kasper.klessens@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Kasper Klessens', TRUE, DATE '2005-06-22')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Kasper Klessens', 'man', ARRAY['woman','man']::text[], 'both', DATE '2005-06-22',
    'Hendrik-Ido-Ambacht', 'India', 12.8582, 77.516, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['🗣 Language', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #30
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/2.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-30-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-30-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Kasper Klessens
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'sports', 'Anyone up for weekly badminton, tennis, or padel games in the city?', NOW() - interval '50 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Anyone up for weekly badminton, tennis, or padel games in the city?');

  -- FakeUser #31: Isaltino Rocha (isaltino.rocha@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('isaltino.rocha@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Isaltino Rocha', TRUE, DATE '1993-07-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Isaltino Rocha', 'man', ARRAY['woman']::text[], 'partner', DATE '1993-07-02',
    'Jayanagar', 'India', 13.0869, 77.6921, 'Software engineer, boba addict, and weekend hiker.', ARRAY['✍🏻 Writing', '📸 Photography', '🎵 Music', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #31
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/90.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-31-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-31-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #32: Abigail Hamilton (abigail.hamilton@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('abigail.hamilton@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Abigail Hamilton', TRUE, DATE '1997-08-05')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Abigail Hamilton', 'woman', ARRAY['man']::text[], 'partner', DATE '1997-08-05',
    'Swords', 'India', 13.0912, 77.4617, 'Casual gamer, dog enthusiast, and sunset chaser.', ARRAY['🏝 Travel', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #32
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/46.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-32-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-32-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #33: Mason Abraham (mason.abraham@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('mason.abraham@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Mason Abraham', TRUE, DATE '2001-03-19')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Mason Abraham', 'man', ARRAY['woman']::text[], 'both', DATE '2001-03-19',
    'Westport', 'India', 13.096, 77.5214, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['🏝 Travel', '🗣 Language', '🎵 Music', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #33
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'http://localhost:8000/media/fakeusers/algolia/men/honza.png', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-33-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-33-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #34: Esat Hamzaoğlu (heavygorilla341@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('heavygorilla341@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Esat Hamzaoğlu', TRUE, DATE '1993-11-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Esat Hamzaoğlu', 'man', ARRAY['woman']::text[], 'both', DATE '1993-11-28',
    'Manisa', 'India', 12.942, 77.6733, 'Data scientist with a weak spot for dog memes and Sunday morning hikes.', ARRAY['✍🏻 Writing', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #34
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/9.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-34-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-34-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #35: Rinesh Tielen (rinesh.tielen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('rinesh.tielen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Rinesh Tielen', TRUE, DATE '1993-02-07')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Rinesh Tielen', 'man', ARRAY['woman']::text[], 'both', DATE '1993-02-07',
    'Kerkrade', 'India', 12.8587, 77.615, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['🏝 Travel', '🙂 People', '🍃 Nature', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #35
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/89.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-35-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-35-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #36: Delphine Taylor (delphine.taylor@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('delphine.taylor@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Delphine Taylor', TRUE, DATE '2005-10-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Delphine Taylor', 'woman', ARRAY['man']::text[], 'friends', DATE '2005-10-28',
    'Chesterville', 'India', 12.9079, 77.5913, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['⚽️ Football', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #36
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/17.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-36-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-36-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Delphine Taylor
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'sports', 'Anyone up for weekly badminton, tennis, or padel games in the city?', NOW() - interval '44 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Anyone up for weekly badminton, tennis, or padel games in the city?');

  -- FakeUser #37: Jake Brown (jake.brown@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jake.brown@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Jake Brown', TRUE, DATE '1993-10-24')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jake Brown', 'man', ARRAY['woman','man']::text[], 'friends', DATE '1993-10-24',
    'Nelson', 'India', 12.9362, 77.6668, 'Weekend road trips, film photography, and spicy street food.', ARRAY['✍🏻 Writing', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #37
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/94.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-37-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-37-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #38: Guillermo Saez (guillermo.saez@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('guillermo.saez@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Guillermo Saez', TRUE, DATE '1993-12-13')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Guillermo Saez', 'man', ARRAY['woman']::text[], 'both', DATE '1993-12-13',
    'Whitefield', 'India', 13.0458, 77.5728, 'Marathon training in progress. Will run for good pastries.', ARRAY['📸 Photography', '🏝 Travel', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #38
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/19.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-38-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-38-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #39: Judith Schmitz (judith.schmitz@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('judith.schmitz@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Judith Schmitz', TRUE, DATE '2005-09-20')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Judith Schmitz', 'woman', ARRAY['man']::text[], 'both', DATE '2005-09-20',
    'Mittweida', 'India', 12.8762, 77.7083, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['🗣 Language', '🏝 Travel', '💪 Gym & Fitness', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #39
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/49.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-39-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-39-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #40: Tammy Bowman (tammy.bowman@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('tammy.bowman@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Tammy Bowman', TRUE, DATE '1996-05-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Tammy Bowman', 'woman', ARRAY['man']::text[], 'friends', DATE '1996-05-28',
    'Carrigaline', 'India', 12.8568, 77.5551, 'Software engineer, boba addict, and weekend hiker.', ARRAY['👗 Fashion', '📸 Photography', '🙂 People', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #40
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/74.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-40-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-40-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #41: Arnold Allen (arnold.allen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('arnold.allen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Arnold Allen', TRUE, DATE '2001-03-20')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Arnold Allen', 'man', ARRAY['woman']::text[], 'both', DATE '2001-03-20',
    'Lusk', 'India', 12.9688, 77.546, 'Obsessed with Japanese cuisine, sourdough experiments, and photography.', ARRAY['💪 Gym & Fitness', '🏝 Travel', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #41
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/3.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-41-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-41-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #42: پرنیا جعفری (heavyladybug712@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('heavyladybug712@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'پرنیا جعفری', TRUE, DATE '1993-02-05')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'پرنیا جعفری', 'woman', ARRAY['man']::text[], 'partner', DATE '1993-02-05',
    'Koramangala', 'India', 13.0805, 77.6377, 'Data scientist with a weak spot for dog memes and Sunday morning hikes.', ARRAY['⚽️ Football', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #42
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/13.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-42-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-42-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by پرنیا جعفری
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'travel', 'What is one city or country you would move to tomorrow with zero hesitation?', NOW() - interval '70 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What is one city or country you would move to tomorrow with zero hesitation?');

  -- FakeUser #43: Gilbert Willis (gilbert.willis@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('gilbert.willis@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Gilbert Willis', TRUE, DATE '1993-07-07')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Gilbert Willis', 'man', ARRAY['woman','man']::text[], 'both', DATE '1993-07-07',
    'Savannah', 'India', 12.8475, 77.7127, 'Badminton player, sourdough baker, and trivia night enthusiast.', ARRAY['🏝 Travel', '🎵 Music', '✍🏻 Writing', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #43
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/27.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-43-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-43-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #44: Selma Andersen (selma.andersen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('selma.andersen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Selma Andersen', TRUE, DATE '1993-01-14')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Selma Andersen', 'woman', ARRAY['man']::text[], 'both', DATE '1993-01-14',
    'Nimtofte', 'India', 13.1078, 77.7047, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['🏝 Travel', '🍃 Nature', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #44
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/18.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-44-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-44-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #45: Lara Metzger (lara.metzger@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('lara.metzger@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Lara Metzger', TRUE, DATE '1993-03-15')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Lara Metzger', 'woman', ARRAY['man']::text[], 'partner', DATE '1993-03-15',
    'Hannover', 'India', 13.046, 77.5727, 'Product designer by day, indie concert hunter by night.', ARRAY['🎵 Music', '🗣 Language', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #45
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/24.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-45-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-45-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #46: Andrea Hernandez (andrea.hernandez@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('andrea.hernandez@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Andrea Hernandez', TRUE, DATE '2005-07-25')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Andrea Hernandez', 'woman', ARRAY['man']::text[], 'both', DATE '2005-07-25',
    'Zaragoza', 'India', 12.8537, 77.4559, 'Software engineer, boba addict, and weekend hiker.', ARRAY['🎵 Music', '🍃 Nature', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #46
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/56.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-46-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-46-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #47: Johanne Christiansen (johanne.christiansen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('johanne.christiansen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Johanne Christiansen', TRUE, DATE '1993-10-14')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Johanne Christiansen', 'woman', ARRAY['man']::text[], 'both', DATE '1993-10-14',
    'Koramangala', 'India', 13.0018, 77.4945, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['👗 Fashion', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #47
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/48.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-47-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-47-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #48: Alfred Nielsen (alfred.nielsen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('alfred.nielsen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Alfred Nielsen', TRUE, DATE '1993-10-20')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Alfred Nielsen', 'man', ARRAY['woman']::text[], 'both', DATE '1993-10-20',
    'Saltum', 'India', 12.9511, 77.6725, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['🙂 People', '🏝 Travel', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #48
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/47.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-48-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-48-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Alfred Nielsen
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'travel', 'What is one city or country you would move to tomorrow with zero hesitation?', NOW() - interval '71 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What is one city or country you would move to tomorrow with zero hesitation?');

  -- FakeUser #49: Dawn Neal (dawn.neal@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('dawn.neal@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Dawn Neal', TRUE, DATE '2005-04-16')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Dawn Neal', 'woman', ARRAY['man']::text[], 'both', DATE '2005-04-16',
    'Berkeley', 'India', 12.9054, 77.6897, 'Data scientist with a weak spot for dog memes and Sunday morning hikes.', ARRAY['🙂 People', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #49
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/62.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-49-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-49-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #50: Charlie Palmer (charlie.palmer@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('charlie.palmer@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Charlie Palmer', TRUE, DATE '1997-01-17')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Charlie Palmer', 'man', ARRAY['woman']::text[], 'both', DATE '1997-01-17',
    'Portmarnock', 'India', 12.9673, 77.573, 'Weekend road trips, film photography, and spicy street food.', ARRAY['🎵 Music', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #50
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/97.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-50-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-50-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #51: Romain Noel (romain.noel@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('romain.noel@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Romain Noel', TRUE, DATE '1994-01-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Romain Noel', 'man', ARRAY['woman']::text[], 'both', DATE '1994-01-28',
    'Servion', 'India', 13.0932, 77.7289, 'Weekend road trips, film photography, and spicy street food.', ARRAY['🗣 Language', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #51
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/98.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-51-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-51-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #52: Lino Lucas (lino.lucas@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('lino.lucas@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Lino Lucas', TRUE, DATE '1993-02-11')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Lino Lucas', 'man', ARRAY['woman']::text[], 'both', DATE '1993-02-11',
    'Nantes', 'India', 12.8375, 77.6706, 'Software engineer, boba addict, and weekend hiker.', ARRAY['✍🏻 Writing', '📸 Photography', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #52
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/29.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-52-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-52-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #53: Clinton Bennett (clinton.bennett@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('clinton.bennett@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Clinton Bennett', TRUE, DATE '2000-03-07')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Clinton Bennett', 'man', ARRAY['woman']::text[], 'both', DATE '2000-03-07',
    'Launceston', 'India', 13.107, 77.6727, 'Product designer by day, indie concert hunter by night.', ARRAY['🗣 Language', '🎵 Music', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #53
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/85.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-53-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-53-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #54: Sandra Lucas (sandra.lucas@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('sandra.lucas@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Sandra Lucas', TRUE, DATE '2005-08-05')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Sandra Lucas', 'woman', ARRAY['man']::text[], 'both', DATE '2005-08-05',
    'Cugy Vd', 'India', 13.0966, 77.5038, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['💪 Gym & Fitness', '🎵 Music', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #54
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/78.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-54-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-54-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Sandra Lucas
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'philosophy', 'What is an underrated quality you cherish in friends and partners?', NOW() - interval '21 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What is an underrated quality you cherish in friends and partners?');

  -- FakeUser #55: Valtteri Mikkola (valtteri.mikkola@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('valtteri.mikkola@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Valtteri Mikkola', TRUE, DATE '1998-10-22')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Valtteri Mikkola', 'man', ARRAY['woman','man']::text[], 'both', DATE '1998-10-22',
    'Asikkala', 'India', 12.9187, 77.6333, 'Product designer by day, indie concert hunter by night.', ARRAY['🏝 Travel', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #55
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/88.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-55-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-55-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #56: Özkan Tekelioğlu (organiccat298@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('organiccat298@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Özkan Tekelioğlu', TRUE, DATE '1993-07-12')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Özkan Tekelioğlu', 'man', ARRAY['woman']::text[], 'friends', DATE '1993-07-12',
    'Afyonkarahisar', 'India', 13.1064, 77.6076, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['🍃 Nature', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #56
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/69.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-56-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-56-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #57: Soren Guillaume (soren.guillaume@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('soren.guillaume@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Soren Guillaume', TRUE, DATE '1993-12-04')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Soren Guillaume', 'man', ARRAY['woman']::text[], 'friends', DATE '1993-12-04',
    'Nice', 'India', 12.8538, 77.4855, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['🎵 Music', '⚽️ Football', '💪 Gym & Fitness', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #57
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/55.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-57-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-57-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #58: Çetin Oraloğlu (crazysnake370@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('crazysnake370@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Çetin Oraloğlu', TRUE, DATE '1993-07-14')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Çetin Oraloğlu', 'man', ARRAY['woman','man']::text[], 'friends', DATE '1993-07-14',
    'Bengaluru', 'India', 12.8525, 77.5298, 'Architect obsessed with brutalist buildings, house plants, and jazz vinyl.', ARRAY['🏝 Travel', '⚽️ Football', '📸 Photography', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #58
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/36.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-58-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-58-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #59: Serena Moraes (serena.moraes@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('serena.moraes@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Serena Moraes', TRUE, DATE '2005-11-07')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Serena Moraes', 'woman', ARRAY['man']::text[], 'both', DATE '2005-11-07',
    'Volta Redonda', 'India', 12.9693, 77.5991, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['🗣 Language', '📸 Photography', '✍🏻 Writing', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #59
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/72.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-59-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-59-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #60: Enora Aubert (enora.aubert@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('enora.aubert@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Enora Aubert', TRUE, DATE '1998-07-14')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Enora Aubert', 'woman', ARRAY['man']::text[], 'friends', DATE '1998-07-14',
    'Syens', 'India', 13.0, 77.691, 'Casual gamer, dog enthusiast, and sunset chaser.', ARRAY['✍🏻 Writing', '🏝 Travel', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #60
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/2.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-60-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-60-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Enora Aubert
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'fitness', 'Any morning runners or bouldering fans looking for a weekend buddy?', NOW() - interval '50 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Any morning runners or bouldering fans looking for a weekend buddy?');

  -- FakeUser #61: Siiri Ojala (siiri.ojala@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('siiri.ojala@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Siiri Ojala', TRUE, DATE '1998-12-05')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Siiri Ojala', 'woman', ARRAY['man']::text[], 'friends', DATE '1998-12-05',
    'Pihtipudas', 'India', 12.9683, 77.5823, 'Always in search of the best specialty coffee and quiet reading nooks.', ARRAY['⚽️ Football', '👗 Fashion', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #61
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/85.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-61-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-61-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #62: Benjamin Patel (benjamin.patel@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('benjamin.patel@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Benjamin Patel', TRUE, DATE '1999-06-19')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Benjamin Patel', 'man', ARRAY['woman','man']::text[], 'both', DATE '1999-06-19',
    'Masterton', 'India', 13.085, 77.5144, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['🗣 Language', '🏝 Travel', '👗 Fashion', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #62
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/40.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-62-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-62-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #63: Pearl Wilson (pearl.wilson@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('pearl.wilson@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Pearl Wilson', TRUE, DATE '1993-08-16')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Pearl Wilson', 'woman', ARRAY['woman','man']::text[], 'both', DATE '1993-08-16',
    'Moreno Valley', 'India', 12.8815, 77.6149, 'Lover of old jazz records, thrift shops, and spontaneous road trips.', ARRAY['⚽️ Football', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #63
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/0.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-63-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-63-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #64: Sara Johansen (sara.johansen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('sara.johansen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Sara Johansen', TRUE, DATE '2005-07-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Sara Johansen', 'woman', ARRAY['woman','man']::text[], 'partner', DATE '2005-07-02',
    'Noerre Alslev', 'India', 12.9422, 77.6084, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['🗣 Language', '🙂 People', '🏝 Travel', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #64
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/39.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-64-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-64-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #65: Roberto Delgado (roberto.delgado@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('roberto.delgado@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Roberto Delgado', TRUE, DATE '2005-04-08')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Roberto Delgado', 'man', ARRAY['woman']::text[], 'both', DATE '2005-04-08',
    'Jayanagar', 'India', 12.9458, 77.5337, 'Weekend road trips, film photography, and spicy street food.', ARRAY['🏝 Travel', '⚽️ Football', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #65
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/10.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-65-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-65-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #66: Harold Simpson (harold.simpson@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('harold.simpson@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Harold Simpson', TRUE, DATE '1993-05-12')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Harold Simpson', 'man', ARRAY['woman']::text[], 'both', DATE '1993-05-12',
    'Wells', 'India', 12.9541, 77.6103, 'Here to meet interesting minds, share stories, and explore the city.', ARRAY['📸 Photography', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #66
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/39.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-66-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-66-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Harold Simpson
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'food', 'Late night street food or Sunday brunch? Drop your go-to order.', NOW() - interval '44 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Late night street food or Sunday brunch? Drop your go-to order.');

  -- FakeUser #67: Gregory Fleming (gregory.fleming@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('gregory.fleming@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Gregory Fleming', TRUE, DATE '1993-10-08')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Gregory Fleming', 'man', ARRAY['woman','man']::text[], 'both', DATE '1993-10-08',
    'Orange', 'India', 13.1002, 77.6161, 'Med researcher who loves scuba diving, museums, and chai stalls.', ARRAY['📸 Photography', '💪 Gym & Fitness', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #67
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/79.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-67-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-67-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #68: Laurie Bouchard (laurie.bouchard@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('laurie.bouchard@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Laurie Bouchard', TRUE, DATE '1993-01-03')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Laurie Bouchard', 'woman', ARRAY['man']::text[], 'both', DATE '1993-01-03',
    'Elgin', 'India', 12.8801, 77.7029, 'Obsessed with Japanese cuisine, sourdough experiments, and photography.', ARRAY['🙂 People', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #68
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/93.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-68-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-68-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #69: Dora Barnes (dora.barnes@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('dora.barnes@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Dora Barnes', TRUE, DATE '1998-04-07')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Dora Barnes', 'woman', ARRAY['woman','man']::text[], 'friends', DATE '1998-04-07',
    'Devonport', 'India', 12.9011, 77.5535, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['🙂 People', '🎵 Music', '💪 Gym & Fitness', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #69
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/40.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-69-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-69-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #70: Phillip Torres (phillip.torres@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('phillip.torres@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Phillip Torres', TRUE, DATE '1993-09-18')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Phillip Torres', 'man', ARRAY['woman']::text[], 'both', DATE '1993-09-18',
    'Toledo', 'India', 12.9809, 77.5528, 'Product designer by day, indie concert hunter by night.', ARRAY['👗 Fashion', '💪 Gym & Fitness', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #70
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/64.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-70-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-70-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #71: Rosemary Robinson (rosemary.robinson@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('rosemary.robinson@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Rosemary Robinson', TRUE, DATE '1998-04-16')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Rosemary Robinson', 'woman', ARRAY['man']::text[], 'partner', DATE '1998-04-16',
    'Eugene', 'India', 12.8915, 77.6542, 'Lover of old jazz records, thrift shops, and spontaneous road trips.', ARRAY['✍🏻 Writing', '⚽️ Football', '🍃 Nature', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #71
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'http://localhost:8000/media/fakeusers/algolia/women/fanette.png', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-71-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-71-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #72: Anton Christensen (anton.christensen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('anton.christensen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Anton Christensen', TRUE, DATE '1993-06-01')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Anton Christensen', 'man', ARRAY['woman']::text[], 'both', DATE '1993-06-01',
    'Fredeikssund', 'India', 12.8429, 77.5694, 'Lover of old jazz records, thrift shops, and spontaneous road trips.', ARRAY['🙂 People', '📸 Photography', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #72
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/81.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-72-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-72-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Anton Christensen
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'fitness', 'Any morning runners or bouldering fans looking for a weekend buddy?', NOW() - interval '21 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Any morning runners or bouldering fans looking for a weekend buddy?');

  -- FakeUser #73: Emily Wright (emily.wright@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('emily.wright@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Emily Wright', TRUE, DATE '2005-04-05')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Emily Wright', 'woman', ARRAY['man']::text[], 'friends', DATE '2005-04-05',
    'Palmerston North', 'India', 13.0218, 77.5395, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['⚽️ Football', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #73
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/3.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-73-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-73-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #74: Alisa Niva (alisa.niva@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('alisa.niva@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Alisa Niva', TRUE, DATE '2005-01-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Alisa Niva', 'woman', ARRAY['man']::text[], 'friends', DATE '2005-01-02',
    'HSR Layout', 'India', 13.0804, 77.5899, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['🏝 Travel', '📸 Photography', '🎵 Music', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #74
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/95.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-74-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-74-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #75: Naja Larsen (naja.larsen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('naja.larsen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Naja Larsen', TRUE, DATE '1993-09-19')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Naja Larsen', 'woman', ARRAY['man']::text[], 'partner', DATE '1993-09-19',
    'Stokkemarke', 'India', 13.0226, 77.4885, 'Badminton player, sourdough baker, and trivia night enthusiast.', ARRAY['📸 Photography', '🎵 Music', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #75
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/44.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-75-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-75-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #76: Alysha Van De Westelaken (brownelephant697@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('brownelephant697@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Alysha Van De Westelaken', TRUE, DATE '2004-06-21')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Alysha Van De Westelaken', 'woman', ARRAY['man']::text[], 'both', DATE '2004-06-21',
    'Zoetermeer', 'India', 12.916, 77.4915, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['⚽️ Football', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #76
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/94.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-76-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-76-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #77: Ahmet Akyüz (blackladybug343@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('blackladybug343@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Ahmet Akyüz', TRUE, DATE '1993-02-14')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Ahmet Akyüz', 'man', ARRAY['woman']::text[], 'partner', DATE '1993-02-14',
    'Malatya', 'India', 12.8672, 77.4744, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['🙂 People', '💪 Gym & Fitness', '🗣 Language', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #77
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/12.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-77-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-77-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #78: Alexis Faure (alexis.faure@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('alexis.faure@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Alexis Faure', TRUE, DATE '2005-07-27')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Alexis Faure', 'man', ARRAY['woman','man']::text[], 'friends', DATE '2005-07-27',
    'Nancy', 'India', 12.8871, 77.6426, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['🙂 People', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #78
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/22.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-78-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-78-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Alexis Faure
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'travel', 'Window seat or aisle seat? And what is your best travel story?', NOW() - interval '69 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Window seat or aisle seat? And what is your best travel story?');

  -- FakeUser #79: Nanna Pedersen (nanna.pedersen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('nanna.pedersen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Nanna Pedersen', TRUE, DATE '1993-09-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Nanna Pedersen', 'woman', ARRAY['man']::text[], 'friends', DATE '1993-09-28',
    'Aarhus', 'India', 13.0395, 77.5237, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['📸 Photography', '👗 Fashion', '🎵 Music', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #79
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/68.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-79-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-79-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #80: Charlotte Lee (charlotte.lee@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('charlotte.lee@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Charlotte Lee', TRUE, DATE '2004-01-24')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Charlotte Lee', 'woman', ARRAY['man']::text[], 'friends', DATE '2004-01-24',
    'Gisborne', 'India', 12.8434, 77.5905, 'Software engineer, boba addict, and weekend hiker.', ARRAY['✍🏻 Writing', '🍃 Nature', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #80
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/92.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-80-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-80-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #81: Alexandra Henry (alexandra.henry@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('alexandra.henry@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Alexandra Henry', TRUE, DATE '1993-08-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Alexandra Henry', 'woman', ARRAY['man']::text[], 'friends', DATE '1993-08-02',
    'Nenagh', 'India', 12.9451, 77.671, 'Here to meet interesting minds, share stories, and explore the city.', ARRAY['💪 Gym & Fitness', '✍🏻 Writing', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #81
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/79.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-81-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-81-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #82: Jeremiah Graham (jeremiah.graham@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jeremiah.graham@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Jeremiah Graham', TRUE, DATE '1993-04-01')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jeremiah Graham', 'man', ARRAY['woman']::text[], 'both', DATE '1993-04-01',
    'San Antonio', 'India', 12.9218, 77.563, 'Badminton player, sourdough baker, and trivia night enthusiast.', ARRAY['🍃 Nature', '🙂 People', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #82
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'http://localhost:8000/media/fakeusers/algolia/men/olivier.png', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-82-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-82-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #83: Oscar Christiansen (oscar.christiansen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('oscar.christiansen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Oscar Christiansen', TRUE, DATE '2005-04-23')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Oscar Christiansen', 'man', ARRAY['woman']::text[], 'partner', DATE '2005-04-23',
    'Whitefield', 'India', 12.929, 77.73, 'Obsessed with Japanese cuisine, sourdough experiments, and photography.', ARRAY['💪 Gym & Fitness', '🙂 People', '🏝 Travel', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #83
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/95.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-83-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-83-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #84: Nella Kangas (nella.kangas@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('nella.kangas@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Nella Kangas', TRUE, DATE '1993-04-19')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Nella Kangas', 'woman', ARRAY['man']::text[], 'partner', DATE '1993-04-19',
    'Kiuruvesi', 'India', 13.0304, 77.5319, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['🗣 Language', '🍃 Nature', '🙂 People', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #84
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/50.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-84-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-84-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Nella Kangas
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'creative', 'What piece of art, cinema, or literature completely blew your mind?', NOW() - interval '57 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What piece of art, cinema, or literature completely blew your mind?');

  -- FakeUser #85: Melinda Hughes (melinda.hughes@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('melinda.hughes@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Melinda Hughes', TRUE, DATE '1993-01-18')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Melinda Hughes', 'woman', ARRAY['woman','man']::text[], 'both', DATE '1993-01-18',
    'Warrnambool', 'India', 12.9881, 77.7247, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['✍🏻 Writing', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #85
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/60.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-85-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-85-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #86: Väinö Huotari (orangemouse353@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('orangemouse353@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Väinö Huotari', TRUE, DATE '1993-12-01')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Väinö Huotari', 'man', ARRAY['woman']::text[], 'both', DATE '1993-12-01',
    'Lapinlahti', 'India', 12.929, 77.4925, 'Data scientist with a weak spot for dog memes and Sunday morning hikes.', ARRAY['🎵 Music', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #86
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'http://localhost:8000/media/fakeusers/algolia/men/raymond.png', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-86-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-86-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #87: Eduardo Van De Woestijne (whiteelephant609@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('whiteelephant609@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Eduardo Van De Woestijne', TRUE, DATE '1993-09-24')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Eduardo Van De Woestijne', 'man', ARRAY['woman','man']::text[], 'friends', DATE '1993-09-24',
    'Baarle-Nassau', 'India', 12.9211, 77.6116, 'Product designer by day, indie concert hunter by night.', ARRAY['⚽️ Football', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #87
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/7.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-87-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-87-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #88: Mustafa Hamzaoğlu (whitegoose675@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('whitegoose675@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Mustafa Hamzaoğlu', TRUE, DATE '1993-07-25')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Mustafa Hamzaoğlu', 'man', ARRAY['woman','man']::text[], 'both', DATE '1993-07-25',
    'Bengaluru', 'India', 12.9774, 77.6305, 'Med researcher who loves scuba diving, museums, and chai stalls.', ARRAY['🍃 Nature', '🎵 Music', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #88
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/54.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-88-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-88-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #89: Enzo Sanchez (enzo.sanchez@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('enzo.sanchez@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Enzo Sanchez', TRUE, DATE '1993-09-22')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Enzo Sanchez', 'man', ARRAY['woman']::text[], 'partner', DATE '1993-09-22',
    'Bengaluru', 'India', 13.0998, 77.5864, 'Here to meet interesting minds, share stories, and explore the city.', ARRAY['🙂 People', '💪 Gym & Fitness', '🗣 Language', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #89
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/44.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-89-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-89-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #90: Leo Honkala (leo.honkala@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('leo.honkala@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Leo Honkala', TRUE, DATE '1993-10-08')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Leo Honkala', 'man', ARRAY['woman']::text[], 'partner', DATE '1993-10-08',
    'Jayanagar', 'India', 13.0911, 77.4935, 'Med researcher who loves scuba diving, museums, and chai stalls.', ARRAY['🏝 Travel', '⚽️ Football', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #90
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/0.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-90-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-90-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Leo Honkala
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'music', 'What song or artist has defined your last 6 months?', NOW() - interval '61 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What song or artist has defined your last 6 months?');

  -- FakeUser #91: Dylan Soto (dylan.soto@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('dylan.soto@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Dylan Soto', TRUE, DATE '2005-12-25')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Dylan Soto', 'man', ARRAY['woman']::text[], 'friends', DATE '2005-12-25',
    'Maitland', 'India', 13.0907, 77.4782, 'Product designer by day, indie concert hunter by night.', ARRAY['🗣 Language', '💪 Gym & Fitness', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #91
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/60.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-91-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-91-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #92: Joan Vega (joan.vega@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('joan.vega@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Joan Vega', TRUE, DATE '2003-06-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Joan Vega', 'man', ARRAY['woman']::text[], 'both', DATE '2003-06-28',
    'Koramangala', 'India', 13.0375, 77.5705, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['📸 Photography', '🍃 Nature', '🗣 Language', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #92
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/74.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-92-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-92-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #93: Wyatt Rhodes (wyatt.rhodes@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('wyatt.rhodes@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Wyatt Rhodes', TRUE, DATE '2005-04-14')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Wyatt Rhodes', 'man', ARRAY['woman']::text[], 'both', DATE '2005-04-14',
    'Birmingham', 'India', 12.9618, 77.5633, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['📸 Photography', '🎵 Music', '💪 Gym & Fitness', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #93
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/67.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-93-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-93-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #94: Angela Newman (angela.newman@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('angela.newman@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Angela Newman', TRUE, DATE '1993-03-16')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Angela Newman', 'woman', ARRAY['woman','man']::text[], 'both', DATE '1993-03-16',
    'Celbridge', 'India', 12.9824, 77.7156, 'Med researcher who loves scuba diving, museums, and chai stalls.', ARRAY['🏝 Travel', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #94
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/82.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-94-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-94-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #95: Alani Gonçalves (beautifulladybug889@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('beautifulladybug889@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Alani Gonçalves', TRUE, DATE '1993-06-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Alani Gonçalves', 'woman', ARRAY['man']::text[], 'both', DATE '1993-06-28',
    'Juazeiro', 'India', 12.8862, 77.5712, 'Software engineer, boba addict, and weekend hiker.', ARRAY['✍🏻 Writing', '🗣 Language', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #95
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/35.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-95-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-95-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #96: Rachel Lambert (rachel.lambert@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('rachel.lambert@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Rachel Lambert', TRUE, DATE '1993-05-26')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Rachel Lambert', 'woman', ARRAY['woman','man']::text[], 'friends', DATE '1993-05-26',
    'Bussy-Chardonney', 'India', 12.948, 77.5051, 'Weekend road trips, film photography, and spicy street food.', ARRAY['👗 Fashion', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #96
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/64.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-96-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-96-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Rachel Lambert
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'music', 'What song or artist has defined your last 6 months?', NOW() - interval '56 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What song or artist has defined your last 6 months?');

  -- FakeUser #97: Florence Newman (florence.newman@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('florence.newman@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Florence Newman', TRUE, DATE '1996-02-04')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Florence Newman', 'woman', ARRAY['man']::text[], 'friends', DATE '1996-02-04',
    'Tuam', 'India', 13.0107, 77.5272, 'Med researcher who loves scuba diving, museums, and chai stalls.', ARRAY['🍃 Nature', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #97
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/1.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-97-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-97-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #98: Sharon Jimenez (sharon.jimenez@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('sharon.jimenez@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Sharon Jimenez', TRUE, DATE '1999-10-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Sharon Jimenez', 'woman', ARRAY['man']::text[], 'both', DATE '1999-10-28',
    'Peterborough', 'India', 12.9683, 77.6632, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['🎵 Music', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #98
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/61.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-98-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-98-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #99: Becky Holmes (becky.holmes@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('becky.holmes@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Becky Holmes', TRUE, DATE '1993-11-15')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Becky Holmes', 'woman', ARRAY['man']::text[], 'both', DATE '1993-11-15',
    'Newbridge', 'India', 12.9164, 77.6814, 'Marathon training in progress. Will run for good pastries.', ARRAY['✍🏻 Writing', '👗 Fashion', '🍃 Nature', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #99
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/19.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-99-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-99-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #100: Leo Pierce (leo.pierce@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('leo.pierce@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Leo Pierce', TRUE, DATE '2001-08-16')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Leo Pierce', 'man', ARRAY['woman']::text[], 'both', DATE '2001-08-16',
    'Southampton', 'India', 12.9553, 77.5526, 'Software engineer, boba addict, and weekend hiker.', ARRAY['🗣 Language', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #100
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/8.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-100-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-100-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #101: اميرمحمد جعفری (lazyostrich947@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('lazyostrich947@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'اميرمحمد جعفری', TRUE, DATE '1993-01-20')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'اميرمحمد جعفری', 'man', ARRAY['woman','man']::text[], 'partner', DATE '1993-01-20',
    'Koramangala', 'India', 12.8405, 77.6926, 'Casual gamer, dog enthusiast, and sunset chaser.', ARRAY['🏝 Travel', '✍🏻 Writing', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #101
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'http://localhost:8000/media/fakeusers/algolia/men/jeremy.png', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-101-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-101-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #102: Julie Cole (julie.cole@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('julie.cole@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Julie Cole', TRUE, DATE '1993-04-06')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Julie Cole', 'woman', ARRAY['man']::text[], 'partner', DATE '1993-04-06',
    'Stoke-On-Trent', 'India', 13.027, 77.4725, 'Lover of old jazz records, thrift shops, and spontaneous road trips.', ARRAY['📸 Photography', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #102
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/42.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-102-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-102-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Julie Cole
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'travel', 'Window seat or aisle seat? And what is your best travel story?', NOW() - interval '15 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Window seat or aisle seat? And what is your best travel story?');

  -- FakeUser #103: Sammy Gregory (sammy.gregory@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('sammy.gregory@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Sammy Gregory', TRUE, DATE '1993-08-20')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Sammy Gregory', 'man', ARRAY['woman','man']::text[], 'both', DATE '1993-08-20',
    'Castlebar', 'India', 12.8658, 77.6846, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['👗 Fashion', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #103
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/48.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-103-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-103-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #104: Lucas Harris (lucas.harris@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('lucas.harris@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Lucas Harris', TRUE, DATE '2005-12-05')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Lucas Harris', 'man', ARRAY['woman']::text[], 'partner', DATE '2005-12-05',
    'Winfield', 'India', 13.038, 77.5956, 'Lover of old jazz records, thrift shops, and spontaneous road trips.', ARRAY['📸 Photography', '🍃 Nature', '🗣 Language', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #104
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/78.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-104-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-104-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #105: Leo Abraham (leo.abraham@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('leo.abraham@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Leo Abraham', TRUE, DATE '1998-02-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Leo Abraham', 'man', ARRAY['woman','man']::text[], 'friends', DATE '1998-02-28',
    'Chatham', 'India', 13.0108, 77.7012, 'Learning guitar and cooking regional curries from scratch.', ARRAY['📸 Photography', '🏝 Travel', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #105
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/92.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-105-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-105-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #106: Stephanie Lawson (stephanie.lawson@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('stephanie.lawson@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Stephanie Lawson', TRUE, DATE '1997-04-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Stephanie Lawson', 'woman', ARRAY['man']::text[], 'both', DATE '1997-04-02',
    'Tullow', 'India', 12.9254, 77.4562, 'Software engineer, boba addict, and weekend hiker.', ARRAY['🎵 Music', '🙂 People', '✍🏻 Writing', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #106
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/20.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-106-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-106-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #107: Jeffrey Myers (jeffrey.myers@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jeffrey.myers@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Jeffrey Myers', TRUE, DATE '1993-01-01')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jeffrey Myers', 'man', ARRAY['woman']::text[], 'friends', DATE '1993-01-01',
    'Tulsa', 'India', 12.8858, 77.5101, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['🍃 Nature', '👗 Fashion', '🙂 People', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #107
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/83.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-107-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-107-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #108: Morgan Riviere (morgan.riviere@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('morgan.riviere@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Morgan Riviere', TRUE, DATE '1993-07-23')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Morgan Riviere', 'man', ARRAY['woman']::text[], 'both', DATE '1993-07-23',
    'Amiens', 'India', 12.8408, 77.4889, 'Here to meet interesting minds, share stories, and explore the city.', ARRAY['🏝 Travel', '✍🏻 Writing', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #108
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/72.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-108-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-108-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Morgan Riviere
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'nature', 'Sunrise hike or sunset by the ocean?', NOW() - interval '19 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Sunrise hike or sunset by the ocean?');

  -- FakeUser #109: آنیتا كامياران (blueduck902@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('blueduck902@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'آنیتا كامياران', TRUE, DATE '1993-05-10')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'آنیتا كامياران', 'woman', ARRAY['man']::text[], 'partner', DATE '1993-05-10',
    'Indiranagar', 'India', 12.9093, 77.6017, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['💪 Gym & Fitness', '🏝 Travel', '🙂 People', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #109
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/67.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-109-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-109-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #110: Rita Rezende (rita.rezende@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('rita.rezende@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Rita Rezende', TRUE, DATE '1993-12-11')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Rita Rezende', 'woman', ARRAY['man']::text[], 'both', DATE '1993-12-11',
    'Imperatriz', 'India', 12.9407, 77.5306, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['✍🏻 Writing', '⚽️ Football', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #110
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/45.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-110-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-110-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #111: Volkan Tazegül (beautifuldog103@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('beautifuldog103@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Volkan Tazegül', TRUE, DATE '1995-02-18')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Volkan Tazegül', 'man', ARRAY['woman','man']::text[], 'friends', DATE '1995-02-18',
    'Jayanagar', 'India', 12.85, 77.693, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['🍃 Nature', '📸 Photography', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #111
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/96.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-111-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-111-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #112: Ane Van Kessel (ane.vankessel@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('ane.vankessel@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Ane Van Kessel', TRUE, DATE '2002-08-06')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Ane Van Kessel', 'man', ARRAY['woman']::text[], 'both', DATE '2002-08-06',
    'Uden', 'India', 13.1024, 77.7332, 'Product designer by day, indie concert hunter by night.', ARRAY['🎵 Music', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #112
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/84.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-112-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-112-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #113: Nívia Cardoso (organicleopard979@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('organicleopard979@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Nívia Cardoso', TRUE, DATE '1993-03-17')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Nívia Cardoso', 'woman', ARRAY['man']::text[], 'friends', DATE '1993-03-17',
    'Bengaluru', 'India', 12.9324, 77.5035, 'Always in search of the best specialty coffee and quiet reading nooks.', ARRAY['🗣 Language', '💪 Gym & Fitness', '🏝 Travel', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #113
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/54.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-113-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-113-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #114: Aurélien Leroy (greencat660@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('greencat660@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Aurélien Leroy', TRUE, DATE '1993-04-23')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Aurélien Leroy', 'man', ARRAY['woman']::text[], 'partner', DATE '1993-04-23',
    'Bengaluru', 'India', 12.848, 77.6486, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['🏝 Travel', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #114
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/35.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-114-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-114-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Aurélien Leroy
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'food', 'Late night street food or Sunday brunch? Drop your go-to order.', NOW() - interval '37 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Late night street food or Sunday brunch? Drop your go-to order.');

  -- FakeUser #115: Arlo Jackson (arlo.jackson@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('arlo.jackson@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Arlo Jackson', TRUE, DATE '1993-04-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Arlo Jackson', 'man', ARRAY['woman','man']::text[], 'both', DATE '1993-04-28',
    'Timaru', 'India', 13.0302, 77.6202, 'Lover of old jazz records, thrift shops, and spontaneous road trips.', ARRAY['🏝 Travel', '🎵 Music', '💪 Gym & Fitness', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #115
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/75.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-115-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-115-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #116: Emine Barentsen (emine.barentsen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('emine.barentsen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Emine Barentsen', TRUE, DATE '2005-03-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Emine Barentsen', 'woman', ARRAY['man']::text[], 'partner', DATE '2005-03-28',
    'Boxmeer', 'India', 12.8946, 77.5089, 'Badminton player, sourdough baker, and trivia night enthusiast.', ARRAY['✍🏻 Writing', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #116
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/22.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-116-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-116-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #117: Naomi White (naomi.white@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('naomi.white@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Naomi White', TRUE, DATE '1993-09-21')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Naomi White', 'woman', ARRAY['man']::text[], 'both', DATE '1993-09-21',
    'Kalgoorlie', 'India', 13.025, 77.6299, 'Lover of old jazz records, thrift shops, and spontaneous road trips.', ARRAY['🎵 Music', '🏝 Travel', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #117
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/43.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-117-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-117-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #118: Cindy Perez (cindy.perez@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('cindy.perez@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Cindy Perez', TRUE, DATE '2005-04-06')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Cindy Perez', 'woman', ARRAY['man']::text[], 'friends', DATE '2005-04-06',
    'Victorville', 'India', 13.0056, 77.696, 'Badminton player, sourdough baker, and trivia night enthusiast.', ARRAY['🗣 Language', '👗 Fashion', '⚽️ Football', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #118
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/26.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-118-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-118-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #119: Debbie May (debbie.may@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('debbie.may@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Debbie May', TRUE, DATE '2005-08-01')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Debbie May', 'woman', ARRAY['woman','man']::text[], 'both', DATE '2005-08-01',
    'Edenderry', 'India', 12.9192, 77.6366, 'Here to meet interesting minds, share stories, and explore the city.', ARRAY['🎵 Music', '🙂 People', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #119
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/15.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-119-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-119-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #120: Carsta Rocha (carsta.rocha@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('carsta.rocha@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Carsta Rocha', TRUE, DATE '1993-05-27')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Carsta Rocha', 'man', ARRAY['woman']::text[], 'friends', DATE '1993-05-27',
    'Arapongas', 'India', 12.8424, 77.6948, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['🎵 Music', '🍃 Nature', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #120
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/4.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-120-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-120-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Carsta Rocha
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'sports', 'Anyone up for weekly badminton, tennis, or padel games in the city?', NOW() - interval '14 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Anyone up for weekly badminton, tennis, or padel games in the city?');

  -- FakeUser #121: Consuelo Arias (consuelo.arias@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('consuelo.arias@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Consuelo Arias', TRUE, DATE '1993-01-08')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Consuelo Arias', 'woman', ARRAY['man']::text[], 'friends', DATE '1993-01-08',
    'HSR Layout', 'India', 12.9081, 77.7296, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['⚽️ Football', '✍🏻 Writing', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #121
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/71.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-121-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-121-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #122: Stella Guillot (stella.guillot@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('stella.guillot@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Stella Guillot', TRUE, DATE '1993-06-24')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Stella Guillot', 'woman', ARRAY['man']::text[], 'partner', DATE '1993-06-24',
    'Bottens', 'India', 13.0711, 77.7044, 'Obsessed with Japanese cuisine, sourdough experiments, and photography.', ARRAY['🙂 People', '📸 Photography', '🗣 Language', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #122
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/23.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-122-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-122-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #123: Marcus Walker (marcus.walker@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('marcus.walker@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Marcus Walker', TRUE, DATE '2005-10-18')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Marcus Walker', 'man', ARRAY['woman']::text[], 'friends', DATE '2005-10-18',
    'Auckland', 'India', 13.0311, 77.457, 'Obsessed with Japanese cuisine, sourdough experiments, and photography.', ARRAY['🙂 People', '⚽️ Football', '🍃 Nature', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #123
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/82.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-123-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-123-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #124: عسل مرادی (ticklishfish813@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('ticklishfish813@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'عسل مرادی', TRUE, DATE '1993-03-21')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'عسل مرادی', 'woman', ARRAY['man']::text[], 'partner', DATE '1993-03-21',
    'Whitefield', 'India', 13.0181, 77.5454, 'Software engineer, boba addict, and weekend hiker.', ARRAY['⚽️ Football', '🏝 Travel', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #124
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/65.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-124-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-124-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #125: باران یاسمی (ticklishfrog180@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('ticklishfrog180@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'باران یاسمی', TRUE, DATE '2004-09-17')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'باران یاسمی', 'woman', ARRAY['man']::text[], 'partner', DATE '2004-09-17',
    'Whitefield', 'India', 12.8866, 77.5107, 'Here to meet interesting minds, share stories, and explore the city.', ARRAY['🗣 Language', '🏝 Travel', '👗 Fashion', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #125
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/21.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-125-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-125-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #126: Noah Poulsen (noah.poulsen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('noah.poulsen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Noah Poulsen', TRUE, DATE '2005-08-23')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Noah Poulsen', 'man', ARRAY['woman']::text[], 'both', DATE '2005-08-23',
    'Whitefield', 'India', 12.9055, 77.573, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['✍🏻 Writing', '🎵 Music', '📸 Photography', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #126
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/41.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-126-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-126-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Noah Poulsen
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'dating', 'Spontaneous adventures or planned dinner dates? Which one wins?', NOW() - interval '49 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Spontaneous adventures or planned dinner dates? Which one wins?');

  -- FakeUser #127: Priteche Fogaça (yellowkoala267@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('yellowkoala267@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Priteche Fogaça', TRUE, DATE '1993-10-23')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Priteche Fogaça', 'man', ARRAY['woman']::text[], 'friends', DATE '1993-10-23',
    'Bengaluru', 'India', 12.9773, 77.7311, 'Marathon training in progress. Will run for good pastries.', ARRAY['🙂 People', '🗣 Language', '🎵 Music', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #127
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'http://localhost:8000/media/fakeusers/algolia/men/gabe.png', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-127-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-127-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #128: Edgar Friedrich (edgar.friedrich@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('edgar.friedrich@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Edgar Friedrich', TRUE, DATE '1993-02-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Edgar Friedrich', 'man', ARRAY['woman']::text[], 'both', DATE '1993-02-02',
    'Trier', 'India', 13.0073, 77.4634, 'Weekend road trips, film photography, and spicy street food.', ARRAY['🍃 Nature', '🏝 Travel', '👗 Fashion', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #128
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/70.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-128-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-128-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #129: Benjamin Beck (benjamin.beck@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('benjamin.beck@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Benjamin Beck', TRUE, DATE '1993-08-01')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Benjamin Beck', 'man', ARRAY['woman']::text[], 'partner', DATE '1993-08-01',
    'Sunshine Coast', 'India', 12.9465, 77.6986, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['🏝 Travel', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #129
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/61.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-129-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-129-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #130: Sofie Sørensen (heavymeercat516@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('heavymeercat516@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Sofie Sørensen', TRUE, DATE '1993-06-18')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Sofie Sørensen', 'woman', ARRAY['man']::text[], 'friends', DATE '1993-06-18',
    'Frederiksberg', 'India', 12.9299, 77.5303, 'Med researcher who loves scuba diving, museums, and chai stalls.', ARRAY['💪 Gym & Fitness', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #130
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/4.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-130-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-130-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #131: Alizee Leroux (alizee.leroux@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('alizee.leroux@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Alizee Leroux', TRUE, DATE '1993-05-14')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Alizee Leroux', 'woman', ARRAY['man']::text[], 'both', DATE '1993-05-14',
    'Reims', 'India', 12.8682, 77.6049, 'Marathon training in progress. Will run for good pastries.', ARRAY['👗 Fashion', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #131
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/83.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-131-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-131-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #132: Sheryl Carr (sheryl.carr@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('sheryl.carr@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Sheryl Carr', TRUE, DATE '1993-09-26')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Sheryl Carr', 'woman', ARRAY['man']::text[], 'partner', DATE '1993-09-26',
    'Aberdeen', 'India', 12.9303, 77.6936, 'Software engineer, boba addict, and weekend hiker.', ARRAY['📸 Photography', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #132
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/75.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-132-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-132-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Sheryl Carr
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'creative', 'What piece of art, cinema, or literature completely blew your mind?', NOW() - interval '21 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What piece of art, cinema, or literature completely blew your mind?');

  -- FakeUser #133: Emeline Charles (emeline.charles@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('emeline.charles@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Emeline Charles', TRUE, DATE '1993-09-21')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Emeline Charles', 'woman', ARRAY['man']::text[], 'both', DATE '1993-09-21',
    'Romanel-Sur-Lausanne', 'India', 12.9761, 77.5835, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['🏝 Travel', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #133
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/90.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-133-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-133-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #134: Ariana Thompson (ariana.thompson@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('ariana.thompson@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Ariana Thompson', TRUE, DATE '1993-02-12')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Ariana Thompson', 'woman', ARRAY['woman','man']::text[], 'friends', DATE '1993-02-12',
    'Christchurch', 'India', 12.9709, 77.6225, 'Lover of old jazz records, thrift shops, and spontaneous road trips.', ARRAY['🏝 Travel', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #134
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/52.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-134-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-134-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #135: Jeremy Weiss (jeremy.weiss@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jeremy.weiss@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Jeremy Weiss', TRUE, DATE '2004-10-08')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jeremy Weiss', 'man', ARRAY['woman']::text[], 'both', DATE '2004-10-08',
    'Bengaluru', 'India', 12.8686, 77.4569, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['💪 Gym & Fitness', '✍🏻 Writing', '🍃 Nature', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #135
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/37.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-135-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-135-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #136: Marcos Soto (marcos.soto@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('marcos.soto@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Marcos Soto', TRUE, DATE '1997-07-01')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Marcos Soto', 'man', ARRAY['woman']::text[], 'both', DATE '1997-07-01',
    'Alcobendas', 'India', 12.8949, 77.5903, 'Med researcher who loves scuba diving, museums, and chai stalls.', ARRAY['💪 Gym & Fitness', '🏝 Travel', '📸 Photography', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #136
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/31.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-136-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-136-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #137: Sofia Sales (sofia.sales@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('sofia.sales@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Sofia Sales', TRUE, DATE '1996-09-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Sofia Sales', 'woman', ARRAY['woman','man']::text[], 'both', DATE '1996-09-02',
    'Catanduva', 'India', 13.0113, 77.7209, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['🍃 Nature', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #137
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/66.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-137-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-137-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #138: Anna Miller (anna.miller@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('anna.miller@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Anna Miller', TRUE, DATE '2005-09-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Anna Miller', 'woman', ARRAY['woman','man']::text[], 'friends', DATE '2005-09-02',
    'Ely', 'India', 12.8982, 77.6208, 'Learning guitar and cooking regional curries from scratch.', ARRAY['⚽️ Football', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #138
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/84.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-138-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-138-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Anna Miller
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'dating', 'Spontaneous adventures or planned dinner dates? Which one wins?', NOW() - interval '32 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Spontaneous adventures or planned dinner dates? Which one wins?');

  -- FakeUser #139: Donald Riley (donald.riley@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('donald.riley@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Donald Riley', TRUE, DATE '1994-01-20')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Donald Riley', 'man', ARRAY['woman']::text[], 'both', DATE '1994-01-20',
    'Dumas', 'India', 12.8884, 77.5015, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['💪 Gym & Fitness', '🍃 Nature', '✍🏻 Writing', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #139
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/34.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-139-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-139-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #140: Melany Wijngaard (melany.wijngaard@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('melany.wijngaard@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Melany Wijngaard', TRUE, DATE '1993-04-08')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Melany Wijngaard', 'woman', ARRAY['man']::text[], 'partner', DATE '1993-04-08',
    'Staphorst', 'India', 12.9631, 77.7272, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['🍃 Nature', '🏝 Travel', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #140
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/70.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-140-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-140-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #141: Mathias Nielsen (mathias.nielsen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('mathias.nielsen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Mathias Nielsen', TRUE, DATE '1993-04-21')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Mathias Nielsen', 'man', ARRAY['woman']::text[], 'friends', DATE '1993-04-21',
    'Indiranagar', 'India', 12.8985, 77.6218, 'Architect obsessed with brutalist buildings, house plants, and jazz vinyl.', ARRAY['🎵 Music', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #141
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/14.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-141-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-141-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #142: Claire Garcia (claire.garcia@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('claire.garcia@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Claire Garcia', TRUE, DATE '1993-04-14')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Claire Garcia', 'woman', ARRAY['man']::text[], 'partner', DATE '1993-04-14',
    'Bournens', 'India', 13.1013, 77.6138, 'Here to meet interesting minds, share stories, and explore the city.', ARRAY['🎵 Music', '🙂 People', '👗 Fashion', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #142
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/81.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-142-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-142-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #143: Ashley Tucker (ashley.tucker@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('ashley.tucker@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Ashley Tucker', TRUE, DATE '1993-07-18')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Ashley Tucker', 'woman', ARRAY['man']::text[], 'partner', DATE '1993-07-18',
    'Listowel', 'India', 13.0934, 77.4631, 'Tech startup dev. Passionate about open-source, bouldering, and board games.', ARRAY['🍃 Nature', '🏝 Travel', '✍🏻 Writing', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #143
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/47.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-143-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-143-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #144: Alyssa Andre (alyssa.andre@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('alyssa.andre@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Alyssa Andre', TRUE, DATE '1993-06-17')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Alyssa Andre', 'woman', ARRAY['woman','man']::text[], 'both', DATE '1993-06-17',
    'Mulhouse', 'India', 12.9656, 77.5885, 'Med researcher who loves scuba diving, museums, and chai stalls.', ARRAY['📸 Photography', '👗 Fashion', '💪 Gym & Fitness', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #144
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/37.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-144-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-144-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Alyssa Andre
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'sports', 'Anyone up for weekly badminton, tennis, or padel games in the city?', NOW() - interval '44 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Anyone up for weekly badminton, tennis, or padel games in the city?');

  -- FakeUser #145: Summer Wood (summer.wood@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('summer.wood@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Summer Wood', TRUE, DATE '1993-03-03')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Summer Wood', 'woman', ARRAY['man']::text[], 'friends', DATE '1993-03-03',
    'Palmerston North', 'India', 12.9841, 77.7183, 'Product designer by day, indie concert hunter by night.', ARRAY['📸 Photography', '🏝 Travel', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #145
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/34.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-145-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-145-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #146: Natércio Castro (purplewolf989@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('purplewolf989@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Natércio Castro', TRUE, DATE '1993-07-25')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Natércio Castro', 'man', ARRAY['woman']::text[], 'friends', DATE '1993-07-25',
    'Olinda', 'India', 12.8621, 77.5591, 'Marathon training in progress. Will run for good pastries.', ARRAY['✍🏻 Writing', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #146
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/13.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-146-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-146-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #147: Terrence King (terrence.king@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('terrence.king@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Terrence King', TRUE, DATE '2000-10-16')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Terrence King', 'man', ARRAY['woman','man']::text[], 'both', DATE '2000-10-16',
    'Australian Capital Territory', 'India', 13.0084, 77.4667, 'Obsessed with Japanese cuisine, sourdough experiments, and photography.', ARRAY['👗 Fashion', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #147
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/87.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-147-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-147-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #148: William David (william.david@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('william.david@example.com', crypt('demo1234', gen_salt('bf', 10)), 'William David', TRUE, DATE '1993-10-18')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'William David', 'man', ARRAY['woman']::text[], 'both', DATE '1993-10-18',
    'Aclens', 'India', 13.0192, 77.5455, 'Casual gamer, dog enthusiast, and sunset chaser.', ARRAY['🗣 Language', '📸 Photography', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #148
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/38.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-148-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-148-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #149: Irene Morales (irene.morales@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('irene.morales@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Irene Morales', TRUE, DATE '1993-04-15')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Irene Morales', 'woman', ARRAY['man']::text[], 'both', DATE '1993-04-15',
    'Lorca', 'India', 13.0592, 77.6385, 'Learning guitar and cooking regional curries from scratch.', ARRAY['🍃 Nature', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #149
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/87.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-149-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-149-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #150: آرمیتا سلطانی نژاد (blueswan165@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('blueswan165@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'آرمیتا سلطانی نژاد', TRUE, DATE '2005-08-22')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'آرمیتا سلطانی نژاد', 'woman', ARRAY['man']::text[], 'both', DATE '2005-08-22',
    'Bengaluru', 'India', 12.8414, 77.698, 'Badminton player, sourdough baker, and trivia night enthusiast.', ARRAY['✍🏻 Writing', '🍃 Nature', '⚽️ Football', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #150
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/8.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-150-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-150-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by آرمیتا سلطانی نژاد
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'fitness', 'Any morning runners or bouldering fans looking for a weekend buddy?', NOW() - interval '24 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Any morning runners or bouldering fans looking for a weekend buddy?');

  -- FakeUser #151: Stefan Siebert (stefan.siebert@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('stefan.siebert@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Stefan Siebert', TRUE, DATE '2001-07-16')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Stefan Siebert', 'man', ARRAY['woman']::text[], 'both', DATE '2001-07-16',
    'Kleve', 'India', 12.9296, 77.6975, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['🙂 People', '👗 Fashion', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #151
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/21.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-151-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-151-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #152: Amy Miller (amy.miller@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('amy.miller@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Amy Miller', TRUE, DATE '1993-06-17')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Amy Miller', 'woman', ARRAY['man']::text[], 'friends', DATE '1993-06-17',
    'St. Antoine', 'India', 12.9717, 77.5797, 'Software engineer, boba addict, and weekend hiker.', ARRAY['🍃 Nature', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #152
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/58.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-152-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-152-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #153: Noélie Roux (blueelephant373@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('blueelephant373@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Noélie Roux', TRUE, DATE '1993-03-25')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Noélie Roux', 'woman', ARRAY['man']::text[], 'both', DATE '1993-03-25',
    'Paris', 'India', 13.0246, 77.6729, 'Always in search of the best specialty coffee and quiet reading nooks.', ARRAY['🏝 Travel', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #153
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/51.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-153-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-153-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #154: Enrique Brewer (enrique.brewer@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('enrique.brewer@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Enrique Brewer', TRUE, DATE '1994-08-17')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Enrique Brewer', 'man', ARRAY['woman']::text[], 'both', DATE '1994-08-17',
    'Newcastle West', 'India', 12.9415, 77.5777, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['🎵 Music', '🍃 Nature', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #154
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/76.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-154-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-154-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #155: Abssilão Rodrigues (smallleopard973@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('smallleopard973@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Abssilão Rodrigues', TRUE, DATE '1993-05-26')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Abssilão Rodrigues', 'man', ARRAY['woman']::text[], 'partner', DATE '1993-05-26',
    'Pinhais', 'India', 13.0587, 77.4808, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['💪 Gym & Fitness', '🍃 Nature', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #155
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/5.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-155-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-155-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #156: Liam Walters (liam.walters@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('liam.walters@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Liam Walters', TRUE, DATE '1996-03-11')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Liam Walters', 'man', ARRAY['woman','man']::text[], 'partner', DATE '1996-03-11',
    'Devonport', 'India', 13.0607, 77.6719, 'Obsessed with Japanese cuisine, sourdough experiments, and photography.', ARRAY['✍🏻 Writing', '🎵 Music', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #156
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/50.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-156-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-156-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Liam Walters
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'philosophy', 'What is an underrated quality you cherish in friends and partners?', NOW() - interval '11 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What is an underrated quality you cherish in friends and partners?');

  -- FakeUser #157: Nicole Curtis (nicole.curtis@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('nicole.curtis@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Nicole Curtis', TRUE, DATE '2005-08-07')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Nicole Curtis', 'woman', ARRAY['man']::text[], 'partner', DATE '2005-08-07',
    'Carrick-On-Suir', 'India', 12.9642, 77.4662, 'Software engineer, boba addict, and weekend hiker.', ARRAY['👗 Fashion', '🙂 People', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #157
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/41.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-157-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-157-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #158: Deolindo Vieira (deolindo.vieira@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('deolindo.vieira@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Deolindo Vieira', TRUE, DATE '2005-05-16')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Deolindo Vieira', 'man', ARRAY['woman','man']::text[], 'friends', DATE '2005-05-16',
    'Varginha', 'India', 12.9338, 77.6778, 'Here to meet interesting minds, share stories, and explore the city.', ARRAY['🏝 Travel', '🎵 Music', '🗣 Language', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #158
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/59.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-158-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-158-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #159: Miguel Sanz (miguel.sanz@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('miguel.sanz@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Miguel Sanz', TRUE, DATE '1993-04-11')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Miguel Sanz', 'man', ARRAY['woman']::text[], 'friends', DATE '1993-04-11',
    'Valladolid', 'India', 12.9533, 77.5577, 'Software engineer, boba addict, and weekend hiker.', ARRAY['📸 Photography', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #159
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/71.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-159-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-159-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #160: Karen Stanley (karen.stanley@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('karen.stanley@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Karen Stanley', TRUE, DATE '2005-04-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Karen Stanley', 'woman', ARRAY['woman','man']::text[], 'both', DATE '2005-04-28',
    'Loughrea', 'India', 13.0526, 77.6368, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['🏝 Travel', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #160
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/63.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-160-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-160-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #161: Tammy Hayes (tammy.hayes@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('tammy.hayes@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Tammy Hayes', TRUE, DATE '2005-05-08')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Tammy Hayes', 'woman', ARRAY['man']::text[], 'both', DATE '2005-05-08',
    'Athlone', 'India', 13.0678, 77.6748, 'Always in search of the best specialty coffee and quiet reading nooks.', ARRAY['✍🏻 Writing', '⚽️ Football', '🙂 People', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #161
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/59.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-161-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-161-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #162: شایان حسینی (heavybird362@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('heavybird362@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'شایان حسینی', TRUE, DATE '1993-01-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'شایان حسینی', 'man', ARRAY['woman','man']::text[], 'both', DATE '1993-01-28',
    'Whitefield', 'India', 13.1041, 77.6861, 'Obsessed with Japanese cuisine, sourdough experiments, and photography.', ARRAY['🏝 Travel', '⚽️ Football', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #162
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/58.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-162-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-162-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by شایان حسینی
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'nature', 'Sunrise hike or sunset by the ocean?', NOW() - interval '24 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Sunrise hike or sunset by the ocean?');

  -- FakeUser #163: Konrad Siebert (konrad.siebert@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('konrad.siebert@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Konrad Siebert', TRUE, DATE '1993-11-09')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Konrad Siebert', 'man', ARRAY['woman']::text[], 'friends', DATE '1993-11-09',
    'Osterode Am Harz', 'India', 13.0941, 77.5661, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['✍🏻 Writing', '👗 Fashion', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #163
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/45.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-163-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-163-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #164: Ben Perry (ben.perry@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('ben.perry@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Ben Perry', TRUE, DATE '1993-12-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Ben Perry', 'man', ARRAY['woman','man']::text[], 'friends', DATE '1993-12-28',
    'West Jordan', 'India', 12.9771, 77.5303, 'Learning guitar and cooking regional curries from scratch.', ARRAY['🗣 Language', '🙂 People', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #164
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/77.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-164-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-164-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #165: Joaquin Hidalgo (joaquin.hidalgo@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('joaquin.hidalgo@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Joaquin Hidalgo', TRUE, DATE '2005-10-10')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Joaquin Hidalgo', 'man', ARRAY['woman']::text[], 'partner', DATE '2005-10-10',
    'Indiranagar', 'India', 13.0303, 77.5764, 'Yoga practitioner, tea snob, and amateur rooftop gardener.', ARRAY['🍃 Nature', '🙂 People', '⚽️ Football', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #165
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/57.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-165-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-165-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #166: Pauline Perez (pauline.perez@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('pauline.perez@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Pauline Perez', TRUE, DATE '1999-01-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Pauline Perez', 'woman', ARRAY['man']::text[], 'both', DATE '1999-01-28',
    'Aclens', 'India', 12.9303, 77.7025, 'Always in search of the best specialty coffee and quiet reading nooks.', ARRAY['👗 Fashion', '⚽️ Football', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #166
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/96.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-166-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-166-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #167: Tom Wolff (tom.wolff@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('tom.wolff@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Tom Wolff', TRUE, DATE '1993-02-17')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Tom Wolff', 'man', ARRAY['woman']::text[], 'both', DATE '1993-02-17',
    'Vechta', 'India', 12.9961, 77.6251, 'Med researcher who loves scuba diving, museums, and chai stalls.', ARRAY['🏝 Travel', '✍🏻 Writing', '⚽️ Football', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #167
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'http://localhost:8000/media/fakeusers/algolia/men/xander.png', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-167-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-167-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #168: Oona Latvala (oona.latvala@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('oona.latvala@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Oona Latvala', TRUE, DATE '1993-01-23')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Oona Latvala', 'woman', ARRAY['man']::text[], 'both', DATE '1993-01-23',
    'Vimpeli', 'India', 12.9599, 77.6147, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['📸 Photography', '🗣 Language', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #168
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/77.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-168-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-168-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Oona Latvala
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'sports', 'Anyone up for weekly badminton, tennis, or padel games in the city?', NOW() - interval '47 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Anyone up for weekly badminton, tennis, or padel games in the city?');

  -- FakeUser #169: James Lévesque (bigelephant213@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('bigelephant213@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'James Lévesque', TRUE, DATE '1995-08-10')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'James Lévesque', 'man', ARRAY['woman']::text[], 'both', DATE '1995-08-10',
    'Shelbourne', 'India', 13.0623, 77.5238, 'Here to meet interesting minds, share stories, and explore the city.', ARRAY['⚽️ Football', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #169
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/6.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-169-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-169-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #170: Femia Pruijssers (femia.pruijssers@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('femia.pruijssers@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Femia Pruijssers', TRUE, DATE '1993-12-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Femia Pruijssers', 'woman', ARRAY['man']::text[], 'friends', DATE '1993-12-28',
    'Ferwerderadiel', 'India', 12.8509, 77.5428, 'Marathon training in progress. Will run for good pastries.', ARRAY['🙂 People', '💪 Gym & Fitness', '🎵 Music', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #170
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/11.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-170-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-170-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #171: Laly Da Silva (laly.dasilva@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('laly.dasilva@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Laly Da Silva', TRUE, DATE '2005-08-11')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Laly Da Silva', 'woman', ARRAY['man']::text[], 'both', DATE '2005-08-11',
    'Villars-Le-Terroir', 'India', 13.0946, 77.5036, 'Filmmaker & visual artist. Let''s debate A24 movies over boba.', ARRAY['🗣 Language', '👗 Fashion', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #171
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/9.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-171-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-171-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #172: Ross Nichols (ross.nichols@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('ross.nichols@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Ross Nichols', TRUE, DATE '2005-03-16')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Ross Nichols', 'man', ARRAY['woman','man']::text[], 'both', DATE '2005-03-16',
    'Kilcock', 'India', 13.0826, 77.5859, 'Tech startup dev. Passionate about open-source, bouldering, and board games.', ARRAY['🎵 Music', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #172
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/66.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-172-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-172-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #173: Sarah Oliver (sarah.oliver@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('sarah.oliver@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Sarah Oliver', TRUE, DATE '2002-12-03')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Sarah Oliver', 'woman', ARRAY['man']::text[], 'both', DATE '2002-12-03',
    'Manchester', 'India', 12.9841, 77.5317, 'Product designer by day, indie concert hunter by night.', ARRAY['👗 Fashion', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #173
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/73.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-173-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-173-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #174: Jeanne Nelson (jeanne.nelson@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('jeanne.nelson@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Jeanne Nelson', TRUE, DATE '1993-09-26')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jeanne Nelson', 'woman', ARRAY['man']::text[], 'both', DATE '1993-09-26',
    'Geelong', 'India', 12.9478, 77.4655, 'Obsessed with Japanese cuisine, sourdough experiments, and photography.', ARRAY['🗣 Language', '🍃 Nature', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #174
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/33.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-174-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-174-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Jeanne Nelson
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'food', 'Late night street food or Sunday brunch? Drop your go-to order.', NOW() - interval '61 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Late night street food or Sunday brunch? Drop your go-to order.');

  -- FakeUser #175: Bernard Wilson (bernard.wilson@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('bernard.wilson@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Bernard Wilson', TRUE, DATE '1993-12-28')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Bernard Wilson', 'man', ARRAY['woman']::text[], 'both', DATE '1993-12-28',
    'Preston', 'India', 12.841, 77.5047, 'Data scientist with a weak spot for dog memes and Sunday morning hikes.', ARRAY['⚽️ Football', '🗣 Language', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #175
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/80.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-175-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-175-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #176: Darius Conrad (darius.conrad@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('darius.conrad@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Darius Conrad', TRUE, DATE '1993-05-25')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Darius Conrad', 'man', ARRAY['woman']::text[], 'both', DATE '1993-05-25',
    'Osterode Am Harz', 'India', 13.1105, 77.5094, 'Obsessed with Japanese cuisine, sourdough experiments, and photography.', ARRAY['🎵 Music', '🙂 People']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #176
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/68.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-176-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-176-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #177: Malthe Andersen (malthe.andersen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('malthe.andersen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Malthe Andersen', TRUE, DATE '1993-11-23')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Malthe Andersen', 'man', ARRAY['woman']::text[], 'both', DATE '1993-11-23',
    'Lemvig', 'India', 13.0639, 77.605, 'Always in search of the best specialty coffee and quiet reading nooks.', ARRAY['👗 Fashion', '⚽️ Football', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #177
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/30.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-177-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-177-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #178: Emma Manni (emma.manni@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('emma.manni@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Emma Manni', TRUE, DATE '1993-07-13')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Emma Manni', 'woman', ARRAY['man']::text[], 'both', DATE '1993-07-13',
    'Geta', 'India', 13.0332, 77.7098, 'Med researcher who loves scuba diving, museums, and chai stalls.', ARRAY['💪 Gym & Fitness', '📸 Photography', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #178
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/5.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-178-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-178-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #179: Druso Nascimento (druso.nascimento@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('druso.nascimento@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Druso Nascimento', TRUE, DATE '1996-10-13')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Druso Nascimento', 'man', ARRAY['woman','man']::text[], 'both', DATE '1996-10-13',
    'Vespasiano', 'India', 13.001, 77.6075, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['✍🏻 Writing', '⚽️ Football', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #179
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/18.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-179-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-179-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #180: Greta Van Limpt (greta.vanlimpt@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('greta.vanlimpt@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Greta Van Limpt', TRUE, DATE '1993-03-19')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Greta Van Limpt', 'woman', ARRAY['man']::text[], 'both', DATE '1993-03-19',
    'Culemborg', 'India', 12.8778, 77.642, 'Product designer by day, indie concert hunter by night.', ARRAY['⚽️ Football', '💪 Gym & Fitness', '🗣 Language', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #180
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/12.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-180-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-180-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Greta Van Limpt
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'fitness', 'Any morning runners or bouldering fans looking for a weekend buddy?', NOW() - interval '66 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Any morning runners or bouldering fans looking for a weekend buddy?');

  -- FakeUser #181: نيما جعفری (beautifullion345@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('beautifullion345@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'نيما جعفری', TRUE, DATE '1993-11-13')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'نيما جعفری', 'man', ARRAY['woman']::text[], 'friends', DATE '1993-11-13',
    'Bengaluru', 'India', 13.0664, 77.4688, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['💪 Gym & Fitness', '🎵 Music', '🙂 People', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #181
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/42.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-181-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-181-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #182: ستایش یاسمی (silverostrich141@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('silverostrich141@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'ستایش یاسمی', TRUE, DATE '2005-03-13')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'ستایش یاسمی', 'woman', ARRAY['man']::text[], 'both', DATE '2005-03-13',
    'HSR Layout', 'India', 12.8691, 77.6725, 'Here to meet interesting minds, share stories, and explore the city.', ARRAY['🎵 Music', '🍃 Nature', '📸 Photography', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #182
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/10.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-182-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-182-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #183: Marcus Rasmussen (marcus.rasmussen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('marcus.rasmussen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Marcus Rasmussen', TRUE, DATE '1993-07-11')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Marcus Rasmussen', 'man', ARRAY['woman','man']::text[], 'partner', DATE '1993-07-11',
    'Gjerlev', 'India', 12.9874, 77.6843, 'Casual gamer, dog enthusiast, and sunset chaser.', ARRAY['⚽️ Football', '🗣 Language', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #183
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/51.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-183-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-183-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #184: Peter Bell (peter.bell@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('peter.bell@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Peter Bell', TRUE, DATE '1995-02-12')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Peter Bell', 'man', ARRAY['woman','man']::text[], 'partner', DATE '1995-02-12',
    'Ely', 'India', 12.901, 77.665, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['🗣 Language', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #184
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/53.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-184-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-184-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #185: Hector Guerrero (hector.guerrero@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('hector.guerrero@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Hector Guerrero', TRUE, DATE '2002-12-24')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Hector Guerrero', 'man', ARRAY['woman']::text[], 'partner', DATE '2002-12-24',
    'Alcobendas', 'India', 13.0771, 77.5846, 'Here to meet interesting minds, share stories, and explore the city.', ARRAY['📸 Photography', '🏝 Travel', '👗 Fashion', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #185
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/11.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-185-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-185-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #186: Arnaud Lo (arnaud.lo@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('arnaud.lo@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Arnaud Lo', TRUE, DATE '1996-05-12')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Arnaud Lo', 'man', ARRAY['woman','man']::text[], 'partner', DATE '1996-05-12',
    'Maitland', 'India', 12.9696, 77.5092, 'Lover of old jazz records, thrift shops, and spontaneous road trips.', ARRAY['🗣 Language', '🍃 Nature', '💪 Gym & Fitness', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #186
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/32.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-186-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-186-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Arnaud Lo
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'lifestyle', 'Describe your perfect cozy evening at home in three words.', NOW() - interval '46 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Describe your perfect cozy evening at home in three words.');

  -- FakeUser #187: Julienne Lelieveld (julienne.lelieveld@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('julienne.lelieveld@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Julienne Lelieveld', TRUE, DATE '2005-11-17')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Julienne Lelieveld', 'woman', ARRAY['man']::text[], 'both', DATE '2005-11-17',
    'Leeuwarden', 'India', 13.0783, 77.5629, 'Software engineer, boba addict, and weekend hiker.', ARRAY['⚽️ Football', '📸 Photography', '👗 Fashion', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #187
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/86.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-187-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-187-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #188: Aurélien Fontai (silversnake816@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('silversnake816@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Aurélien Fontai', TRUE, DATE '1993-08-22')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Aurélien Fontai', 'man', ARRAY['woman']::text[], 'both', DATE '1993-08-22',
    'Epesses', 'India', 13.074, 77.6519, 'Software engineer, boba addict, and weekend hiker.', ARRAY['🎵 Music', '🍃 Nature', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #188
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'http://localhost:8000/media/fakeusers/algolia/men/alexs.png', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-188-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-188-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #189: Valdemar Nielsen (valdemar.nielsen@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('valdemar.nielsen@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Valdemar Nielsen', TRUE, DATE '1993-01-15')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Valdemar Nielsen', 'man', ARRAY['woman']::text[], 'both', DATE '1993-01-15',
    'Allinge', 'India', 12.897, 77.7055, 'Weekend road trips, film photography, and spicy street food.', ARRAY['🎵 Music', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #189
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/99.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-189-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-189-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #190: Fabio Dupont (fabio.dupont@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('fabio.dupont@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Fabio Dupont', TRUE, DATE '2005-01-27')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Fabio Dupont', 'man', ARRAY['woman']::text[], 'both', DATE '2005-01-27',
    'Denens', 'India', 12.8565, 77.5767, 'Lover of old jazz records, thrift shops, and spontaneous road trips.', ARRAY['✍🏻 Writing', '📸 Photography', '👗 Fashion', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #190
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/1.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-190-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-190-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #191: Mathew Richards (mathew.richards@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('mathew.richards@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Mathew Richards', TRUE, DATE '2001-05-02')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Mathew Richards', 'man', ARRAY['woman']::text[], 'both', DATE '2001-05-02',
    'Sunshine Coast', 'India', 13.0966, 77.6922, 'Software engineer, boba addict, and weekend hiker.', ARRAY['🍃 Nature', '👗 Fashion', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #191
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/15.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-191-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-191-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #192: Nonato Pires (nonato.pires@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('nonato.pires@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Nonato Pires', TRUE, DATE '1993-06-22')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Nonato Pires', 'man', ARRAY['woman','man']::text[], 'partner', DATE '1993-06-22',
    'Bengaluru', 'India', 13.0853, 77.4662, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['🏝 Travel', '✍🏻 Writing']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #192
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/91.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-192-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-192-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Nonato Pires
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'friends', 'language', 'What word in another language has no English translation but should?', NOW() - interval '23 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'What word in another language has no English translation but should?');

  -- FakeUser #193: Marjorie Steward (marjorie.steward@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('marjorie.steward@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Marjorie Steward', TRUE, DATE '2004-11-24')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Marjorie Steward', 'woman', ARRAY['man']::text[], 'partner', DATE '2004-11-24',
    'Traralgon', 'India', 13.0666, 77.6699, 'Obsessed with Japanese cuisine, sourdough experiments, and photography.', ARRAY['🎵 Music', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #193
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/36.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-193-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-193-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #194: Mia Sanchez (mia.sanchez@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('mia.sanchez@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Mia Sanchez', TRUE, DATE '1993-04-10')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Mia Sanchez', 'woman', ARRAY['man']::text[], 'both', DATE '1993-04-10',
    'Preston', 'India', 12.9294, 77.6661, 'Bookstore hoarder, pottery amateur, and golden retriever parent.', ARRAY['🏝 Travel', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #194
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/80.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-194-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-194-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #195: Efe Aydan (efe.aydan@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('efe.aydan@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Efe Aydan', TRUE, DATE '1993-09-17')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Efe Aydan', 'man', ARRAY['woman']::text[], 'both', DATE '1993-09-17',
    'Artvin', 'India', 13.0419, 77.6896, 'Casual gamer, dog enthusiast, and sunset chaser.', ARRAY['🍃 Nature', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #195
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/62.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-195-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-195-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #196: Giselle Monteiro (giselle.monteiro@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('giselle.monteiro@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Giselle Monteiro', TRUE, DATE '2005-04-13')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Giselle Monteiro', 'woman', ARRAY['woman','man']::text[], 'both', DATE '2005-04-13',
    'Americana', 'India', 12.9702, 77.6299, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['👗 Fashion', '🎵 Music', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #196
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/7.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-196-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-196-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #197: Theo Bader (theo.bader@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('theo.bader@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Theo Bader', TRUE, DATE '1993-07-15')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Theo Bader', 'man', ARRAY['woman']::text[], 'both', DATE '1993-07-15',
    'Bengaluru', 'India', 13.0413, 77.6694, 'Data scientist with a weak spot for dog memes and Sunday morning hikes.', ARRAY['🏝 Travel', '🍃 Nature', '📸 Photography', '⚽️ Football']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #197
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/63.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-197-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-197-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #198: Cassandre Leroux (cassandre.leroux@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('cassandre.leroux@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Cassandre Leroux', TRUE, DATE '1993-01-18')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Cassandre Leroux', 'woman', ARRAY['man']::text[], 'both', DATE '1993-01-18',
    'Versailles', 'India', 13.0525, 77.7221, 'Data scientist with a weak spot for dog memes and Sunday morning hikes.', ARRAY['🗣 Language', '🎵 Music', '🍃 Nature', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #198
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/25.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-198-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-198-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Cassandre Leroux
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'travel', 'Window seat or aisle seat? And what is your best travel story?', NOW() - interval '58 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Window seat or aisle seat? And what is your best travel story?');

  -- FakeUser #199: Edgar Shelton (edgar.shelton@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('edgar.shelton@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Edgar Shelton', TRUE, DATE '1993-12-24')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Edgar Shelton', 'man', ARRAY['woman']::text[], 'partner', DATE '1993-12-24',
    'Warrnambool', 'India', 13.0115, 77.536, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['🎵 Music', '✍🏻 Writing', '🙂 People', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #199
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/men/46.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-199-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-199-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #200: Isabel Jackson (isabel.jackson@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('isabel.jackson@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Isabel Jackson', TRUE, DATE '2005-06-11')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Isabel Jackson', 'woman', ARRAY['woman','man']::text[], 'partner', DATE '2005-06-11',
    'Gisborne', 'India', 12.9438, 77.5079, 'Product designer by day, indie concert hunter by night.', ARRAY['⚽️ Football', '🙂 People', '🍃 Nature']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #200
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/30.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-200-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-200-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #201: Helena Wirth (helena.wirth@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('helena.wirth@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Helena Wirth', TRUE, DATE '2003-08-05')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Helena Wirth', 'woman', ARRAY['man']::text[], 'both', DATE '2003-08-05',
    'Traunstein', 'India', 13.043, 77.6347, 'Lover of old jazz records, thrift shops, and spontaneous road trips.', ARRAY['⚽️ Football', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #201
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/53.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-201-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-201-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #202: Clotildes Da Rosa (clotildes.darosa@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('clotildes.darosa@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Clotildes Da Rosa', TRUE, DATE '1993-11-22')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Clotildes Da Rosa', 'woman', ARRAY['man']::text[], 'both', DATE '1993-11-22',
    'Itabira', 'India', 13.0312, 77.4639, 'Architect obsessed with brutalist buildings, house plants, and jazz vinyl.', ARRAY['⚽️ Football', '🍃 Nature', '🙂 People', '📸 Photography']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #202
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/16.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-202-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-202-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #203: Buse Dağdaş (crazypeacock394@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('crazypeacock394@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Buse Dağdaş', TRUE, DATE '2005-09-23')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Buse Dağdaş', 'woman', ARRAY['man']::text[], 'both', DATE '2005-09-23',
    'Malatya', 'India', 12.8468, 77.6929, 'Learning guitar and cooking regional curries from scratch.', ARRAY['🗣 Language', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #203
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/14.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-203-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-203-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #204: Amelia Mercier (amelia.mercier@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('amelia.mercier@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Amelia Mercier', TRUE, DATE '2005-11-18')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Amelia Mercier', 'woman', ARRAY['man']::text[], 'friends', DATE '2005-11-18',
    'Echandens-Denges', 'India', 12.844, 77.7225, 'Data scientist with a weak spot for dog memes and Sunday morning hikes.', ARRAY['⚽️ Football', '🏝 Travel', '👗 Fashion']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #204
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/91.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-204-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-204-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- Feed post by Amelia Mercier
  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)
  SELECT u_id, 'partner', 'lifestyle', 'Describe your perfect cozy evening at home in three words.', NOW() - interval '47 hours'
  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = 'Describe your perfect cozy evening at home in three words.');

  -- FakeUser #205: Maureen Ramos (maureen.ramos@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('maureen.ramos@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Maureen Ramos', TRUE, DATE '1993-02-06')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Maureen Ramos', 'woman', ARRAY['man']::text[], 'both', DATE '1993-02-06',
    'Coffs Harbour', 'India', 13.0948, 77.7137, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['⚽️ Football', '🏝 Travel']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #205
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/69.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-205-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-205-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #206: Solène Lemaire (heavyladybug601@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('heavyladybug601@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Solène Lemaire', TRUE, DATE '1993-12-26')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Solène Lemaire', 'woman', ARRAY['man']::text[], 'friends', DATE '1993-12-26',
    'Metz', 'India', 13.0858, 77.5553, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['🍃 Nature', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #206
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/76.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-206-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-206-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #207: Ernest Williamson (ernest.williamson@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('ernest.williamson@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Ernest Williamson', TRUE, DATE '1993-12-06')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Ernest Williamson', 'man', ARRAY['woman']::text[], 'partner', DATE '1993-12-06',
    'Tramore', 'India', 13.0355, 77.5692, 'Illustrator exploring watercolor and city sketching on weekends.', ARRAY['🙂 People', '🏝 Travel', '🎵 Music']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #207
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'http://localhost:8000/media/fakeusers/algolia/men/tim.png', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-207-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-207-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #208: Florian Hahn (florian.hahn@example.com)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('florian.hahn@example.com', crypt('demo1234', gen_salt('bf', 10)), 'Florian Hahn', TRUE, DATE '1993-10-26')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Florian Hahn', 'man', ARRAY['woman','man']::text[], 'both', DATE '1993-10-26',
    'Ostprignitz-Ruppin', 'India', 13.0291, 77.7023, 'Lover of old jazz records, thrift shops, and spontaneous road trips.', ARRAY['🎵 Music', '🍃 Nature', '🗣 Language']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #208
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'http://localhost:8000/media/fakeusers/algolia/men/julien.png', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-208-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-208-2/600/800', 2)
  ON CONFLICT DO NOTHING;

  -- FakeUser #209: Jalisa Köhler (greenelephant861@palora.fake)
  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)
  VALUES ('greenelephant861@palora.fake', crypt('demo1234', gen_salt('bf', 10)), 'Jalisa Köhler', TRUE, DATE '2003-05-14')
  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday
  RETURNING id INTO u_id;

  INSERT INTO dating.profiles (
    user_id, display_name, gender, looking_for, intent, birthday,
    city, country, lat, lng, about, interests, onboarding_complete, last_active_at
  ) VALUES (
    u_id, 'Jalisa Köhler', 'woman', ARRAY['man']::text[], 'partner', DATE '2003-05-14',
    'Leiden', 'India', 13.0313, 77.5459, 'DJ on weekends, foodie all week. Tell me your comfort meal.', ARRAY['⚽️ Football', '📸 Photography', '💪 Gym & Fitness']::text[], TRUE,
    NOW() - (random() * interval '96 hours')
  ) ON CONFLICT (user_id) DO UPDATE SET
    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,
    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,
    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;

  -- Photos for #209
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://randomuser.me/api/portraits/women/27.jpg', 0)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-209-1/600/800', 1)
  ON CONFLICT DO NOTHING;
  INSERT INTO dating.photos (user_id, url, position)
  VALUES (u_id, 'https://picsum.photos/seed/palora-fakeuser-209-2/600/800', 2)
  ON CONFLICT DO NOTHING;

END $$;
