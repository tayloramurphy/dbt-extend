{% macro recluster(this, col, target_name=None) -%}
{% set do = true %}
{% if target_name and target.name == target_name %}
    {% set do = false %}
{% endif %}

{% if do %}
alter table {{ this }} cluster by ({{ col }});
alter table {{ this }} resume recluster;
{% endif %}
{% endmacro %}