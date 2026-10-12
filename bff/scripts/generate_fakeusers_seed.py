#!/usr/bin/env python3
"""
Generate an idempotent SQL seed file for Palora from apps/palora/fakeusers/data/final.json
(auth.users, dating.profiles, dating.photos, dating.feed_posts).

Usage:
    python3 apps/palora/bff/scripts/generate_fakeusers_seed.py
"""

import json
import random
import re
from datetime import datetime, timezone

IN_FILE = "apps/palora/fakeusers/data/final.json"
OUT_FILE = "apps/palora/bff/scripts/seed_fakeusers.sql"

PALORA_INTERESTS = [
    "⚽️ Football",
    "🍃 Nature",
    "📸 Photography",
    "🎵 Music",
    "✍🏻 Writing",
    "🗣 Language",
    "👗 Fashion",
    "🏝 Travel",
    "💪 Gym & Fitness",
    "🙂 People",
]

BIOS = [
    "Product designer by day, indie concert hunter by night.",
    "Always in search of the best specialty coffee and quiet reading nooks.",
    "Weekend road trips, film photography, and spicy street food.",
    "Marathon training in progress. Will run for good pastries.",
    "Architect obsessed with brutalist buildings, house plants, and jazz vinyl.",
    "Bookstore hoarder, pottery amateur, and golden retriever parent.",
    "Learning guitar and cooking regional curries from scratch.",
    "Tech startup dev. Passionate about open-source, bouldering, and board games.",
    "Med researcher who loves scuba diving, museums, and chai stalls.",
    "Filmmaker & visual artist. Let's debate A24 movies over boba.",
    "Yoga practitioner, tea snob, and amateur rooftop gardener.",
    "Badminton player, sourdough baker, and trivia night enthusiast.",
    "Illustrator exploring watercolor and city sketching on weekends.",
    "Data scientist with a weak spot for dog memes and Sunday morning hikes.",
    "DJ on weekends, foodie all week. Tell me your comfort meal.",
    "Software engineer, boba addict, and weekend hiker.",
    "Lover of old jazz records, thrift shops, and spontaneous road trips.",
    "Obsessed with Japanese cuisine, sourdough experiments, and photography.",
    "Here to meet interesting minds, share stories, and explore the city.",
    "Casual gamer, dog enthusiast, and sunset chaser.",
]

FEED_PROMPTS = [
    ("friends", "travel", "What is one city or country you would move to tomorrow with zero hesitation?"),
    ("partner", "music", "What song or artist has defined your last 6 months?"),
    ("friends", "food", "Late night street food or Sunday brunch? Drop your go-to order."),
    ("partner", "lifestyle", "Describe your perfect cozy evening at home in three words."),
    ("friends", "fitness", "Any morning runners or bouldering fans looking for a weekend buddy?"),
    ("partner", "creative", "What piece of art, cinema, or literature completely blew your mind?"),
    ("friends", "nature", "Sunrise hike or sunset by the ocean?"),
    ("partner", "philosophy", "What is an underrated quality you cherish in friends and partners?"),
    ("friends", "language", "What word in another language has no English translation but should?"),
    ("partner", "dating", "Spontaneous adventures or planned dinner dates? Which one wins?"),
    ("friends", "sports", "Anyone up for weekly badminton, tennis, or padel games in the city?"),
    ("partner", "travel", "Window seat or aisle seat? And what is your best travel story?"),
]

def clean_sql(val: str) -> str:
    return val.replace("'", "''")

def main():
    print(f"Reading fakeusers from {IN_FILE}...")
    with open(IN_FILE, "r", encoding="utf-8") as f:
        users = json.load(f)
    print(f"Loaded {len(users)} fake users.")

    lines = []
    lines.append("-- ===========================================================================")
    lines.append("-- Palora Seed: 200+ Fake Users from apps/palora/fakeusers")
    lines.append(f"-- Generated on: {datetime.now(timezone.utc).isoformat()}")
    lines.append(f"-- Total users: {len(users)}")
    lines.append("-- Password for all accounts: demo1234")
    lines.append("-- Idempotent: ON CONFLICT updates existing profiles")
    lines.append("-- ===========================================================================")
    lines.append("")
    lines.append("CREATE EXTENSION IF NOT EXISTS \"pgcrypto\";")
    lines.append("")
    lines.append("DO $$")
    lines.append("DECLARE")
    lines.append("  u_id UUID;")
    lines.append("BEGIN")

    seen_emails = set()

    for idx, u in enumerate(users, start=1):
        first = (u.get("first_name") or "User").strip().title()
        last = (u.get("last_name") or f"{idx}").strip().title()
        full_name = f"{first} {last}".strip()
        username = (u.get("username") or f"user{idx}").strip()

        # Clean ASCII email
        raw_email = (u.get("email") or f"{username}@palora.fake").strip().lower()
        if re.match(r"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$", raw_email) and not re.search(r"[^\x00-\x7F]", raw_email):
            safe_email = raw_email
        else:
            safe_email = f"{re.sub(r'[^a-z0-9._]', '', username.lower()) or f'fakeuser{idx}'}@palora.fake"

        if safe_email in seen_emails or safe_email.startswith("."):
            safe_email = f"fake.{idx}.{username.lower()}@palora.fake"
        seen_emails.add(safe_email)

        gender_raw = (u.get("gender") or "female").lower()
        gender = "woman" if gender_raw == "female" else "man"

        # Birth date: normalize to ages 21 to 33 (1993..2005) so profiles stay in active dating range
        ts = u.get("birthdate")
        if ts and isinstance(ts, (int, float)):
            try:
                dt = datetime.fromtimestamp(ts, tz=timezone.utc)
                year = max(1993, min(2005, dt.year))
                month = dt.month
                day = min(dt.day, 28)
            except Exception:
                year = random.randint(1994, 2004)
                month = random.randint(1, 12)
                day = random.randint(1, 28)
        else:
            year = random.randint(1994, 2004)
            month = random.randint(1, 12)
            day = random.randint(1, 28)
        birthday_str = f"{year:04d}-{month:02d}-{day:02d}"

        # City / Location
        loc = u.get("location") or {}
        raw_city = (loc.get("city") or "Bengaluru").strip().title()
        # Clean non-ascii if needed
        if re.search(r"[^\x00-\x7F]", raw_city) or len(raw_city) < 2:
            raw_city = random.choice(["Bengaluru", "Indiranagar", "Koramangala", "Whitefield", "HSR Layout", "Jayanagar", "Bengaluru"])

        lat = round(12.9716 + random.uniform(-0.14, 0.14), 4)
        lng = round(77.5946 + random.uniform(-0.14, 0.14), 4)

        looking_for = "ARRAY['man']::text[]" if gender == "woman" else "ARRAY['woman']::text[]"
        if random.random() < 0.25:
            looking_for = "ARRAY['woman','man']::text[]"

        intent = random.choices(["both", "partner", "friends"], weights=[0.55, 0.25, 0.20])[0]
        interests_sample = random.sample(PALORA_INTERESTS, k=random.randint(2, 4))
        interests_sql = "ARRAY[" + ", ".join(f"'{clean_sql(i)}'" for i in interests_sample) + "]::text[]"
        bio = clean_sql(random.choice(BIOS))

        # Photo resolution
        pic = u.get("picture") or ""
        if pic.startswith("algolia/"):
            # Served locally from BFF /media/fakeusers/algolia/...
            photo_0 = f"http://localhost:8000/media/fakeusers/{pic}"
        elif pic:
            # High-resolution randomuser portrait
            photo_0 = f"https://randomuser.me/api/portraits/{pic}"
        else:
            photo_0 = f"https://i.pravatar.cc/600?img={(idx % 70) + 1}"

        photo_1 = f"https://picsum.photos/seed/palora-fakeuser-{idx}-1/600/800"
        photo_2 = f"https://picsum.photos/seed/palora-fakeuser-{idx}-2/600/800"

        clean_name = clean_sql(full_name)
        clean_city = clean_sql(raw_city)

        lines.append(f"  -- FakeUser #{idx}: {clean_name} ({safe_email})")
        lines.append(f"  INSERT INTO auth.users (email, password_hash, name, email_verified, birthday)")
        lines.append(f"  VALUES ('{safe_email}', crypt('demo1234', gen_salt('bf', 10)), '{clean_name}', TRUE, DATE '{birthday_str}')")
        lines.append(f"  ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name, birthday = EXCLUDED.birthday")
        lines.append(f"  RETURNING id INTO u_id;")
        lines.append("")
        lines.append(f"  INSERT INTO dating.profiles (")
        lines.append(f"    user_id, display_name, gender, looking_for, intent, birthday,")
        lines.append(f"    city, country, lat, lng, about, interests, onboarding_complete, last_active_at")
        lines.append(f"  ) VALUES (")
        lines.append(f"    u_id, '{clean_name}', '{gender}', {looking_for}, '{intent}', DATE '{birthday_str}',")
        lines.append(f"    '{clean_city}', 'India', {lat}, {lng}, '{bio}', {interests_sql}, TRUE,")
        lines.append(f"    NOW() - (random() * interval '96 hours')")
        lines.append(f"  ) ON CONFLICT (user_id) DO UPDATE SET")
        lines.append(f"    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,")
        lines.append(f"    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,")
        lines.append(f"    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;")
        lines.append("")
        lines.append(f"  -- Photos for #{idx}")
        lines.append(f"  INSERT INTO dating.photos (user_id, url, position)")
        lines.append(f"  VALUES (u_id, '{clean_sql(photo_0)}', 0)")
        lines.append(f"  ON CONFLICT DO NOTHING;")
        lines.append(f"  INSERT INTO dating.photos (user_id, url, position)")
        lines.append(f"  VALUES (u_id, '{photo_1}', 1)")
        lines.append(f"  ON CONFLICT DO NOTHING;")
        lines.append(f"  INSERT INTO dating.photos (user_id, url, position)")
        lines.append(f"  VALUES (u_id, '{photo_2}', 2)")
        lines.append(f"  ON CONFLICT DO NOTHING;")
        lines.append("")

        # Add feed prompt for some users (~15% of users)
        if idx % 6 == 0:
            prompt_mode, prompt_cat, prompt_q = random.choice(FEED_PROMPTS)
            lines.append(f"  -- Feed post by {clean_name}")
            lines.append(f"  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)")
            lines.append(f"  SELECT u_id, '{prompt_mode}', '{prompt_cat}', '{clean_sql(prompt_q)}', NOW() - interval '{random.randint(1, 72)} hours'")
            lines.append(f"  WHERE NOT EXISTS (SELECT 1 FROM dating.feed_posts WHERE author_id = u_id AND question = '{clean_sql(prompt_q)}');")
            lines.append("")

    lines.append("END $$;")
    lines.append("")

    content = "\n".join(lines)
    with open(OUT_FILE, "w", encoding="utf-8") as f:
        f.write(content)
    print(f"Generated {OUT_FILE} ({len(content)} bytes)")

if __name__ == "__main__":
    main()
