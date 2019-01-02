{% macro get_local_date(tz='America/Los_Angeles') %}{{ get_local_time(tz) }}::date{% endmacro %}
