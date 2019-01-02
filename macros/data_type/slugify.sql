{%- macro slugify(col) -%}
replace(lower({{ col }}), ' ', '-')
{%- endmacro -%}