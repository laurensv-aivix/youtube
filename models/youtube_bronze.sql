{{- config(
        materialized = 'table',
        file_format = 'delta'
    )
-}}

{#- Cast columns to the correct data type -#}
SELECT
    {%- for column, datatype in youtube_raw_datatypes().items() %}
        cast(_c{{ loop.index - 1 }} AS {{ datatype -}} ) AS {{ column }}
        {{- "," if not loop.last else "" }}
    {%- endfor %}
FROM {{ ref('youtube_raw') }}
WHERE _c0 != 'index'
