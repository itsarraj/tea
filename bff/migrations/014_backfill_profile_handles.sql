-- 014_backfill_profile_handles.sql
-- Backfill empty or missing handles in dating.profiles using display_name

UPDATE dating.profiles
SET handle = lower(regexp_replace(display_name, '[^a-zA-Z0-9]', '', 'g'))
WHERE handle = '' OR handle IS NULL;
