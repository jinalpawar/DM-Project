--OPTIMIZED QUERIES

--1.(3)USERS WHO BELONG TO MORE GROUPS THAN THE AVERAGE USER
/*This query is expensive because it performs a JOIN between
users and user_groups, it uses GROUP BY on user_id and it includes a subquery 
that also groups user_groups by user_id. The optimization strategy consists
on creating an index on user_groups since this column is used in the JOIN, 
GROUP BY and in the subquery aggregation*/

---Create index to improve joins and grouping
CREATE INDEX idx_user_groups_user_id ON user_groups(user_id);

---Optimized query
SELECT u.user_id, u.nickname, COUNT(ug.group_id) AS num_groups
FROM users u
JOIN user_groups ug ON u.user_id = ug.user_id
GROUP BY u.user_id, u.nickname
HAVING COUNT (ug.group_id) > (SELECT AVG(group_count)
	FROM(SELECT COUNT(*) AS group_count FROM user_groups
	GROUP BY user_id) sub)
ORDER BY num_groups DESC;

--2.(5) INTERESTS SHARED BY USERS FROM AT LEAST 5 DIFFERENT COUNTRIES
/*This secon query is expensive as it joins 3 tables (user_interests, interests, users), it uses
COUNT(DISTINCT country), it filters by country IS NOT NULL, and it groups by interest.
In order to optimize, we will create indexes on the columns most used in: JOIN operations,
GROUP BY and filtering and aggregation*/

---Index for grouping and joining with interests:
CREATE INDEX idx_user_interests_interest_id ON user_interests (interest_id);

--- Index for joining with users
CREATE INDEX idx_user_interests_user_id ON user_interests(user_id);

---Index for filtering and distinct country counting
CREATE INDEX idx_users_country ON users(country);

---Optimized query:
SELECT i.name AS interests, COUNT(DISTINCT u.country) AS num_countries
FROM user_interests ui 
JOIN interests i ON ui.interest_id = i.interest_id
JOIN users u ON ui.user_id = u.user_id
WHERE u.country IS NOT NULL
GROUP BY i.name
HAVING COUNT (DISTINCT u.country) >= 5
ORDER BY num_countries DESC;
