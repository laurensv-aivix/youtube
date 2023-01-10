
{{ config(severity = 'warn') }}

SELECT *
FROM {{ ref("youtube_silver_video") }}
WHERE
		views < 0
	OR
		likes < 0
	OR
		dislikes < 0
	OR
		comments < 0

