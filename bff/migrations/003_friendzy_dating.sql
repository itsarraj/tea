-- Friendzy dating domain

CREATE SCHEMA IF NOT EXISTS dating;

ALTER TABLE auth.users
  ADD COLUMN IF NOT EXISTS phone_verified BOOLEAN NOT NULL DEFAULT FALSE;

CREATE TABLE IF NOT EXISTS dating.phone_otps (
    phone TEXT PRIMARY KEY,
    code_hash TEXT NOT NULL,
    expires_at TIMESTAMPTZ NOT NULL,
    attempts INT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS dating.profiles (
    user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    display_name TEXT NOT NULL,
    age INT,
    city TEXT NOT NULL DEFAULT 'Berlin',
    about TEXT NOT NULL DEFAULT '',
    interests TEXT[] NOT NULL DEFAULT '{}',
    lat DOUBLE PRECISION,
    lng DOUBLE PRECISION,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS dating.stories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    name TEXT NOT NULL,
    is_self BOOLEAN NOT NULL DEFAULT FALSE,
    sort_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS dating.feed_posts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    author_user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    author_name TEXT NOT NULL,
    city TEXT NOT NULL,
    category TEXT NOT NULL,
    question TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS dating.people (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    age INT NOT NULL,
    city TEXT NOT NULL,
    distance_km DOUBLE PRECISION NOT NULL DEFAULT 1,
    is_new BOOLEAN NOT NULL DEFAULT FALSE,
    online BOOLEAN NOT NULL DEFAULT FALSE,
    interests TEXT[] NOT NULL DEFAULT '{}',
    about TEXT NOT NULL DEFAULT '',
    match_percent INT NOT NULL DEFAULT 50,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS dating.swipes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    from_user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    target_people_id UUID NOT NULL REFERENCES dating.people(id) ON DELETE CASCADE,
    action TEXT NOT NULL CHECK (action IN ('like', 'pass')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (from_user_id, target_people_id)
);

CREATE TABLE IF NOT EXISTS dating.matches (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    people_id UUID NOT NULL REFERENCES dating.people(id) ON DELETE CASCADE,
    match_percent INT NOT NULL DEFAULT 80,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (user_id, people_id)
);

CREATE TABLE IF NOT EXISTS dating.conversations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    peer_people_id UUID REFERENCES dating.people(id) ON DELETE SET NULL,
    peer_name TEXT NOT NULL,
    preview TEXT NOT NULL DEFAULT '',
    unread BOOLEAN NOT NULL DEFAULT FALSE,
    last_message_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS dating.messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID NOT NULL REFERENCES dating.conversations(id) ON DELETE CASCADE,
    body TEXT NOT NULL,
    mine BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_dating_swipes_from ON dating.swipes (from_user_id);
CREATE INDEX IF NOT EXISTS idx_dating_matches_user ON dating.matches (user_id);
CREATE INDEX IF NOT EXISTS idx_dating_conversations_user ON dating.conversations (user_id);
CREATE INDEX IF NOT EXISTS idx_dating_messages_conv ON dating.messages (conversation_id);

-- Seed demo people
INSERT INTO dating.people (id, name, age, city, distance_km, is_new, online, interests, about, match_percent)
VALUES
  ('11111111-1111-1111-1111-111111111101', 'Halima', 19, 'Berlin', 16, true, true,
   ARRAY['🍃 Nature','🏝 Travel','✍🏻 Writing'],
   'A good listener. I love having a good talk to know each other’s side 😍.', 80),
  ('11111111-1111-1111-1111-111111111102', 'Vanessa', 18, 'Munich', 4.8, true, false,
   ARRAY['🎵 Music','📸 Photography'], 'Music festivals and late-night coffee chats.', 72),
  ('11111111-1111-1111-1111-111111111103', 'James', 20, 'Hanover', 2.2, true, true,
   ARRAY['⚽️ Football','💪 Gym & Fitness'], 'Always up for a pickup game.', 100),
  ('11111111-1111-1111-1111-111111111104', 'Kate', 21, 'Koln', 12.5, true, false,
   ARRAY['🗣 Language','👗 Fashion'], 'Learning German and collecting vinyl.', 88),
  ('11111111-1111-1111-1111-111111111105', 'Alfredo', 20, 'Hamburg', 2.5, false, true,
   ARRAY['🍃 Nature','🏝 Travel','✍🏻 Writing','🙂 People','💪 Gym & Fitness'],
   'A good listener. I love having a good talk to know each other’s side 😍.', 80),
  ('11111111-1111-1111-1111-111111111106', 'Eddie', 23, 'Dortmund', 2, false, true,
   ARRAY['🎵 Music'], 'DJ on weekends.', 94)
ON CONFLICT (id) DO NOTHING;

INSERT INTO dating.feed_posts (id, author_name, city, category, question)
VALUES
  ('22222222-2222-2222-2222-222222222201', 'Miranda Kehlani', 'Stuttgart', '🏝 Travel',
   'If you could live anywhere in the world, where would you pick?'),
  ('22222222-2222-2222-2222-222222222202', 'Brandon Aminoff', 'Hamburg', '⚽️ Football',
   'Who do you think will win Euro 2020?')
ON CONFLICT (id) DO NOTHING;

INSERT INTO dating.stories (id, name, is_self, sort_order)
VALUES
  ('33333333-3333-3333-3333-333333333301', 'You', true, 0),
  ('33333333-3333-3333-3333-333333333302', 'Selena', false, 1),
  ('33333333-3333-3333-3333-333333333303', 'Clara', false, 2),
  ('33333333-3333-3333-3333-333333333304', 'Fabian', false, 3),
  ('33333333-3333-3333-3333-333333333305', 'George', false, 4)
ON CONFLICT (id) DO NOTHING;
