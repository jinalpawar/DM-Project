SELECT 
	u.user_id, u.nickname, u.country
	FROM users u
	WHERE NOT EXISTS (
	    SELECT 1
	    FROM user_groups ug
	    WHERE ug.user_id = u.user_id
	);
