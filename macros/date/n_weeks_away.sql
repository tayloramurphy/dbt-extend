{%- macro n_weeks_away(n, tz=None) -%}
{% set tz = var("time_zone") if not tz else tz %}
date_trunc('week', dateadd('week', {{ n }}, {{ dbt_extend.get_local_date(tz) }} ))
{%- endmacro -%}
