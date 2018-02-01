FROM alpine:3.6

ARG SERVER_ADDR     0.0.0.0
ARG SERVER_PORT     51348
ARG PASSWORD        psw
ARG METHOD          aes-128-ctr
ARG PROTOCOL        auth_aes128_md5
ARG PROTOCOLPARAM   32
ARG OBFS            tls1.2_ticket_auth_compatible
ARG TIMEOUT         300
ARG DNS_ADDR        8.8.8.8
ARG DNS_ADDR_2      8.8.4.4

ARG BRANCH=manyuser
ARG WORK=~


RUN apk --no-cache add python \
    libsodium \
    wget


RUN mkdir -p $WORK && \
    wget -qO- --no-check-certificate https://github.com/shadowsocksr/shadowsocksr/archive/$BRANCH.tar.gz | tar -xzf - -C $WORK


WORKDIR $WORK/shadowsocksr-$BRANCH/shadowsocks


EXPOSE $SERVER_PORT
CMD python server.py -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS -G $PROTOCOLPARAM
