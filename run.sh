#!/bin/bash

set -ex
IMG="nullify005/salt-runner:latest"
PLAT="linux/armhf"
CMD="${1}"
shift
docker build --platform=${PLAT} . -t ${IMG}
docker run -it --rm \
    --platform=${PLAT} \
    -v `pwd`/saltstack:/s \
    -v `pwd`/saltstack/ssh/config:/root/.ssh/config:ro \
    -v `pwd`/saltstack/etc/master:/etc/salt/master:ro \
    -v `pwd`/saltstack/etc/master:/etc/salt/minion:ro \
    -v `pwd`/saltstack/etc/grains:/etc/salt/grains:ro \
    -v `pwd`/secrets/id_rsa:/root/.ssh/id_rsa:ro \
    -v `pwd`/secrets:/.secrets:ro \
    ${IMG} /s/entrypoint.sh ${CMD} -- ${@}