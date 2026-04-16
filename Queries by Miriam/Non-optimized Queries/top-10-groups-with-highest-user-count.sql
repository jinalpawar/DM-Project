SELECT 
	g.name AS group_name, COUNT(ug.user_id) AS num_users
	FROM groups g
	JOIN user_groups ug ON g.group_id = ug.group_id
	GROUP BY g.group_id, g.name
	ORDER BY num_users DESC
	LIMIT 10;