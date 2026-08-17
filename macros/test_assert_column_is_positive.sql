{% test assert_column_is_positive(model, column_name) %}

SELECT
    {{ column_name }} AS invalid_value
FROM {{ model }}
WHERE {{ column_name }} < 0

{% endtest %}
