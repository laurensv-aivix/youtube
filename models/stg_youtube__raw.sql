{{- config(
        materialized = 'view',
        file_format = 'delta'
    )
-}}

with

raw_data as (
    select * from {{ source('source_db', 'source_youtube__raw') }}
),

-- Cast columns to the correct data type
cast_schema as (
    select
        {%- for column, datatype in youtube_raw_datatypes().items() %}
            cast(_c{{ loop.index - 1 }} AS {{ datatype -}} ) AS {{ column }}
            {{- "," if not loop.last else "" }}
        {%- endfor %}
    from raw_data
    where _c0 != 'index'
)

select * from cast_schema