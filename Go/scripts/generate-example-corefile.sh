#!/usr/bin/env bash
set -eo pipefail
IFS=$'\n\t'

cat >/mnt/share/example.db <<EOF
example.com.        IN  SOA dns.example.com. robbmanes.example.com. 2015082541 7200 3600 1209600 3600
gateway.example.com.    IN  A   192.168.1.1
dns.example.com.    IN  A   192.168.1.2
host.example.com.   IN  A   192.168.1.3
server.example.com. IN  CNAME   host.example.com
EOF

cat >/mnt/share/Corefile <<EOF
.:53 {
    forward . 8.8.8.8 9.9.9.9
    log
    errors
}

example.com:53 {
    file /root/example.db
    log
    errors
}
EOF
