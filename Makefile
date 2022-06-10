SHELL := /usr/bin/env bash

QMK_DIR := qmk_firmware

clone-qmk:
	git clone https://github.com/qmk/qmk_firmware.git $(QMK_DIR)

qmk-deps:
	pushd $(QMK_DIR) && \
	./util/qmk_install.sh && \
	python3 -m pip install qmk && \
	popd

fix-gcc-ubuntu:
	bash .github/scripts/update-gcc10-ubuntu.sh

qmk-submodules:
	pushd $(QMK_DIR) && \
	make git-submodule && \
	popd

qmk-cli:
	curl -s https://linux.qmk.fm/gpg_pubkey.txt | sudo apt-key add -
	add-apt-repository 'deb https://linux.qmk.fm/ focal main'
	apt update -yqq
	apt install -yqq qmk

deps: qmk-cli clone-qmk qmk-deps fix-gcc-ubuntu

