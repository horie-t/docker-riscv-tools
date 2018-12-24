FROM ubuntu:18.04

MAINTAINER HORIE Tetsuya(https://github.com/horie-t)

RUN apt-get update && apt-get install -y \
  autoconf \
  automake \
  autotools-dev \
  curl \
  libmpc-dev \
  libmpfr-dev \
  libgmp-dev \
  libusb-1.0-0-dev \
  gawk \
  build-essential \
  bison \
  flex \
  texinfo \
  gperf \
  libtool \
  patchutils \
  bc \
  zlib1g-dev \
  device-tree-compiler \
  pkg-config \
  libexpat-dev \
  git

ENV RISCV=/opt/riscv
ENV PATH=$RISCV/bin:$PATH
WORKDIR $RISCV

RUN git clone --recursive https://github.com/riscv/riscv-tools.git && \
  cd riscv-tools && ./build.sh

WORKDIR /root