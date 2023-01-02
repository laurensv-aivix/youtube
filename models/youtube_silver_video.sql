{{ config(
        materialized = 'table',
        file_format = 'delta'
    )
}}

-- Unique videos
SELECT DISTINCT
	videoId as id,
	videoPublished as date,
	videoViewCount as views,
	videoLikeCount as likes,
	videoDislikeCount as dislikes,
	videoCommentCount as comments,
	videoCategoryId as category_id,
	channelId as channel_id
FROM {{ ref('youtube_bronze') }}