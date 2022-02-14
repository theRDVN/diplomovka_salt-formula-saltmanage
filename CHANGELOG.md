saltmanage formula
==================

3.0.1 (2021-04-09)
-----------------
- Pridanie parametra timeout do performance konfiguracie salt mastra

3.0.0 (2020-07-14)
------------------
- Uprava kvoli prechodu na salt python3. Nahrada iteracie ``iteritems`` za ``items``.

2.4.0 (2019-11-12)
------------------
- Pridana podpora pre montovanie shared pillars cez gitfs - pozri pillar example

2.3.0 (2018-12-16)
------------------
- Pridana podpora pre name, pub a private key pre git pillar
- Pridana gitfs konfiguracia
- Pridana podpora pre nastavenie expiracie tokenu

2.2.0 (2018-09-10)
------------------
- Pridana podpora pre roster_defaults
- Opravene formatovanie rostera
- Pridana podpora pre fluent logging handler
- Pridany stav pre instalaciu GUI - Molten
- Oprava map.jinja pre grains
- Aktualizacia dokumentacie

2.1.0 (2018-06-11)
------------------
- Pridana podpora pre 2018 release - saltenv
- Moznost vyberu enviroment alebo saltenv
- Fixnuty proxy port

2.0.2 (2018-03-01)
------------------
- Opravena onfiguracia host a port v proxy minion nastaveniach


2.0.1 (2018-02-13)
------------------

- pridana podpora pre multienviroment v gitfs_remotes (#4)
- pridane stackstorm workflow a aliasy (v1)
- pridana konfiguracia master_state_events do pillar example

2.0.0 (2018-01-29)
------------------

- pridana kontrola ci uz existuje gpg kluc
- pridany stav na nastavenie grains
- ostranene nepouzivane stavy a subory
- presunute jinja templaty do adresaru templates
- init.sls zmeneny na instalaciu miniona + grains
- pridana konfiguracia master_state_events
- pridana moznost definovat cache_name pre gitfs_remotes
- aplikovana posam formula template


1.0.3 (2017-12-20)
------------------

- pridany template pre salt-minion log.conf
- pridany template pre salt-minion output.conf
- pridany template pre salt-minion proxy.conf
- pridany template pre salt-minion returner.conf
- pridany template pre salt-minion slack.conf
- pridany template pre salt-master output.conf
- pridany template pre salt-master performance.conf


1.0.2 (2017-11-15)
------------------

- pridanie podpory win repo do salt-master configu
- osetrenie nazvu stavu pre minionforwin

1.0.1 (2017-11-14)
------------------

- Template fix for syndic

1.0.0 (2017-10-27)
------------------

- Added formula template
- Added state for windows minion
