#!/usr/bin/env fish

set -U fish_user_paths $HOME/.go $GOPATH/bin $DOTFILES_PATH/bin $ENV_PATH/bin $HOME/.bin $HOME/.cargo/bin $HOME/.yarn/bin
test -d $HOME/.local/bin && set -U fish_user_paths $HOME/.local/bin $fish_user_paths
test -d $HOME/.bin && set -U fish_user_paths $HOME/.local/bin $fish_user_paths

command -v python 2>&1 >/dev/null && set -U fish_user_paths (python -m site --user-base)"/bin" $fish_user_paths
command -v ruby 2>&1 >/dev/null && set -U fish_user_paths (ruby -e 'print Gem.user_dir')"/bin" $fish_user_paths

set -U NOTES_PATH $NICE_HOME/doc/notes

function _make_paths; mkdir -p $NOTES_PATH; end
