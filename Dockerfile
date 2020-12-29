FROM alpine

RUN apk add --no-cache --virtual codesc2-build-dependencies \
    git \
    build-base \
    cmake \
    python3

ENV REVISION master
RUN git clone --depth 1 --branch ${REVISION}  https://github.com/drowe67/codec2 /codec2

RUN mkdir -p /codec2/build
WORKDIR /codec2/build

RUN cmake \
    -DCMAKE_INSTALL_PREFIX=/opt/codec2 \
    ..
RUN make install

RUN git clone --depth 1 --branch ${REVISION} https://github.com/mborgerding/kissfft.git /kissfft

WORKDIR /kissfft/build

RUN cmake \
    -DCMAKE_INSTALL_PREFIX=/opt/kissfft \
    ..
RUN make

RUN cp /kissfft/kiss_fft.h /opt/codec2/include/ &&\
    cp /kissfft/build/CMakeFiles/kissfft.dir/kiss_fft.c.o /opt/codec2/lib64/kiss_fft.c.o &&\
    ln -s /opt/codec2/include/kiss_fft.h /opt/codec2/include/codec2/kiss_fft.h

