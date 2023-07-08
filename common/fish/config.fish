source (dirname (status --current-filename))/paths.fish

for s in $ENV_PATH/*/config.d.fish
	source $s (dirname $s)
end

status --is-interactive || exit

for f in vars colors prompt functions key-bindings
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

if test -f /usr/share/password-store/extensions/otp.bash
	source $FISH_PATH/pass-otp-completions.fish
end

if test -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
	set nix_profiles /nix/var/nix/profiles/default $HOME/.nix-profile
	set --export --universal NIX_PROFILES "$nix_profiles"

	if set -q NIX_SSL_CERT_FILE
		:
	elif test -e /etc/ssl/certs/ca-certificates.crt
		set --export --universal NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
	else
		for p in (string split $NIX_PROFILES)
			test -e $p/etc/ssl/certs/ca-bundle.crt && \
				set --export --universal NIX_SSL_CERT_FILE=$p/etc/ssl/certs/ca-bundle.crt
		end
	end

	set --prepend --export --global fish_user_paths $HOME/.nix-profile/bin /nix/var/nix/profiles/default/bin
end

if set -q KITTY_INSTALLATION_DIR
	set --global KITTY_SHELL_INTEGRATION enabled
	source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
	set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
end

if has_command nnn
	source $DOTFILES_PATH/common/nnn/config.fish
end

test $PWD = $HOME && begin
	cd $NICE_HOME || cd
end

# If we're running the shell interactively from inside Kitty, assume that we will be using Kitty's multiplexing features
# Otherwise, assume we're in a context that is not capable of "native" multiplexing features and run everything inside Zellij
if set --query FISH_START_ZELLIJ
	set ZELLIJ_AUTO_ATTACH true
	set ZELLIJ_AUTO_EXIT true
  eval (zellij setup --generate-auto-start fish | string collect)
else if set --query FISH_START_TMUX
	tmux att -t default || tmux new -s default
end