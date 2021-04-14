#!/usr/bin/env fish

function fish_user_key_bindings
	# has_command fd && set -Ux FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'

	test -f $HOME/.fzf/shell/key-bindings.fish && source $HOME/.fzf/shell/key-bindings.fish

	fzf_key_bindings
	fish_vi_key_bindings insert --no-erase

	set vi_esc "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"

	bind -M insert jk $vi_esc
	bind -M insert jK $vi_esc
	bind -M insert Jk $vi_esc
	bind -M insert JK $vi_esc
	bind -M insert jj $vi_esc
	bind -M insert jJ $vi_esc
	bind -M insert Jj $vi_esc
	bind -M insert JJ $vi_esc

	bind -M insert \cp up-or-search
	bind -M insert \cn down-or-search
	bind -M insert \ce end-of-line
	bind -M insert \ca beginning-of-line
	bind -M insert \cw forward-word

	bind -M insert \cv edit_command_buffer
	bind -M default \cv edit_command_buffer

	bind -M insert \ee false
  bind -M insert \ev false
	bind -M default \ee false
  bind -M default \ev false

	bind -M insert --erase \ct
	bind -M default --erase \ct
	bind --erase \c\t
	bind --erase \cs
	bind --erase btab
	bind --erase --preset -M visual -k btab
	bind --erase --preset -M insert -k btab
	bind --erase --preset -M default -k btab
	bind --erase --preset -k btab
	bind --erase -M visual -k btab
	bind --erase -M insert -k btab
	bind --erase -M default -k btab
	bind --erase -k btab

	bind --erase \cs
	bind --erase -M insert \cs
	bind --erase -M default \cs

	bind -M insert \cs 'tmux info && tmux attach -t default || tmux new-session -s default'
	bind -M default \cs 'tmux info && tmux attach -t default || tmux new-session -s default'
	bind -M insert \ct 'tmux info && tmux new-window -t default || tmux new-session -s default'
	bind -M default \ct 'tmux info && tmux new-window -t default || tmux new-session -s default'
end
