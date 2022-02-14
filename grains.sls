{% if pillar.saltinstall.grains is defined %}

{%- set grains = pillar.saltinstall.grains -%}
{%- if grains %}

{%- for k, v in grains.items() %}

{% if k is iterable and k is not string %}

{{ k }}:
  grains.list_absent
  grains.list_present:
    - value: {{ v }}

{% else %}

{{ k }}:
  grains.present:
    - value: {{ v }}
    - force: True

{% endif %}

{%- endfor %}

{%- endif -%}

{% endif %}
