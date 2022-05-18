# sane ls colors
set --export --universal LS_COLORS 'ow=01;36;40'
set --export --universal EXA_COLORS '*=0'

# iex history
set --export --universal ERL_AFLAGS "-kernel shell_history enabled -kernel shell_history_file_bytes 1024000"

set --export --universal TERMINAL kitty
set --export --universal TERMINAL_ARGS '--single-instance'
set --export --universal BROWSER firefox-developer-edition

set --export --universal PAGER less
set --export --universal LESS "-r"

set --export --universal MANPAGER 'env MANWIDTH="" nvim --cmd "let g:prosession_on_startup=0" +Man!'

if command --search --quiet hx
	set --export --universal EDITOR hx
	set --export --universal VISUAL hx
else if command --search --quiet nvim
	set --export --universal EDITOR nvim
	set --export --universal VISUAL nvim
else if command --search --quiet vim
	set --export --universal EDITOR vim
	set --export --universal VISUAL vim
else if command --search --quiet vi
	set --export --universal EDITOR vi
	set --export --universal VISUAL vi
end

set --export --universal SOPS_AGE_KEY_FILE "$XDG_CONFIG_HOME/sops/age/keys.txt"

# has_command fd && set -Ux FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
