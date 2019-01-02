{%- macro n_months_ago(n, tz=None) -%}
{% set tz = var("dbt_extend.time_zone") if not tz else tz %}
date_trunc('month', dateadd('month', -1*{{ n }}, {{ dbt_extend.get_local_date(tz) }} ))
{%- endmacro -%}
