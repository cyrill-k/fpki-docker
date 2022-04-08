FROM mysql:5.7

# grant rights to test@%
COPY scripts/grant-rights.sql /docker-entrypoint-initdb.d/grant-rights.sql
# RUN apt update && apt install -y \
#         default-mysql-server
