-- Friendzy: real-user dating model (replaces the demo `people` tables from 003)

-- Demo-only tables from 003 are dropped; profiles + phone_otps are kept.
DROP TABLE IF EXISTS dating.messages CASCADE;
DROP TABLE IF EXISTS dating.conversations CASCADE;
DROP TABLE IF EXISTS dating.matches CASCADE;
DROP TABLE IF EXISTS dating.swipes CASCADE;
DROP TABLE IF EXISTS dating.people CASCADE;
DROP TABLE IF EXISTS dating.stories CASCADE;
DROP TABLE IF EXISTS dating.feed_posts CASCADE;

-- ---------------------------------------------------------------------------
-- Profiles: one per auth.users row, created at signup, completed by onboarding
-- ---------------------------------------------------------------------------
ALTER TABLE dating.profiles
  DROP COLUMN IF EXISTS age,
  ADD COLUMN IF NOT EXISTS gender TEXT,
  ADD COLUMN IF NOT EXISTS looking_for TEXT[] NOT NULL DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS intent TEXT NOT NULL DEFAULT 'both',
  ADD COLUMN IF NOT EXISTS birthday DATE,
  ADD COLUMN IF NOT EXISTS min_age INT NOT NULL DEFAULT 18,
  ADD COLUMN IF NOT EXISTS max_age INT NOT NULL DEFAULT 45,
  ADD COLUMN IF NOT EXISTS max_distance_km INT NOT NULL DEFAULT 100,
  ADD COLUMN IF NOT EXISTS country TEXT NOT NULL DEFAULT 'India',
  ADD COLUMN IF NOT EXISTS onboarding_complete BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS last_active_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMPTZ;

ALTER TABLE dating.profiles ALTER COLUMN city SET DEFAULT '';

DO $$ BEGIN
  ALTER TABLE dating.profiles
    ADD CONSTRAINT profiles_gender_chk
    CHECK (gender IS NULL OR gender IN ('woman','man','nonbinary','other'));
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN
  ALTER TABLE dating.profiles
    ADD CONSTRAINT profiles_intent_chk CHECK (intent IN ('friends','partner','both'));
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

CREATE INDEX IF NOT EXISTS idx_profiles_geo ON dating.profiles (lat, lng)
  WHERE lat IS NOT NULL AND lng IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_profiles_active ON dating.profiles (last_active_at DESC);

-- Backfill: every existing user gets a profile row
INSERT INTO dating.profiles (user_id, display_name)
SELECT u.id, u.name FROM auth.users u
ON CONFLICT (user_id) DO NOTHING;

UPDATE dating.profiles p
SET birthday = u.birthday
FROM auth.users u
WHERE u.id = p.user_id AND p.birthday IS NULL AND u.birthday IS NOT NULL;

-- ---------------------------------------------------------------------------
-- Photos
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS dating.photos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    url TEXT NOT NULL,
    storage_key TEXT,
    position INT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_photos_user ON dating.photos (user_id, position);

-- ---------------------------------------------------------------------------
-- Swipes (user -> user), mutual like => match
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS dating.swipes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    from_user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    to_user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    action TEXT NOT NULL CHECK (action IN ('like','pass','superlike')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (from_user_id, to_user_id),
    CHECK (from_user_id <> to_user_id)
);
CREATE INDEX IF NOT EXISTS idx_swipes_to_like ON dating.swipes (to_user_id) WHERE action <> 'pass';

CREATE TABLE IF NOT EXISTS dating.matches (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_a UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    user_b UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    unmatched_at TIMESTAMPTZ,
    unmatched_by UUID,
    UNIQUE (user_a, user_b),
    CHECK (user_a < user_b)
);
CREATE INDEX IF NOT EXISTS idx_matches_a ON dating.matches (user_a) WHERE unmatched_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_matches_b ON dating.matches (user_b) WHERE unmatched_at IS NULL;

-- ---------------------------------------------------------------------------
-- Chat: one conversation per match, messages carry sender_id
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS dating.conversations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    match_id UUID NOT NULL UNIQUE REFERENCES dating.matches(id) ON DELETE CASCADE,
    user_a UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    user_b UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    last_message_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    last_preview TEXT NOT NULL DEFAULT '',
    last_sender_id UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_conversations_a ON dating.conversations (user_a, last_message_at DESC);
CREATE INDEX IF NOT EXISTS idx_conversations_b ON dating.conversations (user_b, last_message_at DESC);

CREATE TABLE IF NOT EXISTS dating.messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID NOT NULL REFERENCES dating.conversations(id) ON DELETE CASCADE,
    sender_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    body TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_messages_conv_time ON dating.messages (conversation_id, created_at DESC);

CREATE TABLE IF NOT EXISTS dating.message_reads (
    conversation_id UUID NOT NULL REFERENCES dating.conversations(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    last_read_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (conversation_id, user_id)
);

-- ---------------------------------------------------------------------------
-- Safety
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS dating.blocks (
    blocker_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    blocked_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (blocker_id, blocked_id)
);
CREATE INDEX IF NOT EXISTS idx_blocks_blocked ON dating.blocks (blocked_id);

CREATE TABLE IF NOT EXISTS dating.reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    reporter_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    reported_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    reason TEXT NOT NULL,
    details TEXT,
    status TEXT NOT NULL DEFAULT 'open',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ---------------------------------------------------------------------------
-- Feed (home prompts) + likes/comments
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS dating.feed_posts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    author_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    mode TEXT NOT NULL DEFAULT 'friends' CHECK (mode IN ('friends','partner')),
    category TEXT NOT NULL,
    question TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_feed_mode_time ON dating.feed_posts (mode, created_at DESC);

CREATE TABLE IF NOT EXISTS dating.post_likes (
    post_id UUID NOT NULL REFERENCES dating.feed_posts(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (post_id, user_id)
);

CREATE TABLE IF NOT EXISTS dating.post_comments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    post_id UUID NOT NULL REFERENCES dating.feed_posts(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    body TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_comments_post ON dating.post_comments (post_id, created_at);

-- ---------------------------------------------------------------------------
-- Push devices
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS dating.devices (
    expo_push_token TEXT PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    platform TEXT,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_devices_user ON dating.devices (user_id);

-- ---------------------------------------------------------------------------
-- Demo users (password: demo1234). Safe to keep in dev; delete in prod with:
--   DELETE FROM auth.users WHERE email LIKE 'demo%@friendzy.local';
-- ---------------------------------------------------------------------------
WITH demo(email, name, gender, looking_for, intent, birthday, city, lat, lng, about, interests, img) AS (
  VALUES
    ('demo1@friendzy.local','Halima Noor','woman','{man,woman}','both',DATE '2005-03-14','Bengaluru',12.9716,77.5946,'A good listener. I love having a good talk to know each other’s side 😍.','{🍃 Nature,🏝 Travel,✍🏻 Writing}',47),
    ('demo2@friendzy.local','Vanessa Dsouza','woman','{man}','partner',DATE '2006-07-02','Bengaluru',12.9352,77.6245,'Music festivals and late-night coffee chats.','{🎵 Music,📸 Photography}',44),
    ('demo3@friendzy.local','James Kurian','man','{woman}','both',DATE '2004-11-20','Bengaluru',12.9784,77.6408,'Always up for a pickup game.','{⚽️ Football,💪 Gym & Fitness}',12),
    ('demo4@friendzy.local','Kate Fernandes','woman','{man,woman}','friends',DATE '2003-01-09','Mumbai',19.0760,72.8777,'Learning German and collecting vinyl.','{🗣 Language,👗 Fashion}',26),
    ('demo5@friendzy.local','Alfredo Calzoni','man','{woman}','both',DATE '2004-05-30','Bengaluru',12.9141,77.6100,'A good listener. I love having a good talk to know each other’s side 😍.','{🍃 Nature,🏝 Travel,✍🏻 Writing,🙂 People,💪 Gym & Fitness}',33),
    ('demo6@friendzy.local','Eddie Menezes','man','{woman,man}','friends',DATE '2001-09-12','Pune',18.5204,73.8567,'DJ on weekends.','{🎵 Music}',15),
    ('demo7@friendzy.local','Clara Hazel','woman','{man}','partner',DATE '2002-02-22','Bengaluru',13.0358,77.5970,'Coffee, books, and long walks.','{✍🏻 Writing,🍃 Nature}',32),
    ('demo8@friendzy.local','Brandon Aminoff','man','{woman}','both',DATE '2004-08-15','Hyderabad',17.3850,78.4867,'Euro 2020 was robbed.','{⚽️ Football,🎵 Music}',51),
    ('demo9@friendzy.local','Amina Mina','woman','{woman,man}','friends',DATE '2005-12-01','Bengaluru',12.9698,77.7500,'Foodie exploring every street.','{📸 Photography,🏝 Travel}',49),
    ('demo10@friendzy.local','Savanna Hall','woman','{man}','partner',DATE '2003-06-18','Chennai',13.0827,80.2707,'Gym at 6, chai at 7.','{💪 Gym & Fitness,🙂 People}',20),
    ('demo11@friendzy.local','Miranda Kehlani','woman','{man,woman}','both',DATE '2002-10-05','Bengaluru',12.9569,77.7011,'If you could live anywhere, where?','{🏝 Travel,👗 Fashion}',38),
    ('demo12@friendzy.local','Finn Thomas','man','{woman}','friends',DATE '2005-04-27','Delhi',28.6139,77.2090,'Board games and bad puns.','{🗣 Language,🙂 People}',59)
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
         NOW() - (random() * interval '36 hours')
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

INSERT INTO dating.feed_posts (author_id, mode, category, question)
SELECT u.id, v.mode, v.category, v.question
FROM (VALUES
  ('demo11@friendzy.local','friends','🏝 Travel','If you could live anywhere in the world, where would you pick?'),
  ('demo8@friendzy.local','friends','⚽️ Football','Who do you think will win the next World Cup?'),
  ('demo7@friendzy.local','partner','✍🏻 Writing','What’s a book that changed how you see people?'),
  ('demo3@friendzy.local','partner','💪 Gym & Fitness','Morning workouts or evening runs?')
) AS v(email, mode, category, question)
JOIN auth.users u ON u.email = v.email
WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts f WHERE f.author_id = u.id AND f.question = v.question);
