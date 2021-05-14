#!/usr/bin/env fish

set -Ux GOPATH $HOME/.go

set -g fish_user_paths \
	$HOME/.go \
	$GOPATH/bin \
	$DOTFILES_PATH/common/bin \
	$HOME/.bin \
	$HOME/.cargo/bin \
	$HOME/.nimble/bin \
	$HOME/.yarn/bin \
	$HOME/.netlify/helper/bin

for d in $ENV_PATH/*/bin
	test -d $d && set -ga fish_user_paths $d
end

test -d $HOME/.local/bin && set -ga fish_user_paths $HOME/.local/bin
test -d $HOME/.bin && set -ga fish_user_paths $HOME/.local/bin

has_command python && set -ga fish_user_paths (python -m site --user-base)/bin
has_command ruby && set -ga fish_user_paths (ruby -e 'print Gem.user_dir')/bin

if set -q NICE_HOME
else
	set -Ux NICE_HOME $HOME
	test (basename $HOME) = .home && set -Ux NICE_HOME (realpath $HOME/..)
	test -f $HOME/.nice_home && set -Ux NICE_HOME (cat $HOME/.nice_home)
	test -f $ENV_PATH/.nice_home && set -Ux NICE_HOME (cat $ENV_PATH/.nice_home)
end
for p in $NICE_HOME $HOME $ENV_PATH
	test -f $p/.nice_home && set -Ux NICE_HOME (cat $p/.nice_home)
end

set -Ux NOTES_PATH $NICE_HOME/doc/notes
set -Ux SCROTS_PATH $NICE_HOME/img/scrots
set -Ux USER_LOGS_PATH $NICE_HOME/doc/logs

set -Ux XDG_DESKTOP_DIR $HOME/desktop
set -Ux XDG_PUBLICSHARE_DIR $HOME/public
set -Ux XDG_TEMPLATES_DIR $HOME/templates

set -Ux XDG_DOCUMENTS_DIR $NICE_HOME/doc
set -Ux XDG_DOWNLOAD_DIR $NICE_HOME/dl
set -Ux XDG_MUSIC_DIR $NICE_HOME/music
set -Ux XDG_PICTURES_DIR $NICE_HOME/img
set -Ux XDG_VIDEOS_DIR $NICE_HOME/video
set -Ux XDG_GAMES_DIR $NICE_HOME/games

set -Ux TMUX_PLUGIN_MANAGER_PATH $XDG_CONFIG_HOME/tmux/plugins/
set -Ux NOTES_PATH $XDG_DOCUMENTS_DIR/notes
set -Ux USER_LOGS_PATH $XDG_DOCUMENTS_DIR/logs
set -Ux SCROTS_PATH $XDG_PICTURES_DIR/scrots

if test -n "$NIX_PATH"
	set NIX_PATH :
end
set -Ux NIX_PATH $HOME/.nix-defexpr/channels:$NIX_PATH
