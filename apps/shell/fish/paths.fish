#!/usr/bin/env fish

set -U fish_user_paths \
	$HOME/.go \
	$GOPATH/bin \
	$DOTFILES_PATH/bin \
	$ENV_PATH/bin \
	$HOME/.bin \
	$HOME/.cargo/bin \
	$HOME/.yarn/bin

test -d $HOME/.local/bin && set -U fish_user_paths $HOME/.local/bin $fish_user_paths
test -d $HOME/.bin && set -U fish_user_paths $HOME/.local/bin $fish_user_paths

has_command python && set -U fish_user_paths (python -m site --user-base)"/bin" $fish_user_paths
has_command ruby && set -U fish_user_paths (ruby -e 'print Gem.user_dir')"/bin" $fish_user_paths

if test (dirname (basename $HOME)) = $USER
	set -U NICE_HOME $HOME
else
	set -U NICE_HOME /home/$USER
end

for p in $NICE_HOME $HOME $ENV_PATH
	test -f $p/.nice_home && set -U NICE_HOME (cat $p/.nice_home)
end

set -U NOTES_PATH $NICE_HOME/doc/notes
set -U SCROTS_PATH $NICE_HOME/img/scrots
set -U USER_LOGS_PATH $NICE_HOME/doc/logs
