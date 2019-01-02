{% macro yesterday() %}dateadd('day', -1, {{ dbt_extend.get_local_date() }} ){% endmacro %}
