{%- macro yesterday(tz=None) -%}
{% set tz = var("time_zone") if not tz else tz %}
dateadd('day', -1, {{ dbt_extend.get_local_date(tz) }} )
{%- endmacro -%}
