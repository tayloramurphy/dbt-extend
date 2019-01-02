{%- macro to_local_tz(column, tz=None) -%}
{% set tz = var("time_zone") if not tz else tz %}
convert_timezone('{{ tz }}', {{ column }})::timestamp_ntz
{%- endmacro -%}