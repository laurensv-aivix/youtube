{{ config(
        materialized = 'table',
        file_format = 'delta'
    )
}}

{%- set column_datatypes = {
        "index": "bigint",
        "`totalviews/channelelapsedtime`": "double",
        "channelId": "char(24)",
        "videoCategoryId": "int",
        "channelViewCount": "bigint",
        "`likes/subscriber`": "double",
        "`views/subscribers`": "double",
        "videoCount": "int",
        "subscriberCount": "bigint",
        "videoId": "char(11)",
        "`dislikes/views`": "double",
        "channelelapsedtime": "bigint",
        "`comments/subscriber`": "double",
        "`likes/views`": "double",
        "channelCommentCount": "bigint",
        "videoViewCount": "bigint",
        "`likes/dislikes`": "double",
        "`comments/views`": "double",
        "`totvideos/videocount`": "double",
        "elapsedtime": "bigint",
        "videoLikeCount": "bigint",
        "videoDislikeCount": "bigint",
        "`dislikes/subscriber`": "double",
        "`totviews/totsubs`": "double",
        "`views/elapsedtime`": "double",
        "videoPublished": "date",
        "VideoCommentCount": "bigint"
    }
-%}

SELECT
    {#- Cast columns to the correct data type #}
    {% for column, datatype in column_datatypes.items() -%}
        cast(_c{{ loop.index - 1 }} AS {{ datatype -}} ) AS {{ column }}
        {{- "," if not loop.last else "" }}
    {% endfor %}
FROM {{ ref('youtube_raw') }}
WHERE _c0 != 'index'