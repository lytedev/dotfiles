function fish_user_key_bindings
	set --export SKIM_TMUX_HEIGHT ""
	set --export --universal SKIM_ALT_C_COMMAND "fd --hidden --type directory"
	set --export --universal SKIM_CTRL_T_COMMAND "fd --hidden"
	command -q sk && begin
		functions | grep skim_key_bindings &>/dev/null && skim_key_bindings


		bind -M insert \cg skim-cd-widget
	end
	fish_vi_key_bindings insert --no-erase

	set --universal fish_cursor_default block
	set --universal fish_cursor_insert line
	set --universal fish_cursor_block block

	fish_vi_cursor
	set --universal fish_vi_force_cursor 1

	# bind "jk" from insert mode to return to normal mode
	set normal_mode "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
	bind -M insert jk $normal_mode
	bind -M insert jK $normal_mode
	bind -M insert Jk $normal_mode
	bind -M insert JK $normal_mode
	bind -M insert jj $normal_mode
	bind -M insert jJ $normal_mode
	bind -M insert Jj $normal_mode
	bind -M insert JJ $normal_mode

	bind -M insert \cp up-or-search
	bind -M insert \cn down-or-search
	bind -M insert \ce end-of-line
	bind -M insert \ca beginning-of-line

	bind -M insert \cv edit_command_buffer
	bind -M default \cv edit_command_buffer
end
