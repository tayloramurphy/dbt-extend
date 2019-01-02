{%- macro this_week(tz=None) -%}
{% set tz = var("dbt_extend.time_zone") if not tz else tz %}
date_trunc('week', {{ dbt_extend.get_local_date(tz) }} )
{%- endmacro -%}
