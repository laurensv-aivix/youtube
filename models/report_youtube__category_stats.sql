{{ config(
        materialized = 'table',
        file_format = 'delta'
    )
}}

with

-- Import
videos as (
	select * from {{ ref("youtube_silver_video") }}
),

categories as (
	select * from {{ ref("youtube_categories") }}
),

-- Logical

aggregated as (
	select
		category.name as category_name,
		count(*) as video_count,
		avg(video.views) as video_views_avg,
		cast(round(sum(video.views) / sum(video.likes), 0) as int) as video_like_per_view,
		cast(round(sum(video.views) / sum(video.dislikes), 0) as int) as video_dislike_per_view,
		round(sum(video.likes) / sum(video.dislikes), 1) as video_likes_ratio,
		cast(round(sum(video.views) / sum(video.comments), 0) as int) as video_comments_per_view
	from videos
	left join categories
		on video.category_id = category.id
),

final as (
	select *
	from aggregated
	group by category.name
	having count(*) > 1000
	order by likes_ratio
)

select * from final

