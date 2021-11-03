source (dirname (status --current-filename))/paths.fish

for s in $ENV_PATH/*/config.d.fish
	source $s (dirname $s)
end

status --is-interactive || exit

for f in vars colors prompt functions key-bindings
	source $FISH_PATH/$f.fish
end

if has_command brew && test -f (brew --prefix asdf)/lib/asdf.fish
	set -Ux ASDF_DIR (brew --prefix asdf)
	source (brew --prefix asdf)/lib/asdf.fish
else if test -f $HOME/.asdf/asdf.fish
	source $HOME/.asdf/asdf.fish
else if test -f /opt/asdf-vm/asdf.fish
	source /opt/asdf-vm/asdf.fish
end

test $PWD = $HOME && begin; cd $NICE_HOME || cd; end
