SELECT 
	i.name as interest, 
	COUNT(DISTINCT u.country) AS num_countries
	FROM user_interests ui
	JOIN interests i on ui.interest_id=i.interest_id
	JOIN users u ON ui.user_id = u.user_id
	WHERE u.country IS NOT NULL
	GROUP BY i.name
	HAVING COUNT(DISTINCT u.country) >= 5
	ORDER BY num_countries DESC;