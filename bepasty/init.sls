supervisor:
  pkg.installed

bepasty:
  user.present:
    - home: /home/bepasty
    - shell: /bin/bash
    - create_home: True
    - remove_groups: False

  supervisord.running:
    - user: root
    - watch:
      - file: /etc/supervisor/conf.d/bepasty.conf
    - require:
      - pkg: supervisor
      - file: /etc/supervisor/conf.d/bepasty.conf

/etc/supervisor/conf.d/bepasty.conf:
  file.managed:
    - source: salt://bepasty/supervisor.conf
    - user: root
    - group: root
    - template: jinja

python-virtualenv:
  pkg:
    - installed

/home/bepasty:
  virtualenv.managed:
    - requirements: salt://bepasty/requirements.txt
    - runas: bepasty
    - require:
      - pkg: python-virtualenv
