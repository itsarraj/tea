#!/usr/bin/env python3
"""
Fetch 100+ users from https://free-api-backend.vercel.app/users and generate
an idempotent SQL seed file for Palora (auth.users, dating.profiles, dating.photos, dating.feed_posts).

Usage:
    python3 apps/palora/bff/scripts/generate_free_api_seed.py
"""

import json
import random
import re
import urllib.request
from datetime import datetime, timezone

OUT_FILE = "apps/palora/bff/scripts/seed_free_api_users.sql"

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
]

FEED_PROMPTS = [
    ("friends", "travel", "If you could catch a flight to anywhere right now, where would you go?"),
    ("partner", "music", "What was the very first album that made you fall in love with music?"),
    ("friends", "food", "The best cafe or street food spot in town that nobody talks about?"),
    ("partner", "lifestyle", "What does your absolute ideal, completely unscheduled Sunday look like?"),
    ("friends", "fitness", "Morning workout person or night owl runner? How do you stay active?"),
    ("partner", "creative", "What book, movie, or song genuinely changed how you see things?"),
    ("friends", "nature", "Mountains, beaches, or quiet forest trails? Pick your sanctuary."),
    ("partner", "philosophy", "What is an unpopular opinion you are willing to defend forever?"),
    ("friends", "language", "If you could instantly speak any language fluently, which one and why?"),
    ("partner", "dating", "What makes a conversation instantly click for you?"),
]

def clean_sql(val: str) -> str:
    return val.replace("'", "''")

def fetch_users(target_count: int = 120):
    users = []
    seed = 1
    while len(users) < target_count and seed <= 20:
        url = f"https://free-api-backend.vercel.app/users?seed={seed}"
        try:
            req = urllib.request.Request(url, headers={"User-Agent": "Palora-Seeder/1.0"})
            with urllib.request.urlopen(req, timeout=10) as resp:
                data = json.loads(resp.read().decode("utf-8"))
                batch = data.get("data", [])
                users.extend(batch)
                print(f"Fetched seed={seed}: got {len(batch)} users (total: {len(users)})")
        except Exception as e:
            print(f"Error fetching seed={seed}: {e}")
        seed += 1
    return users[:target_count]

def main():
    print("Fetching mock users from free-api-backend...")
    raw_users = fetch_users(120)
    print(f"Total fetched: {len(raw_users)}")

    lines = []
    lines.append("-- ===========================================================================")
    lines.append("-- Palora Seed: 100+ Mock Users from free-api-backend")
    lines.append(f"-- Generated on: {datetime.now(timezone.utc).isoformat()}")
    lines.append("-- Total users: " + str(len(raw_users)))
    lines.append("-- Password for all seeded accounts: demo1234")
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

    for idx, u in enumerate(raw_users, start=1):
        first = u.get("firstName") or "User"
        last = u.get("lastName") or f"{idx}"
        full_name = f"{first} {last}".strip()
        raw_email = (u.get("email") or f"{first.lower()}.{last.lower()}@palora.mock").lower()
        # Ensure clean unique ascii email
        safe_email = re.sub(r"[^a-z0-9._-]", "", raw_email)
        if not safe_email or safe_email in seen_emails or safe_email.startswith("."):
            safe_email = f"freeapi.{idx}.{first.lower()}@palora.mock"
        seen_emails.add(safe_email)

        gender_raw = (u.get("gender") or "female").lower()
        gender = "woman" if "female" in gender_raw or gender_raw == "woman" else "man"

        # Birth date: ages 21 to 32
        birth_year = random.randint(1994, 2005)
        birth_month = random.randint(1, 12)
        birth_day = random.randint(1, 28)
        birthday_str = f"{birth_year:04d}-{birth_month:02d}-{birth_day:02d}"

        # Geolocation around Bengaluru (12.9716, 77.5946) with jitter
        lat = round(12.9716 + random.uniform(-0.12, 0.12), 4)
        lng = round(77.5946 + random.uniform(-0.12, 0.12), 4)
        city = random.choice(["Bengaluru", "Indiranagar", "Koramangala", "Whitefield", "HSR Layout", "Jayanagar", "Bengaluru"])

        looking_for = "ARRAY['man']::text[]" if gender == "woman" else "ARRAY['woman']::text[]"
        if random.random() < 0.25:
            looking_for = "ARRAY['woman','man']::text[]"

        intent = random.choices(["both", "partner", "friends"], weights=[0.55, 0.25, 0.20])[0]
        interests_sample = random.sample(PALORA_INTERESTS, k=random.randint(2, 4))
        interests_sql = "ARRAY[" + ", ".join(f"'{clean_sql(i)}'" for i in interests_sample) + "]::text[]"
        bio = clean_sql(random.choice(BIOS))

        avatar_url = u.get("avatar") or f"https://i.pravatar.cc/600?img={idx % 70 + 1}"
        extra_photo_1 = f"https://picsum.photos/seed/palora-freeapi-{idx}-1/600/800"
        extra_photo_2 = f"https://picsum.photos/seed/palora-freeapi-{idx}-2/600/800"

        clean_name = clean_sql(full_name)
        clean_city = clean_sql(city)

        lines.append(f"  -- User #{idx}: {clean_name} ({safe_email})")
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
        lines.append(f"    NOW() - (random() * interval '72 hours')")
        lines.append(f"  ) ON CONFLICT (user_id) DO UPDATE SET")
        lines.append(f"    display_name = EXCLUDED.display_name, gender = EXCLUDED.gender, looking_for = EXCLUDED.looking_for,")
        lines.append(f"    intent = EXCLUDED.intent, birthday = EXCLUDED.birthday, city = EXCLUDED.city, lat = EXCLUDED.lat,")
        lines.append(f"    lng = EXCLUDED.lng, about = EXCLUDED.about, interests = EXCLUDED.interests, onboarding_complete = TRUE;")
        lines.append("")
        lines.append(f"  -- Photos for user #{idx}")
        lines.append(f"  INSERT INTO dating.photos (user_id, url, position)")
        lines.append(f"  VALUES (u_id, '{clean_sql(avatar_url)}', 0)")
        lines.append(f"  ON CONFLICT DO NOTHING;")
        lines.append(f"  INSERT INTO dating.photos (user_id, url, position)")
        lines.append(f"  VALUES (u_id, '{extra_photo_1}', 1)")
        lines.append(f"  ON CONFLICT DO NOTHING;")
        lines.append(f"  INSERT INTO dating.photos (user_id, url, position)")
        lines.append(f"  VALUES (u_id, '{extra_photo_2}', 2)")
        lines.append(f"  ON CONFLICT DO NOTHING;")
        lines.append("")

        # Add feed prompt for some users (~20% of users)
        if idx % 5 == 0:
            prompt_mode, prompt_cat, prompt_q = random.choice(FEED_PROMPTS)
            lines.append(f"  -- Feed post by {clean_name}")
            lines.append(f"  INSERT INTO dating.feed_posts (author_id, mode, category, question, created_at)")
            lines.append(f"  SELECT u_id, '{prompt_mode}', '{prompt_cat}', '{clean_sql(prompt_q)}', NOW() - interval '{random.randint(1, 48)} hours'")
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
