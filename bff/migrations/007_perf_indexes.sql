-- Migration 007: Production performance indexes
-- Adds missing indexes for CASCADE DELETE performance and query efficiency.
-- All use IF NOT EXISTS so they are idempotent and safe on re-run.

-- dating.messages: sender_id needed for account deletion cascade (full table scan without this)
CREATE INDEX IF NOT EXISTS idx_dating_messages_sender
    ON dating.messages (sender_id);

-- dating.swipes: full to_user_id index (existing idx_swipes_to_like is partial WHERE action<>'pass',
--   which misses passed swipes on account deletion cascade)
CREATE INDEX IF NOT EXISTS idx_dating_swipes_to_user
    ON dating.swipes (to_user_id);

-- dating.matches: full user_b index (existing idx_matches_b is partial WHERE unmatched_at IS NULL,
--   which misses old unmatched rows on account deletion cascade)
CREATE INDEX IF NOT EXISTS idx_dating_matches_user_b_full
    ON dating.matches (user_b);

-- auth.users: phone lookup (phone_verify query: SELECT ... WHERE phone = $1)
CREATE INDEX IF NOT EXISTS idx_auth_users_phone
    ON auth.users (phone) WHERE phone IS NOT NULL;

-- dating.feed_posts: author_id for user deletion cascade and "my posts" queries
CREATE INDEX IF NOT EXISTS idx_dating_feed_posts_author
    ON dating.feed_posts (author_id);

-- dating.post_likes: user_id for cascade delete and "my likes" queries
CREATE INDEX IF NOT EXISTS idx_dating_post_likes_user
    ON dating.post_likes (user_id);

-- dating.post_comments: user_id for cascade delete
CREATE INDEX IF NOT EXISTS idx_dating_post_comments_user
    ON dating.post_comments (user_id);

-- dating.reports: reporter and reported indexes for cascade delete and admin queries
CREATE INDEX IF NOT EXISTS idx_dating_reports_reporter
    ON dating.reports (reporter_id);
CREATE INDEX IF NOT EXISTS idx_dating_reports_reported
    ON dating.reports (reported_id);

-- dating.message_reads: user_id for cascade delete
CREATE INDEX IF NOT EXISTS idx_dating_message_reads_user
    ON dating.message_reads (user_id);
