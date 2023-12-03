SHELL := /usr/bin/env bash

QMK_DIR := qmk_firmware

qmk-clone: $(QMK_DIR)/.git/HEAD
$(QMK_DIR)/.git/HEAD:
	git clone https://github.com/qmk/qmk_firmware $(QMK_DIR)

qmk-deps: qmk-clone $(QMK_DIR)/.qmk-installed
$(QMK_DIR)/.qmk-installed:
	pushd $(QMK_DIR) && \
	./util/qmk_install.sh && \
	python3 -m pip install qmk && \
	echo "true" > .qmk-installed && \
	popd

fix-gcc-ubuntu: /usr/share/gcc-arm-none-eabi-10-2020-q4-major/bin/arm-none-eabi-gcc
/usr/share/gcc-arm-none-eabi-10-2020-q4-major/bin/arm-none-eabi-gcc:
	sudo bash .github/scripts/update-gcc10-ubuntu.sh

qmk-submodules: qmk-clone
	pushd $(QMK_DIR) && \
	make git-submodule && \
	popd

deps: fix-gcc-ubuntu qmk-clone qmk-deps
