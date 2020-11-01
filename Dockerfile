FROM 0x01be/codec2:build as build

FROM alpine

COPY --from=build /opt/codec2/ /opt/codec2/

