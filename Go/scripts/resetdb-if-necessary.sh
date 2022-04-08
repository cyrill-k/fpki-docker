#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# See https://stackoverflow.com/a/246128/3561275
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"


# check if database is already initialized
if ! mysql -h "${MYSQL_HOST}" -u "${MYSQL_ROOT_USER}" "-p${MYSQL_ROOT_PASSWORD}" -e "SELECT 1 FROM test.Trees LIMIT 1;"; then
    "$DIR/resetdb.sh" --force
fi
