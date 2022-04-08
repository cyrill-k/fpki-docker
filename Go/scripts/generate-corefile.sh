#!/usr/bin/env bash
set -eo pipefail
IFS=$'\n\t'

if [ -z "${DNS_PORT_INTERNAL}" ]; then
    echo "DNS_PORT_INTERNAL cannot be empty" >&2
    exit 1
fi

if [ -z "${MAPSERVER_DOMAIN}" ]; then
    echo "MAPSERVER_DOMAIN cannot be empty" >&2
    exit 1
fi

cat >/mnt/config/Corefile <<EOF
.:${DNS_PORT_INTERNAL} {
  debug
  forward . ${DNS_FORWARD_HOSTS}
}

${MAPSERVER_DOMAIN}:${DNS_PORT_INTERNAL} {
  debug
  mapserver /mnt/config/mapid1 /mnt/config/mappk1.pem grpc://map-server:8094 1073741824
}

EOF
