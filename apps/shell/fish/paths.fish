#!/usr/bin/env fish

set -Ux GOPATH $HOME/.go

set -U fish_user_paths \
	$HOME/.go \
	$GOPATH/bin \
	$DOTFILES_PATH/bin \
	$ENV_PATH/bin \
	$ENV_PATH/.hidden/bin \
	$HOME/.bin \
	$HOME/.cargo/bin \
	$HOME/.nimble/bin \
	$HOME/.yarn/bin

test -d $HOME/.local/bin && set -U fish_user_paths $HOME/.local/bin $fish_user_paths
test -d $HOME/.bin && set -U fish_user_paths $HOME/.local/bin $fish_user_paths

has_command python && set -U fish_user_paths (python -m site --user-base)"/bin" $fish_user_paths
has_command ruby && set -U fish_user_paths (ruby -e 'print Gem.user_dir')"/bin" $fish_user_paths

if test (dirname (basename $HOME)) = $USER
	set -Ux NICE_HOME $HOME
else
	set -Ux NICE_HOME /home/$USER
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

set -Ux NOTES_PATH $XDG_DOCUMENTS_DIR/notes
set -Ux USER_LOGS_PATH $XDG_DOCUMENTS_DIR/logs
set -Ux SCROTS_PATH $XDG_PICTURES_DIR/scrots
