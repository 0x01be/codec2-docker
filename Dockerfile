FROM alpine

RUN apk add --no-cache --virtual codesc2-build-dependencies \
    git \
    build-base \
    cmake

ENV REVISION master
RUN git clone --depth 1 --branch ${REVISION}  https://github.com/drowe67/codec2 /codec2

RUN mkdir -p /codec2/build
WORKDIR /codec2/build

RUN cmake \
    -DCMAKE_INSTALL_PREFIX=/opt/codec2 \
    ..
RUN make install

