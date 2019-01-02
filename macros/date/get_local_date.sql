{% macro get_local_date(tz='America/Los_Angeles') %}{{ dbt_extend.get_local_time(tz) }}::date{% endmacro %}
