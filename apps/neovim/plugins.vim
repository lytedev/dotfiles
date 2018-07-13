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

" initialize plugin manager
if has('nvim')
	call plug#begin('~/.config/nvim/bundle')
else
	call plug#begin('~/.vim/bundle')
endif

" let plugin manager manage itself
Plug 'junegunn/vim-plug'

" check if we're using vim as the manpage viewer before loading session plugins
if exists('asmanviewer')
	let g:prosession_dir = '/dev/null'
else
	Plug 'tpope/vim-obsession' " session ease-of-use
	Plug 'dhruvasagar/vim-prosession' " more session ease-of-use
	let g:prosession_dir = '~/.config/nvim/session/'
endif

Plug 'vim-airline/vim-airline' " status line
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1 " automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#fnamemod = ':t'
" set laststatus=2 " always show statusline
" set noshowmode " hides default mode
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_left_sep = ''
let g:airline#extensions#tabline#buffers_label = ''

Plug 'vim-airline/vim-airline-themes' " more minimal status line
let g:airline_mode_map = {
		\ '__' : '-',
		\ 'n'  : 'N',
		\ 'i'  : 'I',
		\ 'R'  : 'R',
		\ 'c'  : 'C',
		\ 'v'  : 'V',
		\ 'V'  : 'V',
		\ '' : 'V',
		\ 's'  : 'S',
		\ 'S'  : 'S',
		\ '' : 'S',
		\ }

Plug 'nathanaelkane/vim-indent-guides' " indentation guides
let g:indent_guide_auto_colors = 1
let g:indent_guides_enable_on_vim_startup = 1

Plug 'w0rp/ale' " syntax checker
let g:ale_completion_enabled = 1
" let g:ale_sign_column_always = 0
" let g:ale_set_signs = 0
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign

" Plug 'neomake/neomake' " syntax checker

if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} " fuzzy file finding
Plug 'junegunn/fzf.vim' " helpers for using fzf in vim
let g:fzf_layout = { 'window': 'enew' }

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

" language-specific
" Elixir
Plug 'slashmili/alchemist.vim', {'for': ['elixir', 'exs', 'ex']}

call plug#end()

" call neomake#configure#automake('nrwi', 500)
