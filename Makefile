MAKEFILE_PATH ?= $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: install
install:
	@cd ${MAKEFILE_PATH} && ./bin/setup-dotfiles
