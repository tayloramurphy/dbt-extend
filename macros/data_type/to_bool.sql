{% macro to_bool(val, true_val=1, false_val=0) %}case when coalesce({{ val }}, {{ false_val }}) = {{ true_val }} then true else false end{% endmacro %}
