{% macro n_days_ago(n) %}dateadd('day', -1*{{ n }}, {{ dbt_extend.get_local_time() }} ){% endmacro %}
