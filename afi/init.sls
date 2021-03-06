# vim: sts=2 ts=2 sw=2 et ai
{% from "afi/map.jinja" import afi with context %}

afi__pkg_afi:
  pkg.installed:
    - name: afi
    - pkgs: {{afi.afipackages}}
{% if afi.afiservicemanage == True %}
    - watch_in:
      - service: afi__service_httpd
{% endif %}

afi__file_{{afi.aficonfdir}}:
  file.recurse:
    - name: {{afi.aficonfdir}}
    - exclude_pat: E@hosts/.*/install/.*conf
    - clean: True
    - include_empty: True
    - force_symlinks: True
    - keep_symlinks: True
    - user: apache
    - group: apache
    - dir_mode: 0775
    - file_mode: '0644'
    - template: jinja
    - source: salt://afi/files/config

{% if afi.afiservicemanage == True %}
afi__service_httpd:
  service.running:
    - name: {{afi.afiservice}}
{% endif %}
