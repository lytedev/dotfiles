#!/usr/bin/env bash

# TODO: quiet/auto-agree mode for curl | bash automagic?

dfp=$(cd "$(dirname "${BASH_SOURCE[0]}" )/" && pwd)
source "${dfp}/bin/lib/setup_helpers.bash"

INTERACTIVE=1

while test $# -gt 0; do
	case "$1" in
		-x|--non-interactive)
			INTERACTIVE=0
			shift
			;;
	esac
done

# TODO: note about setting up ~/.env (link to a folder in ./env)
# should prompt user, perhaps?

links=(
	# desktop environment files
	"apps/de/bspwm/rc"                  "$XDG_CONFIG_HOME/bspwm/bspwmrc"
	"apps/de/bspwm/wallpapers"          "$HOME/.fehbg"
	"apps/de/sway/config"               "$XDG_CONFIG_HOME/sway/config"
	"apps/de/sway/lock"                 "$XDG_CONFIG_HOME/swaylock/config"
	"apps/de/sxhkd/rc"                  "$XDG_CONFIG_HOME/sxhkd/sxhkdrc"
	"apps/de/x/resources"               "$HOME/.Xresources"
	"apps/de/x/init"                    "$HOME/.xinitrc"
	"apps/de/x/init"                    "$HOME/.vnc/xstartup"
	"apps/de/x/profile"                 "$HOME/.xprofile"
	"apps/de/x/modmap"                  "$HOME/.xmodmap"
	"apps/de/compton/compton.conf"      "$XDG_CONFIG_HOME/compton.conf"
	"apps/de/dunst/rc"                  "$XDG_CONFIG_HOME/dunst/dunstrc"
	"apps/de/mako/"                     "$XDG_CONFIG_HOME/mako"
	"bin/lib/colors/xresources"         "$HOME/.Xresources.colors"

	# shell files
	"apps/shell/bash/rc"                "$HOME/.bashrc"
	"apps/shell/bash/profile"           "$HOME/.bash_profile"
	"apps/shell/tmux/conf"              "$HOME/.tmux.conf"
	"apps/shell/tmux/layouts"           "$HOME/.tmux/layouts"
	"apps/shell/fish/"                  "$XDG_CONFIG_HOME/fish"

	# text editor files
	"apps/neovim/"                      "$XDG_CONFIG_HOME/nvim"
	"apps/neovim/"                      "$HOME/.vim"
	"apps/neovim/init.vim"              "$HOME/.vimrc"
	"bin/lib/colors/vim"                "$XDG_CONFIG_HOME/nvim/colors/base16-donokai.vim"
	"apps/emacs/"                       "$HOME/.emacs.lytedev"

	# gtk configuration files
	"apps/de/gtk/2rc"                   "$HOME/.gtkrc-2.0"
	"apps/de/gtk/2rc"                   "$HOME/.gtkrc"
	"apps/de/gtk/3settings.ini"         "$XDG_CONFIG_HOME/gtk-3.0/settings.ini"

	# bar files
	"apps/de/polybar/config"            "$XDG_CONFIG_HOME/polybar/config"
	"apps/de/waybar/"                   "$XDG_CONFIG_HOME/waybar"

	# irc files
	"apps/irssi/"                       "$HOME/.irssi"
	"apps/weechat/"                     "$HOME/.weechat"

	# qutebrowser config files
	"apps/qutebrowser/qutebrowser.conf" "$XDG_CONFIG_HOME/qutebrowser/qutebrowser.conf"
	"apps/qutebrowser/keys.conf"        "$XDG_CONFIG_HOME/qutebrowser/keys.conf"

	# sc-im config files and scripts
	"apps/scim/rc"                      "$HOME/.scimrc"
	"apps/scim/lua"                     "$HOME/.scim/lua"

	# libinput configuration
	"apps/de/libinput/gestures.conf"    "$XDG_CONFIG_HOME/libinput-gestures.conf"

  # gpg config
  "apps/gpg/agent.conf"               "$HOME/.gnupg/gpg-agent.conf"

	# document viewer
	"apps/zathura/"                     "$XDG_CONFIG_HOME/zathura"

	# htop
	"apps/htop/rc"                      "$XDG_CONFIG_HOME/htop/htoprc"

	# terminal emulator
	"apps/alacritty/"                   "$XDG_CONFIG_HOME/alacritty"

	# kitty config
	"apps/kitty/"                       "$XDG_CONFIG_HOME/kitty"

	# rofi config
	"apps/rofi/config"                  "$XDG_CONFIG_HOME/rofi/config"

	# ranger config
	"apps/ranger/"                      "$XDG_CONFIG_HOME/ranger"

	# mutt config
	"apps/mutt/rc"                      "$XDG_CONFIG_HOME/.muttrc"
	"apps/mutt/rc"                      "$HOME/.muttrc"

	# neofetch config
	"apps/neofetch/config"              "$XDG_CONFIG_HOME/neofetch/config"

	# git config
	"apps/git/config"                   "$HOME/.gitconfig"

	# fontconfig
	"apps/de/fontconfig/"               "$XDG_CONFIG_HOME/fontconfig"

	# fontconfig
	"apps/elixir/iex.exs"               "$HOME/.iex.exs"

	# XDG user directories
	"apps/shell/user-dirs"              "$XDG_CONFIG_HOME/user-dirs.dirs"
)

chmod 700 -R "$HOME/.bin"

# TODO: pass interactive?
_dotfiles_setup_run_setup "$dfp/.agreed-to-erasing-files.lock" "${links[@]}"

if [[ "$INTERACTIVE" = 1 ]]; then
	echo -n -e "Do you want to run the bin/lib/sudo_setup script for changes to /etc"
	echo -n -e "\nand other root directories?"
	read -r -p " [y/N] " response
	response=${response,,} # to lower case
	if [[ $response =~ ^(yes|y)$ ]]; then
		"$dfp/bin/lib/sudo_setup"
	fi

	# execute the user's shell
	ush="$(getent passwd $LOGNAME | cut -d: -f7)"
	echo -e "Dotfiles Installed! Running 'exec $ush'...\n"
	exec "$ush"
fi
