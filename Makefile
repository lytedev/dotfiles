MAKEFILE_PATH ?= $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all: install
default: install

install:
	cd ${MAKEFILE_PATH} && ./setup.bash
