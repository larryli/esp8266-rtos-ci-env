# Environment for ESP8266_RTOS_SDK CI builds

Base on [ubuntu:18.04](https://hub.docker.com/_/ubuntu)
and setup [ESP8266_RTOS_SDK v3.1](https://github.com/espressif/ESP8266_RTOS_SDK/blob/v3.1/docs/en/get-started/index.rst)
with [toolchain linux64-1.22.0-88-gde0bdc1-4.8.5](https://github.com/espressif/ESP8266_RTOS_SDK/blob/v3.1/docs/en/get-started/linux-setup.rst)

```shell
docker run -it --rm larryli/esp8266-rtos-ci-env
cd $IDF_PATH/examples/get-started/project_template
make defconfig
make all V=1
```

You can write a `.gitlab-ci.yml` file like:

```yaml
image: larryli/esp8266-rtos-ci-env

stages:
  - build

build_app:
  stage: build
  script:
    - make defconfig
    - make all
  artifacts:
    paths:
      - build/bootloader/bootloader.bin
      - build/partitions_singleapp.bin
      - build/project_template.bin
```
