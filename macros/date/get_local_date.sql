{%- macro get_local_date(tz=None) -%}
{% set tz = var("dbt_extend:time_zone") if not tz else tz %}
{{ dbt_extend.get_local_time(tz) }}::date
{%- endmacro -%}
