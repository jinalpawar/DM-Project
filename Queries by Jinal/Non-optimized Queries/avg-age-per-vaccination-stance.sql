SELECT 
	vaccination_stances.name AS "Stance on Vaccination", 
	AVG(users.age) AS "Average User Age", 
	COUNT(DISTINCT(user_vaccination_stances.user_id)) as "User Count" 
	FROM users 
	JOIN user_vaccination_stances ON user_vaccination_stances.user_id = users.user_id
	JOIN vaccination_stances ON user_vaccination_stances.vaccination_stance_id = vaccination_stances.vaccination_stance_id
	GROUP BY vaccination_stances.name
	ORDER BY "Average User Age"