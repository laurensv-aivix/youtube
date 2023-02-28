{{- config(
        materialized = 'table',
        file_format = 'delta'
    )
-}}

with

cleaned_data as (
	select * from {{ ref('stg_youtube__raw') }}
),

categories as (
	select
		channelId as id,
		max(videoCount) as videos,
		max(subscriberCount) as subscribers,
		max(channelViewCount) as views,
		max(channelCommentCount) as comments
	from cleaned_data
	group by channelId
)

select * from categories