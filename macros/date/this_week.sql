{% macro this_week() %}date_trunc('week', {{ dbt_extend.get_local_date() }} ){% endmacro %}
