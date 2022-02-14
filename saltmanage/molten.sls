
"Install salt-api and enable service":
  pkg.installed:
    - name: salt-api
  service.enabled:
    - name: salt-api

"Download Molten source":
  file.managed:
    - name: /tmp/molten.tar.gz
    - source: {{ salt['pillar.get']('saltinstall:saltmolten:source') }}
    - skip_verify: True

"Create directori for molten statics":
  file.directory:
    - name: {{ pillar.saltinstall.saltmolten.config.static }}

"Extract Molten gui":
  cmd.run:
    - name: "mkdir /tmp/molten_current && tar -xvf /tmp/molten.tar.gz -C /tmp/molten_current"

"Deploy Molten gui":
  cmd.run:
    - name: "mv /tmp/molten_current/molten*/* {{ pillar.saltinstall.saltmolten.config.static }}"

"Create setting":
  file.managed:
    - name: /etc/salt/master.d/molten.conf
    - source: salt://saltmanage/templates/molten.jinja
    - template: jinja