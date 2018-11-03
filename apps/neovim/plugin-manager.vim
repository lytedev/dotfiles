" install plugin manager if needed
augroup PluginManagerInstaller
	if has('nvim')
		if empty(glob('~/.config/nvim/autoload/plug.vim'))
			silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
			autocmd VimEnter * PlugInstall
		endif
	else
		if empty(glob('~/.vim/autoload/plug.vim'))
			silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
			autocmd VimEnter * PlugInstall
		endif
	end
augroup End

