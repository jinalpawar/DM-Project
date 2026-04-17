SELECT 
	u.country as "Country",
	MODE() WITHIN GROUP (ORDER BY vs.name) as "Most Common Stance on Vaccination", 
	COUNT(DISTINCT(uvs.user_id)) AS "User Count"
FROM 
	user_vaccination_stances AS uvs
JOIN 
	vaccination_stances AS vs ON 
	uvs.vaccination_stance_id = vs.vaccination_stance_id
JOIN 
	users AS u ON 
	uvs.user_id = u.user_id
GROUP BY 
	"Country"
ORDER BY 
	"User Count" DESC;
