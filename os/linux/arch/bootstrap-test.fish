#!/usr/bin/env fish

docker ps -q || begin
	echo "docker not running"
	exit 1
end

docker pull archlinux -q || begin
	echo "failed to pull archlinux docker image"
	exit 1
end

docker run -it --rm -v $DOTFILES_PATH:/dotfiles:ro archlinux sh -c "pacman -Sy --noconfirm git; /dotfiles/common/bin/dotfiles-init"
