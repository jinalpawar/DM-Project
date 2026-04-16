SELECT i.name AS interest, COUNT(*) AS user_count
FROM user_interests ui
JOIN interests i ON ui.interest_id = i.interest_id
GROUP BY i.name
ORDER BY user_count DESC;

