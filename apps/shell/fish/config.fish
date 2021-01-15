#!/usr/bin/env fish

set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux DOTFILES_PATH $XDG_CONFIG_HOME/lytedev-dotfiles
set -Ux ENV_PATH $HOME/.env

source $DOTFILES_PATH/apps/shell/fish/paths.fish
source $DOTFILES_PATH/apps/nnn/config.fish

status --is-interactive || exit

for f in key-bindings colors prompt aliases
	source $DOTFILES_PATH/apps/shell/fish/$f.fish
end

set -Ux _JAVA_AWT_WM_NONREPARENTING 1
set -Ux TERMINAL kitty
set -Ux BROWSER firefox-developer-edition
set -Ux ERL_AFLAGS "-kernel shell_history enabled -kernel shell_history_file_bytes 1024000" # iex history
set -Ux LESS "-r"
set -Ux LS_COLORS 'ow=01;36;40' # more sane ls colors
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux PAGER less
set -Ux MANPAGER 'env MANWIDTH="" nvim --cmd "let g:prosession_on_startup=0" +Man!'

has_command fd && set -Ux FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'

test -f ~/.fzf/shell/key-bindings.fish && source ~/.fzf/shell/key-bindings.fish

function fish_greeting;
	set_color -b black brblack
	printf "%s@%s %s\n" $USER (hostname) (date)
	printf "%6d   processes running\n" (ps -aux | wc -l)
	printf "%6sGB memory available\n" (free -g | grep '^Mem:' | tr -s ' ' | cut -d ' ' -f7)
	printf "%6d   PTYs open\n" (cat /proc/sys/kernel/pty/nr)
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

if set -q $__HM_SESS_VARS_SOURCED; and test -f $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
	exec bash -c "source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh; exec fish"
end

# load a per-device, secret config last so anything can be overridden
for cf in config.fish .hidden/config.fish
	set f $ENV_PATH/$cf
	test -f $f && source $f
end

# TODO: completion
function src-hidden-dir
	not scount $argv && echo "No directory specified" && exit 1
	set f $ENV_PATH/.hidden/fish.d/$argv[1]/config.fish
	echo "Checking $f..."
	test -f $f && source $f
end
test -d $ENV_PATH/.hidden/fish.d && \
	complete --command src-hidden-dir -a \
	"(pushd $NICE_HOME && fd . $ENV_PATH/.hidden/fish.d/ --max-depth 1 --min-depth 1 -x ls -p && popd)"

mkdir -p $NOTES_PATH $USER_LOGS_PATH $SCROTS_PATH

# if status is-interactive; and not set -q TMUX
# 	exec tmux
# end
