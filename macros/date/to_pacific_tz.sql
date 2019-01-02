{%- macro to_pacific_tz(column) -%}convert_timezone('America/Los_Angeles', {{ column }})::timestamp_ntz{%- endmacro -%}
