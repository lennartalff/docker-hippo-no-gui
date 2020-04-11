__CROSS__FROM alpine AS builder

__CROSS__ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-__QEMU_ARCH__.tar.gz
__CROSS__RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . --strip-components 1

FROM lennartalff/hippo-base

__CROSS__COPY --from=builder qemu-__QEMU_ARCH__-static /usr/bin


RUN apt-get update && apt-get install -yq \
    ros-melodic-robot \
    ros-melodic-perception \
    && rm -rf /var/lib/apt/lists/