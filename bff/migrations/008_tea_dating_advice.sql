-- Migration 008: Tea Dating Advice Domain Schema
-- Dedicated schema for brutalist text-only dating advice, fan following, verdicts, notes, and notifications.

-- 1. User & Profile extensions
ALTER TABLE auth.users
  ADD COLUMN IF NOT EXISTS handle TEXT;

CREATE UNIQUE INDEX IF NOT EXISTS idx_auth_users_handle
  ON auth.users (lower(handle)) WHERE handle IS NOT NULL;

ALTER TABLE dating.profiles
  ADD COLUMN IF NOT EXISTS handle TEXT NOT NULL DEFAULT '',
  ADD COLUMN IF NOT EXISTS rank_title TEXT NOT NULL DEFAULT 'Tea Novice',
  ADD COLUMN IF NOT EXISTS helpful_rating INT NOT NULL DEFAULT 95,
  ADD COLUMN IF NOT EXISTS followers_count INT NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS following_count INT NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS posts_count INT NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS advice_given_count INT NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS specialty TEXT NOT NULL DEFAULT 'General Dating',
  ADD COLUMN IF NOT EXISTS recent_advice_quote TEXT NOT NULL DEFAULT '';

CREATE INDEX IF NOT EXISTS idx_profiles_handle ON dating.profiles (handle);
CREATE INDEX IF NOT EXISTS idx_profiles_followers ON dating.profiles (followers_count DESC);

-- 2. Dilemma Feed Posts extensions (Verdicts, Flag Counts)
ALTER TABLE dating.feed_posts
  ADD COLUMN IF NOT EXISTS title TEXT NOT NULL DEFAULT '',
  ADD COLUMN IF NOT EXISTS red_flags INT NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS green_flags INT NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS valid_count INT NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS helpful_count INT NOT NULL DEFAULT 0;

-- 3. Post Verdict Votes (Red flag, Green flag, Valid)
CREATE TABLE IF NOT EXISTS dating.post_votes (
    post_id UUID NOT NULL REFERENCES dating.feed_posts(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    vote TEXT NOT NULL CHECK (vote IN ('red', 'green', 'valid')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (post_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_post_votes_user ON dating.post_votes (user_id);

-- 4. Post Bookmarks / Saves
CREATE TABLE IF NOT EXISTS dating.post_saves (
    post_id UUID NOT NULL REFERENCES dating.feed_posts(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (post_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_post_saves_user ON dating.post_saves (user_id);

-- 5. Comments / Advice responses
ALTER TABLE dating.post_comments
  ADD COLUMN IF NOT EXISTS advisor_rank TEXT NOT NULL DEFAULT 'Tea Contributor',
  ADD COLUMN IF NOT EXISTS helpful_count INT NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS is_top_advice BOOLEAN NOT NULL DEFAULT FALSE;

-- 6. Quick Status Notes (Stories rail on feed)
CREATE TABLE IF NOT EXISTS dating.quick_notes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    author TEXT NOT NULL,
    name TEXT NOT NULL,
    note TEXT NOT NULL,
    emoji TEXT NOT NULL DEFAULT '✨',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_quick_notes_created ON dating.quick_notes (created_at DESC);

-- 7. Fan Following (Follow / Following relationships)
CREATE TABLE IF NOT EXISTS dating.follows (
    follower_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    following_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'pending')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (follower_id, following_id)
);

CREATE INDEX IF NOT EXISTS idx_follows_following ON dating.follows (following_id);
CREATE INDEX IF NOT EXISTS idx_follows_follower ON dating.follows (follower_id);

-- 8. Notifications (Activity feed, Follow requests, Likes, Advice replies)
CREATE TABLE IF NOT EXISTS dating.notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    actor_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    actor_name TEXT NOT NULL,
    actor_handle TEXT NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('follow', 'follow_request', 'like', 'advice_reply')),
    text TEXT NOT NULL,
    post_id UUID REFERENCES dating.feed_posts(id) ON DELETE SET NULL,
    post_snippet TEXT,
    post_category TEXT,
    read BOOLEAN NOT NULL DEFAULT FALSE,
    confirmed BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_notifications_user_time ON dating.notifications (user_id, created_at DESC);

-- 9. Chat extensions
ALTER TABLE dating.messages
  ADD COLUMN IF NOT EXISTS reaction TEXT;

ALTER TABLE dating.conversations
  ADD COLUMN IF NOT EXISTS request_status TEXT NOT NULL DEFAULT 'active'
    CHECK (request_status IN ('active', 'request'));
