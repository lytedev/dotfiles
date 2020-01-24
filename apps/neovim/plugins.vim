" install plugin manager if needed
augroup PluginManagerInstaller
	if empty(glob("$vimdir/autoload/plug.vim"))
		silent !curl -fLo "$vimdir/autoload/plug.vim" --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		autocmd VimEnter * PlugInstall
	endif
augroup End

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1 " automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_left_sep = ''
let g:airline#extensions#tabline#buffers_label = ''

let g:airline_mode_map = {
	\ '__' : '-',
	\ 'n'  : 'N',
	\ 'i'  : 'I',
	\ 'R'  : 'R',
	\ 'T'  : 'T',
	\ 't'  : 'T',
	\ 'c'  : 'C',
	\ 'v'  : 'V',
	\ 'V'  : 'V',
	\ '' : 'V',
	\ 's'  : 'S',
	\ 'S'  : 'S',
	\ '' : 'S',
	\ }

let g:indent_guide_auto_colors = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:prosession_dir = $vimdir."/session/"

let g:polyglot_disabled = ['cue', 'cuesheet']

" let g:fzf_layout = { 'window': 'enew' }

" check if we're using vim as the manpage viewer before loading session plugins
if exists('asmanviewer')
	let g:prosession_dir = '/dev/null'
else
	Plug 'tpope/vim-obsession'        " session ease-of-use
	Plug 'dhruvasagar/vim-prosession' " more session ease-of-use
endif

Plug 'junegunn/vim-plug'                                        " plugin manager should manage itself
Plug 'vim-airline/vim-airline'                                  " status line
Plug 'vim-airline/vim-airline-themes'                           " more minimal status line
Plug 'nathanaelkane/vim-indent-guides'                          " indentation guides
Plug 'SirVer/ultisnips'                                         " snippet manager
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} " fuzzy file finding
Plug 'junegunn/fzf.vim'                                         " helpers for using fzf in vim
Plug 'bkad/CamelCaseMotion'                                     " camel case and underscore word movements
Plug 'vim-scripts/LargeFile'                                    " gracefully handle very large files
Plug 'tpope/vim-commentary'                                     " toggle comments in code easily
Plug 'tpope/vim-repeat'                                         " better vim repeating for plugin-provided actions
Plug 'vim-scripts/SyntaxRange'                                  " defined different syntax ranges in a file for highlighting
Plug 'tmux-plugins/vim-tmux-focus-events'                       " allow transitions within tmux
Plug 'christoomey/vim-tmux-navigator'                           " allow transitions within tmux
Plug 'godlygeek/tabular'                                        " align text
Plug 'lytedev/vim-superman'                                     " view man pages with vim
Plug 'machakann/vim-sandwich'                                   " quickly modify text surrounding objects
Plug 'tpope/vim-speeddating'                                    " vim knows about date-like text objects
Plug 'tpope/vim-fugitive'                                       " vim git commands
Plug 'michaeljsmith/vim-indent-object'                          " adds an indentation level text object
Plug 'wellle/targets.vim'                                       " adds some more handy text objects
Plug 'dbakker/vim-projectroot'                                  " adds helper functions for getting to a project's root directory
Plug 'junegunn/goyo.vim'                                        " better distraction-free editing
Plug 'tpope/vim-sleuth'                                         " try and detect indent method
Plug 'editorconfig/editorconfig-vim'                            " loads project-specific editor settings
Plug 'leafo/moonscript-vim', {'for': ['moon', 'moonscript']}    " moonscript language
Plug 'OmniSharp/omnisharp-vim', {'for': ['cs']}                 " C# language
Plug 'scrooloose/nerdtree'                                      " file browser
Plug 'tpope/vim-eunuch'                                         " unix helper commands
Plug 'mbbill/undotree'                                          " undo tree visualizer
" Plug 'junegunn/vim-peekaboo'                                  " preview registers

" language support
Plug 'sheerun/vim-polyglot'                                     " vim plugin loader for many languages
Plug 'leafo/moonscript-vim', {'for': ['moon', 'moonscript']}    " moonscript language
Plug 'OmniSharp/omnisharp-vim', {'for': ['cs']}                 " C# language
Plug 'neoclide/coc.nvim', {'branch': 'release'}                 " language server interface
Plug 'JakeBecker/elixir-ls', {'for': ['elixir', 'eelixir'], 'do': { -> g:elixirls.compile() }}
Plug 'tpope/vim-dadbod'                                         " vim
Plug 'lytedev/elm-vim', {'for': ['elm']}                        " elm lang
Plug 'google/vim-jsonnet', {'for': ['jsonnet', 'libsonnet']}    " jsonnet
Plug 'sirtaj/vim-openscad', {'for': ['scad']}                   " openscad
Plug 'jjo/vim-cue'
" Plug 'ssh://git@git.lyte.dev:2222/lytedev/vim-lytlang.git'
