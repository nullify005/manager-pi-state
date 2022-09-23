master_install:
    cmd.run:
    - runas: root
    - name: |
        curl -sfL https://get.k3s.io | sh -