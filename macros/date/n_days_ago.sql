{%- macro n_days_ago(n, tz=None) -%}
{% set tz = var("dbt_extend.time_zone") if not tz else tz %}
dateadd('day', -1*{{ n }}, {{ dbt_extend.get_local_time(tz) }} )
{%- endmacro -%}
