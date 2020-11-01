FROM lsiobase/alpine:3.10
LABEL maintainer="VergilGao"

ARG GLIBC_VERSION
ARG VERYSYNC_VERSION
ARG BUILD_DATE

RUN \
    cd /tmp &&\
    echo "**** install glibc ****" && \
    apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk && \
    apk add glibc-${GLIBC_VERSION}.apk && \
    apk add glibc-bin-${GLIBC_VERSION}.apk && \
    echo "**** install verysync *****" && \
    wget http://dl.verysync.com/releases/v${VERYSYNC_VERSION}/verysync-linux-amd64-v${VERYSYNC_VERSION}.tar.gz && \
    tar zxvf verysync-linux-amd64-v${VERYSYNC_VERSION}.tar.gz && \
    mv verysync-linux-amd64-v${VERYSYNC_VERSION}/verysync /app && \
    echo "**** cleanup ****" && \
    rm /etc/apk/keys/sgerrand.rsa.pub && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/* && \
    apk del .build-dependencies

# 版本号
ARG BUILD_DATE
ARG VERSION
LABEL build_version="catfight360.com version:- ${VERSION} build-date:- ${BUILD_DATE}"

# add local files
COPY root/ / 

VOLUME ["/verysync"]
