MAKEFILE_PATH ?= $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
ALERT_AGREEMENT_FILE ?= "$(MAKEFILE_PATH)/.agreed-to-erasing-files.lock"

default: install

$(ALERT_AGREEMENT_FILE):
	@echo -e "Running this script may delete existing personal configuration files.\n" \
	"Please view this script's source, fully understand it, and backup any\n" \
	"files before continuing.\n" \
	"Seriously. Like... entire directories. Just gone."

# RESPONSE=$(shell bash -c 'read -r -p "Are you sure you want to continue? [y/N] "')
# @if [[ $response =~ ^(yes|y)$ ]]; then
# @echo "agreed" > "$ALERT_AGREEMENT_FILE"
# @else
# @exit 1
# @fi

install: $(ALERT_AGREEMENT_FILE)
	@echo "Installed!"
