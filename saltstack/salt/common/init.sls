#!jinja|yaml

base-packages:
    pkg.installed:
    - pkgs:
      - unattended-upgrades
      - ntp
      - curl

{% set files = ["20auto-upgrades", "50unattended-upgrades"] %}
{% for file in files %}
/etc/apt/apt.conf.d/{{ file }}:
    file.managed:
    - source: salt://common/files/{{ file }}
    - user: root
    - group: root
    - mode: 644
{% endfor %}

Etc/UTC:
  timezone.system

/etc/timezone:
    file.managed:
    - user: root
    - group: root
    - modde: 644
    - contents:
      - Etc/UTC

/etc/ntp.conf:
    file.managed:
    - source: salt://common/files/ntp.conf
    - user: root
    - group: root
    - mode: 644

ntp:
    service.running:
    - enable: True
    - full_restart: True
    - watch:
      - file: /etc/ntp.conf

pi:
  user.present:
  - shell: /bin/bash
  - home: /home/pi
  - password: {{ pillar['ssh']['passwd'] }}
  - hash_password: True

ssh-pubkey:
  ssh_auth.manage:
  - user: {{ pillar['ssh']['user'] }}
  - ssh_keys:
    - {{ pillar['ssh']['public_key'] }}
  - require:
    - user: pi