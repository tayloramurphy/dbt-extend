{%- macro to_local_tz(column, tz='America/Los_Angeles') -%}convert_timezone('{{ tz }}', {{ column }})::timestamp_ntz{%- endmacro -%}
