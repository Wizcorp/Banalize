#!/bin/bash -e -u

ARG=${1:-unset}

case $ARG in 
    config)
        cat <<EOF
---
:name: $(basename $0)
:policy: 
  - :bug
  - :test
:severity: 5
:description: Runs bash syntax check using 'bash -n' option

EOF
        exit 0;;
esac


[ -z "$ARG" ] && { echo "File name must be provided"; exit 64; }
[ -f "$ARG" ] || { echo "File must exist"; exit 64; }


\bash -n $ARG > /dev/null 2>&1 
exit $?