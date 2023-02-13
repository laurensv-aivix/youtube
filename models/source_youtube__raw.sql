{{ config(
        materialized = 'table',
        file_format = 'delta'
    )
}}

with

source as (
    select *
    from csv.`/FileStore/tables/DBT/YouTubeDataset_withChannelElapsed.csv`
)

select * from source