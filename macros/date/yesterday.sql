{%- macro yesterday(tz=None) -%}
{% set tz = var("dbt_extend.time_zone") if not tz else tz %}
dateadd('day', -1, {{ dbt_extend.get_local_date(tz) }} )
{%- endmacro -%}
