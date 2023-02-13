
{% test test_positive_number(model, column_name) %}

{{ config(severity = 'warn') }}

SELECT *
FROM {{ model }}
WHERE {{ column_name }} < 0

{% endtest %}