{%- macro get_local_time(tz=None) -%}
{% set tz = var("dbt_extend.time_zone") if not tz else tz %}
{{ dbt_extend.to_local_tz('current_timestamp::timestamp_ntz', tz) }}
{%- endmacro -%}