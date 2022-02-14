{% from "saltmanage/map.jinja" import saltmanage with context %}

{% for pkg in saltmanage.pkgs %}
test_{{pkg}}_is_installed:
  testinfra.package:
    - name: {{ pkg }}
    - is_installed: True
{% endfor %}
