# This dockerfile uses Environment for ESP8266_RTOS_SDK CI builds
#
# Ubuntu 18.04
# https://hub.docker.com/_/ubuntu
#
# Toolchain linux64-1.22.0-88-gde0bdc1-4.8.5
# https://github.com/espressif/ESP8266_RTOS_SDK/blob/v3.1/docs/en/get-started/linux-setup.rst
#
# ESP8266_RTOS_SDK v3.1
# https://github.com/espressif/ESP8266_RTOS_SDK/blob/v3.1/docs/en/get-started/index.rst
#
# Author: Larry Li
# https://github.com/larryli/esp8266-rtos-ci-env

FROM ubuntu:18.04
MAINTAINER Larry Li larryli@qq.com

ENV IDF_PATH="/opt/local/espressif/ESP8266_RTOS_SDK" \
    PATH="/opt/local/espressif/xtensa-lx106-elf/bin:${PATH}"
RUN apt-get update \
    && apt-get install -y gcc git wget make libncurses-dev flex bison gperf python python-serial \
	&& rm -r /var/lib/apt/lists/*
RUN mkdir -p /opt/local/espressif/ \
    && wget -qO- https://dl.espressif.com/dl/xtensa-lx106-elf-linux64-1.22.0-88-gde0bdc1-4.8.5.tar.gz \
    | tar xz -C /opt/local/espressif/
RUN git clone -b v3.1 --depth 1 --recursive https://github.com/espressif/ESP8266_RTOS_SDK $IDF_PATH \
    && cd $IDF_PATH && git submodule foreach --recursive 'git gc --aggressive --prune=all'
