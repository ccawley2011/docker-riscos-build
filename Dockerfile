FROM riscosdotinfo/riscos-gccsdk-4.7:latest AS riscos-gccsdk-4.7

FROM ubuntu:22.04
WORKDIR /usr/src

COPY --from=riscos-gccsdk-4.7 /home/riscos /home/riscos

ENV GCCSDK_INSTALL_CROSSBIN=/home/riscos/cross/bin \
    GCCSDK_INSTALL_ENV=/home/riscos/env \
    CROSSTOOLS=/usr/src/CrossTools \
    ROOL_BIN=/opt/rool/bin \
    TOOLCHAIN=GNU

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		ca-certificates gcc git libc-dev make \
		bison flex gcc-multilib && \
	rm -rf /var/lib/apt/lists/*

COPY scripts/branches.sh scripts/setup.sh ./
RUN ./setup.sh && rm -rf $CROSSTOOLS *.sh
