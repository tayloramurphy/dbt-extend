{% macro recluster(this, col) -%}
 alter table {{ this }} cluster by ({{ col }});
 alter table {{ this }} resume recluster
 {% endmacro %}