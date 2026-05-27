SELECT 
	po.name as "Political Orientation", 
	ROUND(AVG(u.age)) AS "Average User Age",
	COUNT(DISTINCT(upo.user_id)) AS "User Count"
FROM 
	users AS u
	JOIN user_political_orientations AS upo ON 
		upo.user_id = u.user_id
	JOIN political_orientations AS po ON 
		upo.political_orientation_id = po.political_orientation_id
GROUP BY 
	po.name
HAVING 
	COUNT(DISTINCT(upo.user_id)) > 50
ORDER BY 
	"Average User Age"