#!/usr/bin/env bash

yay -S \
	xf86-video-amdgpu mesa lib32-mesa \
	amdvlk lib32-amdvlk \
	libva-mesa-driver mesa-vdpau libva-vdpau-driver libvdpau-va-gl `# Hardware Accelerated Video`
