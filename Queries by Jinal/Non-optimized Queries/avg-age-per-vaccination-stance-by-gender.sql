SELECT 
  vs.name,
  (
    SELECT 
      ROUND(AVG(u.age)) AS "age"
    FROM
      users AS u
    JOIN
      user_vaccination_stances AS uvs ON
      uvs.user_id = u.user_id
    WHERE
      u.gender = 'Man' AND uvs.vaccination_stance_id = vs.vaccination_stance_id
  ) AS "Average Male User Age",
  (
    SELECT 
      COUNT(DISTINCT(uvs.user_id))
    FROM
      users AS u
    JOIN
      user_vaccination_stances AS uvs ON
      uvs.user_id = u.user_id
    WHERE
      u.gender = 'Man' AND uvs.vaccination_stance_id = vs.vaccination_stance_id
  ) "Male User Count",
  (
    SELECT 
      ROUND(AVG(u.age)) AS "age"
    FROM
      users AS u
    JOIN
      user_vaccination_stances AS uvs ON
      uvs.user_id = u.user_id
    WHERE
      u.gender = 'Woman' AND uvs.vaccination_stance_id = vs.vaccination_stance_id
  ) AS "Average Female User Age",
  (
    SELECT 
      COUNT(DISTINCT(uvs.user_id))
    FROM
      users AS u
    JOIN
      user_vaccination_stances AS uvs ON
      uvs.user_id = u.user_id
    WHERE
      u.gender = 'Woman' AND uvs.vaccination_stance_id = vs.vaccination_stance_id
  ) AS "Female User Count"
FROM 
  vaccination_stances AS vs;
