agent_install:
    cmd.run:
    - runas: root
    - env:
      - K3S_URL: {{ pillar['k3s']['master'] }}
      - K3S_TOKEN: {{ pillar['k3s']['node_token'] }}
    - name: |
        curl -sfL https://get.k3s.io | sh -