
# SaltManage


Formula to install, configure and just manage SaltStack infra

`Full documentation (SK):` https://wiki.posam.sk/display/devops/SaltManage

## Tested on OS platforms

CentOS 7
Oracle Enterprise Linux 7

## Recommendations

Best use with salt-ssh
Works with regular salt usage
Does not include salt-master and salt-minion restarts


# Available states

`saltmanage.master`


Install and configure saltmaster.
See pillar example for full options.

```yaml
 saltinstall:
 # master install and configuration
   master:
     is_syndic: False
     # use if master is syndic type
     # syndic_master: 199.199.199.199
     publish_port: 4505
     ret_port: 4506
     set_gpg: False
     order_masters: True
     file_roots:
       dev:
         - /opt/salt/dev/states
         - /opt/salt/dev/artifacts
         - /opt/salt/dev/formulas/salt-formula-saltmanage
     pillar_roots:
       dev:
         - /opt/salt/dev/pillars
       test:
         - /opt/salt/test/pillars
     sudo_acl: False
     ....
```


`saltmanage.minion`

Install and configure salt-minion.
See pillar example for full options.

```yaml
 saltinstall:
  minion:
    id: {{ hostname }}
    # master: 192.168.13.185
    master:
      - 192.168.13.185
      - 127.0.0.1
    master_port: 4506
    publish_port: 4505
    saltenv: dev
    environment: dev
    state_top_saltenv: dev
    default_top: dev
    test: True
 #  master_type: failover / str / disabled
    master_type: failover
    master_alive_interval: 30
    master_failback: True
    master_failback_interval: 30
    retry_dns: 0
```


`saltmanage.saltssh`

Create roster for salt-ssh usage

```yaml

 saltinstall:
  ssh-roster:
   prod1:
     host: host1.posam.sk
     user: ubuntu
     sudo: True
     priv: /etc/salt/ssh_keys/sshkey.pem
   prod2:
     host: host2.posam.sk
     user: ubuntu
     sudo: True
     passwd: Tralala
```

`saltmanage.saltapi`

Install and configure api

```yaml

 saltinstall:
  salt-api:
   port: 8006
   ssl_crt: /etc/pki/tls/certs/localhost.crt
   ssl_key: /etc/pki/tls/certs/localhost.key
```

`saltmanage.molten`

Install and configure Molten GUI for salt.  
`! If configuring molten don't use api configuration !`  
Using Molten GUI will make standard api unavailable to be used for example with StackStorm.

```yaml

 saltinstall:
  saltmolten: 
    source: "https://github.com/martinhoefling/molten/releases/download/v0.2.0/molten-0.2.0.tar.gz"
    config: 
      port: 8056
      ssl_crt: /etc/pki/tls/certs/localhost.crt
      ssl_key: /etc/pki/tls/certs/localhost.key  
      host: 0.0.0.0
      static: /opt/molten
      static_path: /assets
      app: /opt/molten/index.html
      app_path: /molten
      log_error_file: /var/log/salt/api-error
      log_access_file: /var/log/salt/api-access

```

`saltmanage.minionforwin`

Install and configure windows minions

```yaml

 saltinstall:
  winsaltinstaller: \\\\127.0.0.1\\packages\\Salt-Minion-Win\\Salt-Minion-2017.7.2-Py2-AMD64-Setup.exe
  winexeinstaller: salt://winexe-1.00.1-1.2.x86_64.rpm
  winminions:
   win-sp3term10:
     username: Administrator
     password: Passw0rd
     master: 127.0.0.1
     host: 127.0.0.1
```

`saltmanage.grains`

Set new grains

```yaml
 saltinstall:
   grains:
     grain1: value1
     grain2: value2
     grain3:
       - value3
       - value4
```

`Using FLUENT Logging handler`  
Add fluent_handler configuration under master or minion to configure fluent logging.  

Minion:  
```yaml
 saltinstall:
  minion:
    fluent_handler:
      host: sbagraylog01d.posam.sk
      port: 24224
      payload_type: graylog
      tags:
        - salt_minion.{{ host|upper }}
```
Master:  
```yaml
 saltinstall:
  master:
    fluent_handler:
      host: sbagraylog01d.posam.sk
      port: 24224
      payload_type: graylog
      tags:
        - salt_master.{{ host|upper }}
```

# Formula Dependencies

* installed python 2.7+ and python27-pip+



# To Do:
* Finish default.yml


Pillar example is included in git project.


# Template

This formula was created from a cookiecutter template.
See http://git.posam.sk/dsi-devops/salt-formula-cookiecutter.
