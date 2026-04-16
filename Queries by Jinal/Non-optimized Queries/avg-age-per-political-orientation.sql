SELECT 
	political_orientations.name as "Political Orientation", 
	AVG(users.age) AS "Average User Age",
	COUNT(DISTINCT(user_political_orientations.user_id)) as "User Count"
	FROM users 
	JOIN user_political_orientations ON user_political_orientations.user_id = users.user_id
	JOIN political_orientations ON user_political_orientations.political_orientation_id = political_orientations.political_orientation_id
	GROUP BY political_orientations.name
	ORDER BY "Average User Age"