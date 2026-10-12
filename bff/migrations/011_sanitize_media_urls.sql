-- Migration 011: Sanitize third-party placeholder photo links to local/self-hosted /media/ paths
UPDATE dating.photos p
SET url = '/media/fakeusers/' || 
          CASE 
            WHEN pr.gender = 'woman' THEN 'women/' || (abs(hashtext(p.id::text)) % 99)::text || '.jpg'
            ELSE 'men/' || (abs(hashtext(p.id::text)) % 99)::text || '.jpg'
          END
FROM dating.profiles pr
WHERE p.user_id = pr.user_id
  AND (p.url LIKE '%pravatar.cc%' OR p.url LIKE '%picsum.photos%' OR p.url LIKE '%randomuser.me%');
