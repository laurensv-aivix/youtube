{{ config(
        materialized = 'table',
        file_format = 'delta'
    )
}}

with

-- Import
videos as (
	select * from {{ ref("dim_youtube__videos") }}
),

categories as (
	select * from {{ ref("youtube_categories") }}
),

-- Logical

final as (
	select
		max(categories.name) as category_name,
		count(*) as video_count,
		avg(videos.views) as video_views_avg,
		cast(round(sum(videos.views) / sum(videos.likes), 0) as int) as video_like_per_view,
		cast(round(sum(videos.views) / sum(videos.dislikes), 0) as int) as video_dislike_per_view,
		round(sum(videos.likes) / sum(videos.dislikes), 1) as video_likes_ratio,
		cast(round(sum(videos.views) / sum(videos.comments), 0) as int) as video_comments_per_view
	from videos
	left join categories
		on videos.category_id = categories.id
	group by categories.name
	having count(*) > 1000
	order by video_likes_ratio
)

-- Output

select * from final

