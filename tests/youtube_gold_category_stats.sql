

SELECT
	category.name,
	count(*) as video_count,
	avg(video.views) as avg_views,
	cast(round(sum(video.views) / sum(video.likes), 0) as int) as views_for_like,
	cast(round(sum(video.views) / sum(video.dislikes), 0) as int) as views_for_dislike,
	round(sum(video.likes) / sum(video.dislikes), 1) as likes_ratio,
	cast(round(sum(video.views) / sum(video.comments), 0) as int) as views_for_comment
FROM laurens_db.youtube_silver_video video
LEFT JOIN laurens_db.youtube_categories category
	ON video.category_id = category.id
GROUP BY category.name
HAVING count(*) > 1000
ORDER BY likes_ratio