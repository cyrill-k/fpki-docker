#!/usr/bin/env bash
# set -euo pipefail
# IFS=$'\n\t'

while ! mysql -h "${MYSQL_HOST}" -u "${MYSQL_ROOT_USER}" "-p${MYSQL_ROOT_PASSWORD}" -e "status"; do
    sleep 1
done
