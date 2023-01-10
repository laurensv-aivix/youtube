{% test test_date_range(
    model,
    column_name,
    min_date="0001-01-01",
    max_date="9999-31-12")
%}

SELECT *
FROM {{ model }}
WHERE
        {{ column_name }} < date("{{ min_date }}")
    OR
        {{ column_name }} > date("{{ max_date }}")

{% endtest %}

