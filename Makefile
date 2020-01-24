MAKEFILE_PATH ?= $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

default: install

install:
	cd ${MAKEFILE_PATH} && ./setup.bash
