scriptencoding utf-8
set fileencoding=utf8

let $vimdir = $HOME.'/.vim'
if has('nvim')
	let $vimdir = $XDG_CONFIG_HOME.'/nvim'
endif

if filereadable("$ENV_PATH/vim")
	source "$ENV_PATH/vim"
endif

call plug#begin($vimdir.'/bundle')
source $vimdir/plugins.vim
source $vimdir/airline.vim
call plug#end()

filetype on
filetype indent on
filetype plugin on

source $vimdir/settings.vim
source $vimdir/commands.vim
source $vimdir/bindings.vim

if filereadable("$ENV_PATH/vim-after")
	source "$ENV_PATH/vim-after"
endif
