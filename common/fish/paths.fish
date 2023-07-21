set --export --universal XDG_CONFIG_HOME $HOME/.config
set --export --universal XDG_CACHE_HOME $HOME/.cache
set --export --universal XDG_DATA_HOME $HOME/.local/share
set --export --universal XDG_STATE_HOME $HOME/.local/state

set --export --universal DOTFILES_PATH $XDG_CONFIG_HOME/lytedev-dotfiles
set --export --universal ENV_PATH $XDG_CONFIG_HOME/lytedev-env
set --export --universal FISH_PATH $XDG_CONFIG_HOME/fish

if not set --query NICE_HOME
	# default NICE_HOME to HOME
	set --export --universal NICE_HOME $HOME

	# if HOME ends with a dir called .home, assume that NICE_HOME is HOME's parent dir
	test (basename $HOME) = .home && set --export --universal NICE_HOME (realpath $HOME/..)
end

# reset paths on shell start
set --erase --global fish_user_paths

# add NICE_HOME to CDPATH (see `man 1 cd`)
set --erase CDPATH
set --export --global CDPATH . $NICE_HOME

set --export --universal GOPATH $HOME/.go
set --export --universal GOBIN $GOPATH/bin

set paths_candidates \
	$HOME/.asdf/shims \
	/opt/homebrew/bin \
	/opt/homebrew/sbin \
	$DOTFILES_PATH/common/bin \
	$HOME/.bin \
	$HOME/.local/bin \
	$HOME/.deno/bin \
	$HOME/.yarn/bin \
	$HOME/.nimble/bin \
	$HOME/.cargo/bin \
	$HOME/.krew/bin \
	$HOME/.go \
	$GOPATH/bin \
	$HOME/.netlify/helper/bin

# add candidate paths to PATH if they exist
for d in $paths_candidates $ENV_PATH/*/bin
	test -d $d && set --append --export --global fish_user_paths $d
end

command --search --quiet python && \
	set --append --export --global fish_user_paths (python -m site --user-base)/bin

command --search --quiet ruby && \
	set --append --export --global fish_user_paths (ruby -e 'print Gem.user_dir')/bin

set --export --universal NOTES_PATH $NICE_HOME/doc/notes
set --export --universal SCROTS_PATH $NICE_HOME/img/scrots
set --export --universal USER_LOGS_PATH $NICE_HOME/doc/logs

set --export --universal XDG_DESKTOP_DIR $HOME/desktop
set --export --universal XDG_PUBLICSHARE_DIR $HOME/public
set --export --universal XDG_TEMPLATES_DIR $HOME/templates

set --export --universal XDG_DOCUMENTS_DIR $NICE_HOME/doc
set --export --universal XDG_DOWNLOAD_DIR $NICE_HOME/dl
set --export --universal XDG_MUSIC_DIR $NICE_HOME/music
set --export --universal XDG_PICTURES_DIR $NICE_HOME/img
set --export --universal XDG_VIDEOS_DIR $NICE_HOME/video
set --export --universal XDG_GAMES_DIR $NICE_HOME/games

set --export --universal NOTES_PATH $XDG_DOCUMENTS_DIR/notes
set --export --universal USER_LOGS_PATH $XDG_DOCUMENTS_DIR/logs
set --export --universal SCROTS_PATH $XDG_PICTURES_DIR/scrots