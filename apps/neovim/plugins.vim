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

let g:ale_completion_enabled = 1

" check if we're using vim as the manpage viewer before loading session plugins
if exists('asmanviewer')
	let g:prosession_dir = '/dev/null'
else
	Plug 'tpope/vim-obsession' " session ease-of-use
	Plug 'dhruvasagar/vim-prosession' " more session ease-of-use
	let g:prosession_dir = '~/.config/nvim/session/'
endif

Plug 'junegunn/vim-plug' " plugin manager should manage itself
Plug 'vim-airline/vim-airline' " status line
Plug 'vim-airline/vim-airline-themes' " more minimal status line
Plug 'nathanaelkane/vim-indent-guides' " indentation guides
Plug 'w0rp/ale' " syntax checker
Plug 'SirVer/ultisnips'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} " fuzzy file finding
Plug 'junegunn/fzf.vim' " helpers for using fzf in vim
Plug 'bkad/CamelCaseMotion' " camel case and underscore word movements
Plug 'vim-scripts/LargeFile' " gracefully handle very large files
Plug 'tpope/vim-commentary' " toggle comments in code easily
Plug 'tpope/vim-repeat' " better vim repeating for plugin-provided actions
Plug 'vim-scripts/SyntaxRange' " defined different syntax ranges in a file for highlighting
Plug 'tmux-plugins/vim-tmux-focus-events' " allow transitions within tmux
Plug 'christoomey/vim-tmux-navigator' " allow transitions within tmux
Plug 'godlygeek/tabular' " align text
Plug 'lytedev/vim-superman' " view man pages with vim
Plug 'tpope/vim-surround' " quickly modify text surrounding objects
Plug 'tpope/vim-speeddating' " vim knows about date-like text objects
Plug 'tpope/vim-fugitive' " vim git commands
Plug 'michaeljsmith/vim-indent-object' " adds an indentation level text object
Plug 'wellle/targets.vim' " adds some more handy text objects
Plug 'dbakker/vim-projectroot' " adds helper functions for getting to a project's root directory
Plug 'junegunn/goyo.vim' " better distraction-free editing
Plug 'editorconfig/editorconfig-vim' " loads project-specific editor settings
Plug 'sheerun/vim-polyglot' " vim plugin loader for many languages
Plug 'leafo/moonscript-vim', {'for': ['moon', 'moonscript']}
Plug 'OmniSharp/omnisharp-vim', {'for': ['cs']}
Plug 'junegunn/vim-peekaboo'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-eunuch'
