FROM liyyt/opencv:latest

LABEL maintainer="Jethro Hicks <jethro@hicksinspace.com>"

ENV THUMBOR_VERSION=6.5.2

RUN apk add --update --no-cache --virtual .build-deps \
        gcc \
        build-base \
        cmake \
        make \
        clang-dev \
        linux-headers \
    && apk add --update --no-cache \
        libcurl \
        ca-certificates \
        curl-dev \
        musl-dev \
        libgfortran \
        libstdc++ \
        libdc1394 \
	&& export LIBRARY_PATH=/lib \
    && pip install \
        thumbor==$THUMBOR_VERSION \
        Pillow==5.1.0 \
        pyres==1.5 \
        argparse==1.2.2 \
        envtpl==0.6.0 \
        boto==2.49.0 \
        botocore==1.8.50 \
        dateutils==0.6.6 \
        pyremotecv==0.5.0 \
        remotecv==2.2.2 \
        thumbor==6.5.2 \
        tc_aws==6.2.11 \
        tc_core==0.4.1 \
        tc_shortener==0.2.2 \
        raven==6.9.0 \
        tc_redis==1.0.1 \
    && apk del .build-deps

WORKDIR /opt

COPY thumbor.conf.tpl thumbor.conf.tpl
COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x /opt/docker-entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/opt/docker-entrypoint.sh"]
CMD ["thumbor"]
