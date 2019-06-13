{%- macro to_local_tz(column, target_tz=None, source_tz=None) -%}
{%- set target_tz = var("dbt_extend:time_zone") if not target_tz else target_tz -%}
{%- if not source_tz -%}
convert_timezone('{{ target_tz }}', {{ column }})::{{ dbt_utils.type_timestamp() }}
{%- else -%}
convert_timezone('{{ source_tz }}', '{{ target_tz }}', {{ column }})::{{ dbt_utils.type_timestamp() }}
{%- endif -%}
{%- endmacro -%}