SELECT 
	groups.name as "Group Name", 
	COUNT(DISTINCT(user_groups.user_id)) as "Member Count"
	FROM user_groups 
	JOIN "groups" ON user_groups.group_id = groups.group_id
	GROUP BY groups.name
	ORDER BY "Member Count" DESC;
