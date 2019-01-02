{% macro n_weeks_away(n) %}date_trunc('week', dateadd('week', {{ n }}, {{ dbt_extend.get_local_date() }} )){% endmacro %}
