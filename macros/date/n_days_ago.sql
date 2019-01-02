{% macro n_days_ago(n) %}dateadd('day', -1*{{ n }}, {{ get_local_time() }} ){% endmacro %}
