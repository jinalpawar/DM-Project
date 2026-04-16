SELECT 
	MODE() WITHIN GROUP (ORDER BY vaccination_stances.name) as "Most Common Stance on Vaccination", 
	users.country as "Country",
	COUNT(DISTINCT(user_vaccination_stances.user_id)) AS "User Count"
	FROM user_vaccination_stances
	JOIN vaccination_stances 
	ON user_vaccination_stances.vaccination_stance_id = vaccination_stances.vaccination_stance_id
	JOIN users
	ON user_vaccination_stances.user_id = users.user_id
	GROUP BY "Country"
	ORDER BY "User Count" DESC;
