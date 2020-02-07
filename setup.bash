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

links=(
	# desktop environment files
	"$dfp/apps/de/bspwm/rc"                  "$XDG_CONFIG_HOME/bspwm/bspwmrc"
	"$dfp/apps/de/bspwm/wallpapers"          "$HOME/.fehbg"
	"$dfp/apps/de/sway/config"               "$XDG_CONFIG_HOME/sway/config"
	"$dfp/apps/de/sxhkd/rc"                  "$XDG_CONFIG_HOME/sxhkd/sxhkdrc"
	"$dfp/apps/de/x/resources"               "$HOME/.Xresources"
	"$dfp/apps/de/x/init"                    "$HOME/.xinitrc"
	"$dfp/apps/de/x/init"                    "$HOME/.vnc/xstartup"
	"$dfp/apps/de/x/profile"                 "$HOME/.xprofile"
	"$dfp/apps/de/x/modmap"                  "$HOME/.xmodmap"
	"$dfp/apps/de/compton/compton.conf"      "$XDG_CONFIG_HOME/compton.conf"
	"$dfp/apps/de/dunst/rc"                  "$XDG_CONFIG_HOME/dunst/dunstrc"
	"$dfp/apps/de/mako/"                     "$XDG_CONFIG_HOME/mako"
	"$dfp/bin/lib/colors/xresources"         "$HOME/.Xresources.colors"

	# shell files
	"$dfp/apps/shell/bash/rc"                "$HOME/.bashrc"
	"$dfp/apps/shell/bash/profile"           "$HOME/.bash_profile"
	"$dfp/apps/shell/tmux/conf"              "$HOME/.tmux.conf"
	"$dfp/apps/shell/tmux/layouts"           "$HOME/.tmux/layouts"
	"$dfp/apps/shell/fish/"                  "$XDG_CONFIG_HOME/fish"

	# text editor files
	"$dfp/apps/neovim/"                      "$XDG_CONFIG_HOME/nvim"
	"$dfp/apps/neovim/"                      "$HOME/.vim"
	"$dfp/apps/neovim/init.vim"              "$HOME/.vimrc"
	"$dfp/bin/lib/colors/vim"                "$XDG_CONFIG_HOME/nvim/colors/base16-donokai.vim"

	# gtk configuration files
	"$dfp/apps/de/gtk/2rc"                   "$HOME/.gtkrc-2.0"
	"$dfp/apps/de/gtk/2rc"                   "$HOME/.gtkrc"
	"$dfp/apps/de/gtk/3settings.ini"         "$XDG_CONFIG_HOME/gtk-3.0/settings.ini"

	# bar files
	"$dfp/apps/de/polybar/config"            "$XDG_CONFIG_HOME/polybar/config"
	"$dfp/apps/de/waybar/"                   "$XDG_CONFIG_HOME/waybar"

	# irc files
	"$dfp/apps/irssi/"                       "$HOME/.irssi"
	"$dfp/apps/weechat/"                     "$HOME/.weechat"

	# qutebrowser config files
	"$dfp/apps/qutebrowser/qutebrowser.conf" "$XDG_CONFIG_HOME/qutebrowser/qutebrowser.conf"
	"$dfp/apps/qutebrowser/keys.conf"        "$XDG_CONFIG_HOME/qutebrowser/keys.conf"

	# sc-im config files and scripts
	"$dfp/apps/scim/rc"                      "$HOME/.scimrc"
	"$dfp/apps/scim/lua"                     "$HOME/.scim/lua"

	# libinput configuration
	"$dfp/apps/de/libinput/gestures.conf"    "$XDG_CONFIG_HOME/libinput-gestures.conf"

  # gpg config
  "$dfp/apps/gpg/agent.conf"               "$HOME/.gnupg/gpg-agent.conf"

	# document viewer
	"$dfp/apps/zathura/"                     "$XDG_CONFIG_HOME/zathura"

	# htop
	"$dfp/apps/htop/rc"                      "$XDG_CONFIG_HOME/htop/htoprc"

	# terminal emulator
	"$dfp/apps/alacritty/"                   "$XDG_CONFIG_HOME/alacritty"

	# kitty config
	"$dfp/apps/kitty/"                       "$XDG_CONFIG_HOME/kitty"

	# rofi config
	"$dfp/apps/rofi/config"                  "$XDG_CONFIG_HOME/rofi/config"

	# ranger config
	"$dfp/apps/ranger/"                      "$XDG_CONFIG_HOME/ranger"

	# mutt config
	"$dfp/apps/mutt/rc"                      "$XDG_CONFIG_HOME/.muttrc"
	"$dfp/apps/mutt/rc"                      "$HOME/.muttrc"

	# neofetch config
	"$dfp/apps/neofetch/config"              "$XDG_CONFIG_HOME/neofetch/config"

	# git config
	"$dfp/apps/git/config"                   "$HOME/.gitconfig"

	# fontconfig
	"$dfp/apps/de/fontconfig/"               "$XDG_CONFIG_HOME/fontconfig"

	# fontconfig
	"$dfp/apps/elixir/iex.exs"               "$HOME/.iex.exs"

	# XDG user directories
	"$dfp/apps/shell/user-dirs"              "$XDG_CONFIG_HOME/user-dirs.dirs"
)

chmod 700 -R "$HOME/.bin"

# TODO: note about setting up ~/.env (link to a folder in ./env)

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
