#!/usr/bin/env bash

sudo mkdir -p /media
sudo chmod 755 /media
sudo pacman -S --noconfirm virtualbox-guest-utils
sudo modprobe -a vboxguest vboxsf vboxvideo
sudo sh -c "echo -e 'vboxguest\nvboxsf\nvboxvideo' > /etc/modules-load.d/virtualbox.conf"
sudo systemctl enable vboxservice
sudo gpasswd -a $USER vboxsf
