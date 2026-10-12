-- Friendzy: record which mode (friends / dating) a swipe was made in.
-- Matches and conversations stay a single table; the mode is informational.
ALTER TABLE dating.swipes
  ADD COLUMN IF NOT EXISTS mode TEXT;

DO $$ BEGIN
  ALTER TABLE dating.swipes
    ADD CONSTRAINT swipes_mode_chk CHECK (mode IS NULL OR mode IN ('friends','partner'));
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- Backfill demo swipes from the swiper's intent so the data reads naturally.
UPDATE dating.swipes s
SET mode = CASE p.intent WHEN 'partner' THEN 'partner' ELSE 'friends' END
FROM dating.profiles p
WHERE p.user_id = s.from_user_id AND s.mode IS NULL;
