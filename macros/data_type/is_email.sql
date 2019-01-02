{%- macro is_email(val) -%}
case when {{ val }} like '%_@__%.__%' then true else false end
{%- endmacro -%}