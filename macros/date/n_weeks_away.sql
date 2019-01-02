{% macro n_weeks_away(n) %}date_trunc('week', dateadd('week', {{ n }}, {{ get_local_date() }} )){% endmacro %}
