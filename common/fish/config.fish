#!/usr/bin/env fish

set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux DOTFILES_PATH $XDG_CONFIG_HOME/lytedev-dotfiles
set -Ux ENV_PATH $XDG_CONFIG_HOME/lytedev-env
set -Ux FISH_PATH $XDG_CONFIG_HOME/fish

source $FISH_PATH/paths.fish

for s in $ENV_PATH/*/config.d.fish
	source $s (dirname $s)
end

status --is-interactive || exit

for f in key-bindings colors prompt aliases
	source $FISH_PATH/$f.fish
end

has_command nnn && source $DOTFILES_PATH/common/nnn/config.fish

set -Ux _JAVA_AWT_WM_NONREPARENTING 1
set -Ux TERMINAL kitty
set -Ux BROWSER firefox-nightly
set -Ux ERL_AFLAGS "-kernel shell_history enabled -kernel shell_history_file_bytes 1024000" # iex history
set -Ux LESS "-r"
set -Ux LS_COLORS 'ow=01;36;40' # more sane ls colors
set -Ux EXA_COLORS '*=0'
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux PAGER less
set -Ux MANPAGER 'env MANWIDTH="" nvim --cmd "let g:prosession_on_startup=0" +Man!'

function fish_greeting;
	set_color -b black brblack
	printf "%s@%s %s\n" $USER (hostname) (date)
	printf "%6d   processes running\n" (ps -aux | wc -l)
	has_command free && printf "%6sGB memory available\n" (free -g | grep '^Mem:' | tr -s ' ' | cut -d ' ' -f7)
	test -f /proc/sys/kernel/pty/nr && printf "%6d   PTYs open\n" (cat /proc/sys/kernel/pty/nr)
end

if has_command brew && test -f (brew --prefix asdf)/lib/asdf.fish
	set -Ux ASDF_DIR (brew --prefix asdf)
	source (brew --prefix asdf)/lib/asdf.fish
else if test -f $HOME/.asdf/asdf.fish
	source $HOME/.asdf/asdf.fish
else if test -f /opt/asdf-vm/asdf.fish
	source /opt/asdf-vm/asdf.fish
end

# assume the user uses "$HOME" to just store their mess of dotfiles and other
# nonsense that clutters it up and that they have a preferred starting
# directory where they keep the stuff they actually care about
# we only do this if the user is opening a shell at $HOME
if test $PWD = $HOME; or test $PWD = $NICE_HOME;
	cd $NICE_HOME || cd
end

# test -f '/home/daniel/.home/.config/netlify/helper/path.fish.inc' && source '/home/daniel/.home/.config/netlify/helper/path.fish.inc'
