SELECT 
	users.country as "Country",
	MODE() WITHIN GROUP (ORDER BY political_orientations.name) as "Most Common Political Orientation",
	COUNT(DISTINCT(user_political_orientations.user_id)) AS "User Count"
	FROM user_political_orientations 
	JOIN political_orientations 
	ON user_political_orientations.political_orientation_id = political_orientations.political_orientation_id
	JOIN users
	ON user_political_orientations.user_id = users.user_id
	GROUP BY "Country"
	ORDER BY "User Count" DESC;
