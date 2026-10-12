-- Migration 010: Seed Photos for Tea Dating Advisors and Users
-- Provides authentic avatar image URLs for all pre-seeded tea accounts.

INSERT INTO dating.photos (id, user_id, url, position)
VALUES
  -- 1. Marina Jose (Top Advisor - New York)
  (gen_random_uuid(), '00000000-0000-0000-0000-000000000001'::uuid, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=600&auto=format&fit=crop&q=80', 0),
  -- 2. Jack James (Senior Advisor - London)
  (gen_random_uuid(), '00000000-0000-0000-0000-000000000002'::uuid, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=600&auto=format&fit=crop&q=80', 0),
  -- 3. Sylvia Agostino (Tea Master - Rome)
  (gen_random_uuid(), '00000000-0000-0000-0000-000000000003'::uuid, 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=600&auto=format&fit=crop&q=80', 0),
  -- 4. Williams K (Dating Sage - Chicago)
  (gen_random_uuid(), '00000000-0000-0000-0000-000000000004'::uuid, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=600&auto=format&fit=crop&q=80', 0),
  -- 5. Jessica Cole (Dating Strategist - Toronto)
  (gen_random_uuid(), '00000000-0000-0000-0000-000000000005'::uuid, 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=600&auto=format&fit=crop&q=80', 0),
  -- 6. Edward Miller (Advisor - Berlin)
  (gen_random_uuid(), '00000000-0000-0000-0000-000000000006'::uuid, 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=600&auto=format&fit=crop&q=80', 0),
  -- 7. Michael
  (gen_random_uuid(), '00000000-0000-0000-0000-000000000007'::uuid, 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=600&auto=format&fit=crop&q=80', 0),
  -- 8. Maria Jones
  (gen_random_uuid(), '00000000-0000-0000-0000-000000000008'::uuid, 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=600&auto=format&fit=crop&q=80', 0),
  -- 9. Libby Liz
  (gen_random_uuid(), '00000000-0000-0000-0000-000000000009'::uuid, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=600&auto=format&fit=crop&q=80', 0),
  -- 10. Emily Johnson
  (gen_random_uuid(), '00000000-0000-0000-0000-000000000010'::uuid, 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=600&auto=format&fit=crop&q=80', 0)
ON CONFLICT DO NOTHING;
