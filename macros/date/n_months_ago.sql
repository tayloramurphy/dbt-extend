{% macro n_months_ago(n) %}date_trunc('month', dateadd('month', -1*{{ n }}, {{ dbt_extend.get_local_date() }} )){% endmacro %}
