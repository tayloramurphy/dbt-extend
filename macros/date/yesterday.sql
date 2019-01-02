{% macro yesterday() %}dateadd('day', -1, {{ get_local_date() }} ){% endmacro %}
