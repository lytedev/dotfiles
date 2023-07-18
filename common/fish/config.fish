source (dirname (status --current-filename))/paths.fish

for s in $ENV_PATH/*/config.d.fish
	source $s (dirname $s)
end

for f in vars colors functions
	source $FISH_PATH/$f.fish
end

if has_command rtx
	rtx activate fish | source
else if has_command brew && test -f (brew --prefix asdf)/libexec/asdf.fish
	set --universal --export ASDF_DIR (brew --prefix asdf)
	source (brew --prefix asdf)/libexec/asdf.fish
else if test -f $HOME/.asdf/asdf.fish
	source $HOME/.asdf/asdf.fish
else if test -f /opt/asdf-vm/asdf.fish
	source /opt/asdf-vm/asdf.fish
end

if test -f $HOME/.nix-profile/etc/profile.d/nix.fish
	. $HOME/.nix-profile/etc/profile.d/nix.fish
end

if has_command nnn
	source $DOTFILES_PATH/common/nnn/config.fish
end

# everything after this is ONLY relevant to interactive shells
status --is-interactive || exit

for f in prompt key-bindings
	source $FISH_PATH/$f.fish
end

if test -f /usr/share/password-store/extensions/otp.bash
	source $FISH_PATH/pass-otp-completions.fish
end

if set -q KITTY_INSTALLATION_DIR
	set --global KITTY_SHELL_INTEGRATION enabled
	source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
	set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
end

test $PWD = $HOME && begin
	cd $NICE_HOME || cd
end

# If we're running the shell interactively from inside Kitty, assume that we will be using Kitty's multiplexing features
# Otherwise, assume we're in a context that is not capable of "native" multiplexing features and run everything inside Zellij
if not set --query ZELLIJ && set --query FISH_START_ZELLIJ
	# simulate auto attach
  zellij attach -c
	# simulate auto kill
  kill $fish_pid
else if not set --query TMUX && set --query FISH_START_TMUX
	tmux att -t default || tmux new -s default
end