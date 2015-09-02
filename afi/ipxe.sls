# vim: sts=2 ts=2 sw=2 et ai
{% from "afi/map.jinja" import afi with context %}

afi_ipxe__pkg_ipxeroms:
  pkg.installed:
    - name: ipxeroms
    - pkgs: {{afi.afipackagesipxeroms}}

afi_ipxe__file_{{afi.afiipxeromtgt}}:
  file.copy:
    - name: {{afi.afiipxeromtgt}}
    - source: {{afi.afiipxeromsrc}}
    - require:
      - pkg: ipxeroms
