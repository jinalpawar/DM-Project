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