SELECT 
	u.country as "Country",
	MODE() WITHIN GROUP (ORDER BY po.name) as "Most Common Political Orientation",
	COUNT(DISTINCT(upo.user_id)) AS "User Count"
FROM 
	user_political_orientations AS upo
JOIN 
	political_orientations AS po ON 
	upo.political_orientation_id = po.political_orientation_id
JOIN 
	users AS u ON 
	upo.user_id = u.user_id
GROUP BY 
	"Country"
ORDER BY 
	"User Count" DESC;
