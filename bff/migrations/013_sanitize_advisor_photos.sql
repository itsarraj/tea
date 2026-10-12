-- Migration 013: Sanitize tea advisor photos in dating.photos to local /media/fakeusers paths
UPDATE dating.photos
SET url = CASE user_id
  WHEN '00000000-0000-0000-0000-000000000001'::uuid THEN '/media/fakeusers/women/1.jpg'
  WHEN '00000000-0000-0000-0000-000000000002'::uuid THEN '/media/fakeusers/men/2.jpg'
  WHEN '00000000-0000-0000-0000-000000000003'::uuid THEN '/media/fakeusers/women/3.jpg'
  WHEN '00000000-0000-0000-0000-000000000004'::uuid THEN '/media/fakeusers/men/4.jpg'
  WHEN '00000000-0000-0000-0000-000000000005'::uuid THEN '/media/fakeusers/women/5.jpg'
  WHEN '00000000-0000-0000-0000-000000000006'::uuid THEN '/media/fakeusers/men/6.jpg'
  WHEN '00000000-0000-0000-0000-000000000007'::uuid THEN '/media/fakeusers/men/7.jpg'
  WHEN '00000000-0000-0000-0000-000000000008'::uuid THEN '/media/fakeusers/women/8.jpg'
  WHEN '00000000-0000-0000-0000-000000000009'::uuid THEN '/media/fakeusers/women/9.jpg'
  WHEN '00000000-0000-0000-0000-000000000010'::uuid THEN '/media/fakeusers/women/10.jpg'
  ELSE url
END
WHERE url LIKE '%unsplash%';

-- General fallback if any other unsplash photos exist
UPDATE dating.photos p
SET url = '/media/fakeusers/' || 
          CASE 
            WHEN pr.gender = 'woman' THEN 'women/' || (abs(hashtext(p.id::text)) % 99)::text || '.jpg'
            ELSE 'men/' || (abs(hashtext(p.id::text)) % 99)::text || '.jpg'
          END
FROM dating.profiles pr
WHERE p.user_id = pr.user_id
  AND p.url LIKE '%unsplash%';
