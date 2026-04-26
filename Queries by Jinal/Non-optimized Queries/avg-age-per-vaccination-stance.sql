WITH male_users AS (
		SELECT 
			ROUND(AVG(u.age)) AS "age",
			vs.vaccination_stance_id,
			COUNT(DISTINCT(uvs.user_id)) AS "user_count"
		FROM
			users AS u
		JOIN
			user_vaccination_stances AS uvs ON
			uvs.user_id = u.user_id
		JOIN
			vaccination_stances AS vs ON
			vs.vaccination_stance_id = uvs.vaccination_stance_id
		WHERE
			u.gender = 'Man'
		GROUP BY
			vs.vaccination_stance_id
), female_users AS (
		SELECT 
			ROUND(AVG(u.age)) AS "age",
			vs.vaccination_stance_id,
			COUNT(DISTINCT(uvs.user_id)) AS "user_count"
		FROM
			users AS u
		JOIN
			user_vaccination_stances AS uvs ON
			uvs.user_id = u.user_id
		JOIN
			vaccination_stances AS vs ON
			vs.vaccination_stance_id = uvs.vaccination_stance_id
		WHERE
			u.gender = 'Woman'
		GROUP BY
			vs.vaccination_stance_id
)
SELECT 
	vs.name,
	male_users.age AS "Average Male User Age",
	male_users.user_count AS "Male User Count",
	female_users.age AS "Average Female User Age",
	female_users.user_count AS "Female User Count"
FROM 
	vaccination_stances AS vs
JOIN male_users ON
	male_users.vaccination_stance_id = vs.vaccination_stance_id
JOIN female_users ON
	female_users.vaccination_stance_id = vs.vaccination_stance_id
	