{% snapshot views_snapshot %}

{{
    config(
      target_database='laurens_db',
      target_schema='snapshot_silver_video_views',
      unique_key='id',

      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select * from {{ ref('youtube_silver_video') }}

{% endsnapshot %}