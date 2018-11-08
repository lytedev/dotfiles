MAKEFILE_PATH ?= $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
ALERT_AGREEMENT_FILE ?= "$(MAKEFILE_PATH)/.agreed-to-erasing-files.lock"

default: install

install:
	./setup
