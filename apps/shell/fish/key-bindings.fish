#!/usr/bin/env fish

function fish_user_key_bindings
	fish_vi_key_bindings
	fzf_key_bindings

	set vi_esc "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
	bind -M insert jk $vi_esc
	bind -M insert Jk $vi_esc
	bind -M insert JK $vi_esc
	bind -M insert jj $vi_esc
	bind -M insert Jj $vi_esc
	bind -M insert JJ $vi_esc
	bind -M insert JJ $vi_esc

	bind -M insert \cf 'fzf-cd-widget'
end
