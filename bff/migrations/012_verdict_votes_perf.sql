-- Migration 012: Performance index for post verdict votes aggregation
CREATE INDEX IF NOT EXISTS idx_post_votes_post_vote
    ON dating.post_votes (post_id, vote);
