{% macro this_week() %}date_trunc('week', {{ get_local_date() }} ){% endmacro %}
