-- 1. MOST COMMON INTERESTS OVERALL

SELECT i.name AS interest, COUNT(*) AS user_count
FROM user_interests ui
JOIN interests i ON ui.interest_id = i.interest_id
GROUP BY i.name
ORDER BY user_count DESC;


-- 2. TOP 10 GROUPS WITH THE HIGHEST NUMBER OF USERS
SELECT g.name AS group_name, COUNT(ug.user_id) AS num_users
FROM groups g
JOIN user_groups ug ON g.group_id = ug.group_id
GROUP BY g.group_id, g.name
ORDER BY num_users DESC
LIMIT 10;

--3.USERS WHO BELONG TO MORE GROUPS THAN THE AVERAGE USER
SELECT u.user_id, u.nickname, COUNT(ug.group_id) AS num_groups
FROM users u
JOIN user_groups ug ON u.user_id = ug.user_id
GROUP BY u.user_id, u.nickname
HAVING COUNT(ug.group_id) > (
    SELECT AVG(group_count)
    FROM (
        SELECT COUNT(*) AS group_count
        FROM user_groups
        GROUP BY user_id
    ) sub
)
ORDER BY num_groups DESC;

--4.USERS WHO DO NOT BELONG TO ANY GROUP
SELECT u.user_id, u.nickname, u.country
FROM users u
WHERE NOT EXISTS (
    SELECT 1
    FROM user_groups ug
    WHERE ug.user_id = u.user_id
);


--5.INTERESTS SHARED BY USERS FROM AT LEAST 5 DIFFERENT COUNTRIES
SELECT i.name as interest, COUNT(DISTINCT u.country) AS num_countries
FROM user_interests ui
JOIN interests i on ui.interest_id=i.interest_id
JOIN users u ON ui.user_id = u.user_id
WHERE u.country IS NOT NULL
GROUP BY i.name
HAVING COUNT(DISTINCT u.country) >= 5
ORDER BY num_countries DESC;
