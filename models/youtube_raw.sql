{{ config(
        materialized = 'table',
        file_format = 'delta'
    )
}}

SELECT *
FROM csv.`/FileStore/tables/DBT/YouTubeDataset_withChannelElapsed.csv`