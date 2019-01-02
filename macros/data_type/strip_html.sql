{%- macro strip_html(col) -%}
trim(regexp_replace(regexp_replace({{ col }}, '<[^>]*>', ''), '[[:space:]]+', ' '))
{%- endmacro -%}