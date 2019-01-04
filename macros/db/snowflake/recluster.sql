{% macro recluster(this, col, target_name=None) -%}
{% set do = true %}
{% if target_name %}
    {% if target.name == target_name %}
    {% set do = true %}
    {% else %}
    {% set do = false %}
    {% endif %}
{% endif %}

{% if do %}
alter table {{ this }} cluster by ({{ col }});
alter table {{ this }} resume recluster;
{% endif %}
{% endmacro %}