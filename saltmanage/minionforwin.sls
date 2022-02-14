{% from "saltmanage/map.jinja" import minion_setting with context %}

winexe_install:
  pkg.installed:
    - name: winexe
    - sources:
      - winexe: {{ pillar.saltinstall.winexeinstaller }}

{% for minion, params in pillar.saltinstall.winminions.items() %}

install-minion_{{ minion }}:
  cmd.run:
    - name: 'winexe -U {{ params ['username'] }} --password={{ params ['password'] }} //{{ params ['host'] }} "{{ pillar.saltinstall.winsaltinstaller }} /S /master={{ params ['master'] }} /minion-name={{ minion }}"'
    - bg: True

{% endfor %}
