-- Dating signup fields on auth.users
ALTER TABLE auth.users
  ADD COLUMN IF NOT EXISTS birthday DATE,
  ADD COLUMN IF NOT EXISTS phone TEXT;
