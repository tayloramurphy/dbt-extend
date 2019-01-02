{%- macro this_week(tz=None) -%}
{% set tz = var("time_zone") if not tz else tz %}
date_trunc('week', {{ dbt_extend.get_local_date(tz) }} )
{%- endmacro -%}
