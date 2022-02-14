{% from "saltmanage/map.jinja" import master_setting with context %}

"Install salt-master and enable service":
  pkg.installed:
    - name: salt-master
  service.enabled:
    - name: salt-master

"Create SaltMaster configurations":
  file.recurse:
    - name: /etc/salt/master.d
    - template: jinja
    - source: salt://saltmanage/templates/master.d

# ACL permision fix
{% if pillar.saltinstall.master.publisher_acl is defined %}

"Fix permissions on cache for ACL":
  cmd.run:
    - name: chmod -R 755  /var/cache/salt /var/cache/salt/master /var/cache/salt/master/jobs /var/run/salt /var/run/salt/master

"Fix permissions on logs for ACL":
  cmd.run:
    - name: chmod -R 777  /var/log/salt

{% endif %}

# GitFS
{% if pillar.saltinstall.master.ext_pillar is defined or pillar.saltinstall.master.gitfs_remotes is defined %}

include:
  - saltmanage.gitfs_install

{% endif %}

# GPG
{% if master_setting.set_gpg == true %}

{% if 0 == salt['cmd.retcode']('test -f /etc/salt/gpgkeys/SaltMaster.gpg') %}

"Key already generated":
  cmd.run:
    - name: echo "/etc/salt/gpgkeys/SaltMaster.gpg already exist. Skipping..."

{% else %}

"Install rng tools and generate random":
  pkg.installed:
    - name: rng-tools
  cmd.run:
    - name: rngd -r /dev/urandom
  file.directory:
    - name: /etc/salt/gpgkeys
    - user: root
    - group: root
    - dir_mode: 0700
    - file_mode: 700
    - recurse:
      - user
      - group
      - mode

"Copy gpg template":
  file.managed:
    - name: /etc/salt/gpgkeys/gpg-gen
    - source: salt://saltmanage/files/gpg-gen

"Start gpg agent":
  cmd.run:
    - name: gpg-agent --homedir /etc/salt/gpgkeys --daemon
    - bg: True

"Generate new gpg key":
  cmd.run:
    - name: gpg --gen-key --homedir /etc/salt/gpgkeys --batch /etc/salt/gpgkeys/gpg-gen

"Export key":
  cmd.run:
    - name: 'gpg --homedir /etc/salt/gpgkeys --armor --export > /etc/salt/gpgkeys/SaltMaster.gpg'

"Import key":
  cmd.run:
    - name: "gpg --import /etc/salt/gpgkeys/SaltMaster.gpg"

{% endif %}

{% endif %}

#syndic install
{% if pillar.saltinstall.master.is_syndic == True %}

"Install saltsyndic and enable service":
  pkg.installed:
    - name: salt-syndic
  service.enabled:
    - name: salt-syndic

"Create syndic setrings":
  file.managed:
    - name: /etc/salt/minion.d/syndic.conf
    - source: salt://saltmanage/templates/minion.d/syndic.conf
    - template: jinja

{% endif %}

# salt API
{%- set api = salt['pillar.get']('saltinstall:salt-api') -%}
{%- if api %}

"Install SaltApi and enable service":
  pkg.installed:
    - name: salt-api
  service.enabled:
    - name: salt-api

{% endif %}
