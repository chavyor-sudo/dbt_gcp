{% macro convert_usd_to_ils(column_name, exchange_rate=3.6) %}
    round(cast({{ column_name }} as numeric) * {{ exchange_rate }}, 2)
{% endmacro %}
