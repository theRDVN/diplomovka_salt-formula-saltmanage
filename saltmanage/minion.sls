{% from "saltmanage/map.jinja" import minion_setting with context %}

"Install and enable salt-minon service":
  pkg.installed:
    - name: salt-minion
  service.enabled:
    - name: salt-minion

"Create minion configs":
  file.recurse:
    - name: /etc/salt/minion.d
    - template: jinja
    - source: salt://saltmanage/templates/minion.d
