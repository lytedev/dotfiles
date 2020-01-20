#!/usr/bin/env fish

set -U XDG_CONFIG_HOME $HOME/.config
set -U DOTFILES_PATH $XDG_CONFIG_HOME/dotfiles
set -U ENV_PATH $HOME/.env

$DOTFILES_PATH/bin/lib/colors/shell
$DOTFILES_PATH/bin/prelude

function source_if_exists
	test -f $ENV_PATH/$argv[1] && source $argv[1]
end

function maybe_source_env_file
	source_if_exists $ENV_PATH/$argv[1]
end

function has_command
	command -v $argv[1] 2>&1 >/dev/null
end

# TODO: better logic for auto-detecting alternative home directories?
# 1. check dirname(basename $HOME)) matches username
# 2. check if /home/$username
set -U NICE_HOME $HOME
test (basename $HOME) = .home && set -U NICE_HOME (realpath $HOME/..)
test -e $HOME/.nice_home && set -U NICE_HOME (cat $HOME/.nice_home)
test -e $ENV_PATH/.nice_home && set -U NICE_HOME (cat $ENV_PATH/.nice_home)

# setup paths
source $DOTFILES_PATH/apps/shell/fish/paths.fish

# stop parsing here on a non-interactive shell
status --is-interactive || exit

# TODO: autocompletions?
# TODO: ctrl-r history fzf
# TODO: ctrl-p files fzf
# TODO: forever history ignoring certain commands
# TODO: per-env configuration

source $DOTFILES_PATH/apps/shell/fish/key-bindings.fish
source $DOTFILES_PATH/apps/shell/fish/colors.fish
source $DOTFILES_PATH/apps/shell/fish/prompt.fish
source $DOTFILES_PATH/apps/shell/fish/aliases.fish

set -U _JAVA_AWT_WM_NONREPARENTING 1
# set -U LS_COLORS 'ow=01;36;40'
set -U LESS -x2 # less tab size of 2 spaces
set -U TERMINAL kitty
set -U BROWSER firefox-developer-edition
set -U ERL_AFLAGS "-kernel shell_history enabled -kernel shell_history_file_bytes 1024000" # iex history

# set our EDITOR to neovim if we've got it
set -U EDITOR vim
if command -v nvim 2>&1 >/dev/null
	alias vim nvim
	alias ovim 'command vim'
	set -U EDITOR nvim
end

# load a per-device config last so anything can be overridden
# TODO: this does not work quite right for fish?
maybe_source_env_file config.fish
maybe_source_env_file .hidden/config.fish

mkdir -p $NOTES_PATH

command -v fd 2>&1 >/dev/null && set -U FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'

# we assume the user uses "$HOME" to just store their mess of dotfiles and other
# nonsense that clutters it up and that they have a preferred starting
# directory where they keep the stuff they actually care about
# we only do this if the user is opening a shell at $HOME
if test $PWD = $HOME; or test $PWD = $NICE_HOME;
	cd $NICE_HOME || cd
end

test -f ~/.fzf/shell/key-bindings.fish && source ~/.fzf/shell/key-bindings.fish

if test -f $HOME/.asdf/asdf.fish
	source $HOME/.asdf/asdf.fish
else if test -f /opt/asdf-vm/asdf.fish
	source /opt/asdf-vm/asdf.fish
end
