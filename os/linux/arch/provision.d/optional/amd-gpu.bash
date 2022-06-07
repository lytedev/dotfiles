#!/usr/bin/env bash

paru -S --needed \
	xf86-video-amdgpu mesa \
	amdvlk \
	libva-mesa-driver mesa-vdpau libva-vdpau-driver libvdpau-va-gl `# Hardware Accelerated Video`

paru -S --needed lib32-mesa lib32-amdvlk
