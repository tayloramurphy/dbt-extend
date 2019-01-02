{% macro n_weeks_ago(n) %}date_trunc('week', dateadd('week', -1*{{ n }}, {{ get_local_date() }} )){% endmacro %}
