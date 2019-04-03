{%- macro to_local_tz(column, tz=None) -%}
{% set tz = var("dbt_extend:time_zone") if not tz else tz %}
convert_timezone('{{ tz }}', {{ column }})::{{dbt_utils.type_timestamp()}}
{%- endmacro -%}