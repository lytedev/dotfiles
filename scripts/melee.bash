#!/usr/bin/env bash

sudo modprobe uinput
sudo killall wii-u-gc-adapter
sudo "$HOME/../code/wii-u-gc-adapter/wii-u-gc-adapter" --raw &
dolphin-emu -b -c=False -e "$HOME/../game/emulation/GC/20XX 4.05.iso"
