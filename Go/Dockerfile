FROM golang:1.13-buster AS build-base
# https://hub.docker.com/_/golang

# get sources with dependencies
RUN mkdir -p /home/cyrill/go/src/github.com/cyrill-k
WORKDIR /home/cyrill/go/src/github.com/cyrill-k
RUN git clone --single-branch --branch master --depth=1 git@github.com:cyrill-k/fpki && \
        git clone --single-branch --branch master --depth=1 git@github.com:cyrill-k/mapserver-coredns-plugin && \
        git clone --single-branch --branch fixtxt --depth=1 git@github.com:cyrill-k/dns && \
        git clone --single-branch --branch max-rcv-size --depth=1 git@github.com:cyrill-k/trillian && \
        git clone --single-branch --branch fpki-plugin --depth=1 git@github.com:cyrill-k/coredns

# build
WORKDIR /home/cyrill/go/src/github.com/cyrill-k/fpki
ENV GOPATH=/home/cyrill/go
RUN make build_tmain
RUN make pre_build_coredns
RUN make build_coredns
RUN make build_trillian

FROM debian:buster AS build-final
WORKDIR /root
COPY --from=build-base /home/cyrill/go/src/github.com/cyrill-k/fpki/makefile .
COPY --from=build-base /home/cyrill/go/src/github.com/cyrill-k/fpki/main .
COPY --from=build-base /home/cyrill/go/src/github.com/cyrill-k/trillian/trillian_log_server .
COPY --from=build-base /home/cyrill/go/src/github.com/cyrill-k/trillian/trillian_log_signer .
COPY --from=build-base /home/cyrill/go/src/github.com/cyrill-k/trillian/trillian_map_server .
COPY --from=build-base /home/cyrill/go/src/github.com/cyrill-k/trillian/createtree .
COPY --from=build-base /home/cyrill/go/src/github.com/cyrill-k/trillian/deletetree .
COPY --from=build-base /home/cyrill/go/src/github.com/cyrill-k/trillian/get_tree_public_key .
COPY --from=build-base /home/cyrill/go/src/github.com/cyrill-k/coredns/coredns .

COPY --from=build-base /home/cyrill/go/src/github.com/cyrill-k/trillian/storage/mysql/schema/storage.sql docker-scripts/config/storage.sql
COPY scripts docker-scripts

RUN apt update && apt install -y \
        wait-for-it \
        default-mysql-client \
        make
