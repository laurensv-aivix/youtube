{{- config(
        materialized = 'table',
        file_format = 'delta'
    )
-}}

with

cleaned_data as (
	select * from {{ ref('stg_youtube__raw') }}
),

videos as(
	select distinct
		videoId as id,
		videoPublished as date,
		videoViewCount as views,
		videoLikeCount as likes,
		videoDislikeCount as dislikes,
		videoCommentCount as comments,
		videoCategoryId as category_id,
		channelId as channel_id
	from cleaned_data
)

select * from videos
