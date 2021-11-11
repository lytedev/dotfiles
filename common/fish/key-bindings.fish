function fish_user_key_bindings
	test -f $HOME/.fzf/shell/key-bindings.fish && source $HOME/.fzf/shell/key-bindings.fish

	type -q fzf_key_bindings && fzf_key_bindings
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

	bind -M insert \cv edit_command_buffer
	bind -M default \cv edit_command_buffer

	bind -M insert \cs tmuxswitcher
end
