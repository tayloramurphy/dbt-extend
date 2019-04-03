{%- macro n_weeks_ago(n, tz=None) -%}
{%- set tz = var("dbt_extend:time_zone") if not tz else tz -%}
{%- set n = n|int -%}
{{ dbt_utils.date_trunc('week', dbt_utils.dateadd('week', -1 * n, dbt_extend.get_local_date(tz))) }}
{%- endmacro -%}