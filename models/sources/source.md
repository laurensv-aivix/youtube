{% docs source %}

# Source data

The source data is a CSV file. The source data is materialized into the data warehouse by source_youtube__raw.sql.
The resulting table is configured as a source in sources.yml.

Order:
- source_youtube__raw.sql loads the source data into the Data warehouse
- sources.yml sets the table from the previous step as a source
- stg_youtube__raw.sql uses the source through the function: `source('schema', 'table')`

{% enddocs %}