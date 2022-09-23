/boot/cmdline.txt:
    file.replace:
    - pattern: 'rootwait$'
    - repl: 'rootwait cgroup_memory=1 cgroup_enable=memory cgroup_enable=cpuset'

switch_to_iptables:
    cmd.run:
    - name: |
        iptables -F
        update-alternatives --set iptables /usr/sbin/iptables-legacy
        dphys-swapfile swapoff
        dphys-swapfile uninstall
    - onchanges:
      - file: /boot/cmdline.txt

{#
/usr/local/bin/k3s:
    file.managed:
    - source: {{ pillar['k3s']['release'] }}
    - source_hash: {{ pillar['k3s']['sha'] }}
    - user: root
    - group: root
    - mode: 755
#}