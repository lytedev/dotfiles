#!/usr/bin/env bash

test -d /boot/loader/entries || { echo "no known bootloader"; exit 1; }

inject_red="vt.default_red=0x11,0xf9,0xa6,0xf4,0x66,0xae,0xa1,0xf8,0x75,0xf9,0xa6,0xf4,0x66,0xae,0xa1,0xf9"
inject_green="vt.default_grn=0x11,0x26,0xe2,0xbf,0xd9,0x81,0xef,0xf8,0x71,0x26,0xe2,0xbf,0xd9,0x81,0xef,0xf8"
inject_blue="vt.default_blu=0x11,0x72,0x2e,0x75,0xef,0xff,0xe4,0xf2,0x5e,0x72,0x2e,0x75,0xef,0xff,0xe4,0xf5"

optional_space='[[:space:]]\{0,1\}'
not_space="[^[:space:]]"

function delete_matching_param() {
	opt="$1"; shift
	sed -i '/^options / s/'"$opt"'//' "$@"
}

function delete_prefixed_unquoted_param() {
	pre="$1"; shift
	delete_matching_param "$optional_space$pre$not_space*" "$@"
}

for f in /boot/loader/entries/*; do
	delete_prefixed_unquoted_param 'vt.default_red=' "$f"
	delete_prefixed_unquoted_param 'vt.default_grn=' "$f"
	delete_prefixed_unquoted_param 'vt.default_blu=' "$f"
	# append kernel params
	sed -i "/^options / s/$/ $inject_red $inject_green $inject_blue/" "$f"
done
