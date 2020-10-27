#!/usr/bin/env fish

set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux DOTFILES_PATH $XDG_CONFIG_HOME/dotfiles
set -Ux ENV_PATH $HOME/.env

source $DOTFILES_PATH/apps/shell/fish/paths.fish

status --is-interactive || exit

for f in key-bindings colors prompt aliases
	source $DOTFILES_PATH/apps/shell/fish/$f.fish
end

set -Ux _JAVA_AWT_WM_NONREPARENTING 1
set -Ux TERMINAL kitty
set -Ux BROWSER firefox-developer-edition
set -Ux ERL_AFLAGS "-kernel shell_history enabled -kernel shell_history_file_bytes 1024000" # iex history
set -Ux LESS "-r"

# more sane ls colors
set -Ux LS_COLORS 'ow=01;36;40'

has_command fd && set -Ux FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'

test -f ~/.fzf/shell/key-bindings.fish && source ~/.fzf/shell/key-bindings.fish

function fish_greeting
	fortune
end

# we assume the user uses "$HOME" to just store their mess of dotfiles and other
# nonsense that clutters it up and that they have a preferred starting
# directory where they keep the stuff they actually care about
# we only do this if the user is opening a shell at $HOME
if test $PWD = $HOME; or test $PWD = $NICE_HOME;
	cd $NICE_HOME || cd
end

if test -f $HOME/.asdf/asdf.fish
	source $HOME/.asdf/asdf.fish
else if test -f /opt/asdf-vm/asdf.fish
	source /opt/asdf-vm/asdf.fish
end

# load a per-device config last so anything can be overridden
for cf in config.fish .hidden/config.fish
	set f $ENV_PATH/$cf
	test -f $f && source $f
end

mkdir -p $NOTES_PATH $USER_LOGS_PATH $SCROTS_PATH

# start a tmux session by default if possible and we're not already in
# a terminal multiplexer
if has_command tmux && string match -v -q '*tmux*' $TERM && string match -v -q '*screen*' $TERM
	tmux start-server
	tmux attach -t default || tmux new -s default
end

if set -q $__HM_SESS_VARS_SOURCED
	exec bash -c "source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh; exec fish"
end
