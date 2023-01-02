{{ config(
        materialized = 'table',
        file_format = 'delta'
    )
}}

SELECT
	channelId as id,
	max(videoCount) as videos,
	max(subscriberCount) as subscribers,
	max(channelViewCount) as views,
	max(channelCommentCount) as comments
FROM {{ ref('youtube_bronze') }}
GROUP BY channelId
