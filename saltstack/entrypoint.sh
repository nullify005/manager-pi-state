#!/bin/bash

case "${1}" in
    local)
        salt-call --local state.highstate
        ;;
    show)
        salt-call --local state.show_highstate
        ;;
    test)
        salt-ssh '*' state.highstate test=true
        ;;
    apply)
        salt-ssh '*' state.highstate
        ;;
    shell)
        exec /bin/bash
        ;;
    cmd)
        shift
        salt-ssh '*' -r "${@}"
        ;;
    *)
        salt-ssh '*' state.highstate test=true
        ;;
esac