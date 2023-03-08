
{{- config(
        severity = 'warn',
        store_failures = true
    )
-}}

with

videos as (
	select * from {{ ref("dim_youtube__videos") }}
),

negative_stats as (
	select *
	from videos
	where
			views < 0
		or
			likes < 0
		or
			dislikes < 0
		or
			comments < 0
)

select * from negative_stats
