SHELL := /usr/bin/env bash

QMK_DIR := qmk_firmware

clone-qmk: 
	qmk clone qmk/qmk_firmware $(QMK_DIR)

qmk-deps:
	pushd $(QMK_DIR) && \
	./util/qmk_install.sh && \
	python3 -m pip install qmk && \
	popd

fix-gcc-ubuntu:
	sudo bash .github/scripts/update-gcc10-ubuntu.sh

qmk-submodules:
	pushd $(QMK_DIR) && \
	make git-submodule && \
	popd

qmk-cli:
	curl -s https://linux.qmk.fm/gpg_pubkey.txt | sudo apt-key add -
	sudo add-apt-repository 'deb https://linux.qmk.fm/ focal main'
	sudo apt update -yqq
	sudo apt install -yqq qmk

deps: fix-gcc-ubuntu qmk-cli clone-qmk qmk-deps

release:
	$(eval TAG := $(shell date +%Y%m%d-%H%M))
	@echo pushing tag $(TAG) for release using main:
	git show main
	git tag $(TAG) main
	git push --atomic origin main $(TAG)