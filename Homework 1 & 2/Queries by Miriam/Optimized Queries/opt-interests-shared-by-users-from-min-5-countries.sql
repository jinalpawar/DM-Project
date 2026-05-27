---Index for grouping and joining with interests:
CREATE INDEX idx_user_interests_interest_id ON user_interests (interest_id);

--- Index for joining with users
CREATE INDEX idx_user_interests_user_id ON user_interests(user_id);

---Index for filtering and distinct country counting
CREATE INDEX idx_users_country ON users(country);

---Optimized query:
SELECT 
	i.name AS interests, 
	COUNT(DISTINCT u.country) AS num_countries
	FROM user_interests ui 
	JOIN interests i ON ui.interest_id = i.interest_id
	JOIN users u ON ui.user_id = u.user_id
	WHERE u.country IS NOT NULL
	GROUP BY i.name
	HAVING COUNT (DISTINCT u.country) >= 5
	ORDER BY num_countries DESC;