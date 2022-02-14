{% from "saltmanage/map.jinja" import master_setting with context %}

"Install salt ssh":
  pkg.installed:
    - name: salt-ssh

"Create roster config":
  file.managed:
    - name: /etc/salt/roster
    - source: salt://saltmanage/templates/roster.jinja
    - template: jinja
    - require:
      - "Install salt ssh"

"Create roster_default config":
  file.managed:
    - name: /etc/salt/master.d/roster_defaults.conf
    - source: salt://saltmanage/templates/roster_defaults.jinja
    - template: jinja
    - require:
      - "Install salt ssh"