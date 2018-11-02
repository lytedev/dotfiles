" vim compatibility
let $vimdir = $HOME.'/.vim'
if has('nvim')
	let $vimdir = $HOME.'/.config/nvim'
endif

" utf8 encoding
if has('vim_starting')
	set encoding=utf8
endif

" os detection functions
silent function! OSX()
	return has('macunix')
endfunction
silent function! LINUX()
	return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
	return (has('win32') || has('win64'))
endfunction

" load a per-environment file if one exists
if filereadable(expand('$HOME/.env_init.vim'))
	source "$HOME/.env_init.vim"
endif

let pluginmanagerfile=$vimdir.'/plugin-manager.vim'
exec 'source ' . pluginmanagerfile

" initialize plugin manager
if has('nvim')
	call plug#begin('~/.config/nvim/bundle')
else
	call plug#begin('~/.vim/bundle')
endif

let pluginsfile=$vimdir.'/plugins.vim'
exec 'source ' . pluginsfile

call plug#end()

filetype on
filetype indent on
filetype plugin on

let settingsfile=$vimdir.'/settings.vim'
exec 'source ' . settingsfile

let commandsfile=$vimdir.'/commands.vim'
exec 'source ' . commandsfile

let bindingsfile=$vimdir.'/bindings.vim'
exec 'source ' . bindingsfile
