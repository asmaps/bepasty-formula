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

/home/bepasty/bepasty.conf:
  file.managed:
    - source: salt://bepasty/bepasty.conf
    - user: bepasty
    - group: bepasty

python-virtualenv:
  pkg:
    - installed

python-dev:
  pkg:
    - installed

/home/bepasty:
  virtualenv.managed:
    - requirements: salt://bepasty/requirements.txt
    - runas: bepasty
    - require:
      - pkg: python-virtualenv

/home/bepasty/logs:
  file.directory:
    - user: bepasty
    - group: bepasty
    - dir_mode: 777

/home/bepasty/bin/start_server:
  file.managed:
    - source: salt://bepasty/start_server
    - user: bepasty
    - group: bepasty
    - mode: 755
    - template: jinja
