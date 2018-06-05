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

" vim compatibility
let $vimdir = $HOME.'/.vim'
if has('nvim')
	let $vimdir = $HOME.'/.config/nvim'
endif

" OS detection functions
silent function! OSX()
	return has('macunix')
endfunction
silent function! LINUX()
	return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
	return (has('win32') || has('win64'))
endfunction

" tell vim to reload the init.vim file when it saves it
" if has('nvim')
	" autocmd! BufWritePost init.vim source %
" else
	" autocmd! BufWritePost .vimrc source %
" end

" load a per-environment file if one exists
if filereadable(expand("$HOME/.env_init.vim"))
	source "$HOME/.env_init.vim"
endif

if has('vim_starting')
	set encoding=utf8
endif

" plugin build functions
function! BuildComposer(info)
	if a:info.status != 'unchanged' || a:info.force
		!cargo build --release
		UpdateRemotePlugins
	endif
endfunction

function! DoRemote(arg)
	UpdateRemotePlugins
endfunction

" initialize plugin manager
if has('nvim')
	call plug#begin('~/.config/nvim/bundle')
else
	call plug#begin('~/.vim/bundle')
endif

" let plugin manager manage itself
Plug 'junegunn/vim-plug'

" plugins

" if vim is being launched to view man pages, don't do our session stuff!
if exists('asmanviewer')
	let g:prosession_dir = '/dev/null'
else
	Plug 'tpope/vim-obsession' " session ease-of-use
	Plug 'dhruvasagar/vim-prosession' " more session ease-of-use
	let g:prosession_dir = '~/.config/nvim/session/'
endif

Plug 'vim-airline/vim-airline' " statusline
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
Plug 'vim-airline/vim-airline-themes'
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

Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTree']} " nice sidebar for files
let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close vim if last buffer is a NERD buffer

Plug 'nathanaelkane/vim-indent-guides' " indentation guides
let g:indent_guide_auto_colors = 1
let g:indent_guides_enable_on_vim_startup = 1

" Plug 'roxma/nvim-completion-manager'

" Plug 'vimwiki/vimwiki'
" let	wiki1 = {}
" let wiki1.path = "~/../doc/wiki/"
" let wiki1.syntax = "markdown"
" let wiki1.ext = ".md"
" let g:vimwiki_list = [wiki1]

" Plug 'scrooloose/syntastic' " syntax checker
Plug 'w0rp/ale' " syntax checker
let g:ale_fixers = {
\	'javascript': ['prettier', 'eslint'],
\	'elixir': ['mix_format'],
\}
Plug 'bkad/CamelCaseMotion' " camel case and underscore word movements
Plug 'vim-scripts/LargeFile' " gracefully handle very large files
Plug 'vim-scripts/utl.vim' " allow for inter-file linking (I meant to use this instead of vimwiki)
Plug 'tpope/vim-commentary' " toggle comments in code easily
Plug 'tpope/vim-repeat' " better vim repeating for plugin-provided actions
Plug 'vim-scripts/SyntaxRange' " defined different syntax ranges in a file for highlighting
Plug 'tmux-plugins/vim-tmux-focus-events' " allow transitions within tmux
Plug 'christoomey/vim-tmux-navigator' " allow transitions within tmux
Plug 'godlygeek/tabular' " align text
Plug 'dhruvasagar/vim-table-mode' " for creating and editing crazy vim tables (I mostly use sc now though)
let g:table_mode_corner='|'
Plug 'lytedev/vim-superman' " view man pages with vim
Plug 'tpope/vim-surround' " quickly modify text surrounding objects
Plug 'tpope/vim-speeddating' " vim knows about date-like text objects
Plug 'tpope/vim-fugitive' " vim git commands
" Plug 'airblade/vim-gitgutter' " vim git gutter information
" let g:gitgutter_override_sign_column_highlight = 0
" let g:gitgutter_sign_added = '+'
" let g:gitgutter_sign_modified = '~'
" let g:gitgutter_sign_removed = '-'
" let g:gitgutter_sign_removed_first_line = '-'
" let g:gitgutter_sign_modified_removed = '~'
Plug 'michaeljsmith/vim-indent-object' " adds an indentation level text object
Plug 'wellle/targets.vim' " adds some more handy text objects
Plug 'dbakker/vim-projectroot' " adds helper functions for getting to a project's root directory
Plug 'mikewest/vimroom' " distraction-free editing
Plug 'editorconfig/editorconfig-vim' " loads project-specific editor settings
let g:vimroom_sidebar_height = 0

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} " fuzzy file finding
Plug 'junegunn/fzf.vim' " helpers for using fzf in vim
let g:fzf_layout = { 'window': 'enew' }

" plugins for specific file types

Plug 'othree/html5.vim', {'for': ['jade', 'pug', 'html', 'vue']}
Plug 'mxw/vim-jsx', {'for': ['jsx', 'javascript', 'js', 'javascript.jsx']}
let g:jsx_ext_required = 0 " allow JSX in normal JS files
Plug 'hail2u/vim-css3-syntax', {'for': ['styl', 'stylus', 'sass', 'scss', 'css', 'vue']}
Plug 'kchmck/vim-coffee-script', {'for': ['coffee', 'coffeescript', 'vue']}
Plug 'posva/vim-vue', {'for': ['vue']}
Plug 'elixir-lang/vim-elixir', {'for': ['elixir', 'ex', 'exs']}
Plug 'OrangeT/vim-csharp', {'for': ['cshtml', 'cshtml.html', 'cs', 'razor']}
Plug 'vim-erlang/vim-erlang-runtime', {'for': ['erlang', 'erl']}
" Plug 'slashmili/alchemist.vim', {'for': ['elixir', 'ex', 'exs']}
Plug 'mattn/emmet-vim', {'for': ['html', 'vue']}
Plug 'wavded/vim-stylus', {'for': ['styl', 'stylus', 'vue']}
Plug 'quabug/vim-gdscript', {'for': ['gd', 'gdscript']}
Plug 'rust-lang/rust.vim', {'for': ['rs', 'rust']}
Plug 'mustache/vim-mustache-handlebars', {'for': ['html.handlebars', 'handlebars', 'hbs']}
Plug 'plasticboy/vim-markdown', {'for': ['md', 'markdown', 'vimwiki']}
Plug 'lifepillar/pgsql.vim', {'for': ['psql', 'sql']}
Plug 'cespare/vim-toml', {'for': ['toml']}
let g:utl_cfg_hdl_scm_http_system = "silent !$BROWSER '%u#%f' &"
Plug 'digitaltoad/vim-pug', {'for': ['pug', 'jade', 'vue']}
Plug 'leafo/moonscript-vim', {'for': ['moon', 'moonscript']}
Plug 'evidens/vim-twig', {'for': ['php']}
Plug 'leafgarland/typescript-vim', {'for': ['ts', 'typescript']}
Plug 'jwalton512/vim-blade', {'for': ['blade', 'blade.php']}

call plug#end()

filetype on
filetype indent on
filetype plugin on

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

" language specific configuration

" C
let c_space_errors = 1
let c_comment_strings = 0 " dont highlight strings inside C comments

" Python
let python_space_errors = 1
" autocmd FileType python setl tabstop=4 expandtab shiftwidth=4 softtabstop=4
" autocmd FileType js setl tabstop=2 expandtab shiftwidth=2 softtabstop=2
" autocmd FileType vue setl tabstop=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType php setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

" Markdown
autocmd BufNewFile,BufReadPost *.md setl filetype=markdown spell

" Text
autocmd BufNewFile,BufReadPost *.txt setl spell textwidth=0 wrapmargin=0

" Make any necessary directories in the path when saving a file
fun! <SID>AutoMakeDirectory()
	let s:directory = expand("<afile>:p:h")
	if !isdirectory(s:directory)
		call mkdir(s:directory, "p")
	endif
endfun
autocmd BufWritePre,FileWritePre * :call <SID>AutoMakeDirectory()

if !exists("g:make_args")
	let g:make_args="default"
endif
fun! RunMake()
	split
	if has('nvim')
		" run from the root of the current git repository
		let path = system("git rev-parse --show-toplevel | tr -d '\\n'")
		" TODO: handle non-git situations
		execute 'terminal cd ' . path . ' && make ' . g:make_args
	else
		execute '!make ' . g:make_args
	endif
endfun

" kill the terminal buffer when the process exits
" autocmd TermClose * call feedkeys('<cr>')

let settingsfile=$vimdir.'/settings.vim'
exec 'source ' . settingsfile

if exists('asmanviewer')
	set nonumber " no line numbers when viewing a man page
	set norelativenumber " no line numbers when viewing a man page
else
	set nonumber " line numbers
	set norelativenumber " line numbers
endif

" a toggle-able minimalistic distraction-free text editing mode
let s:distractionFreeMode = 0
fun! DistractionFreeModeFunc()
	AirlineToggle
	VimroomToggle
	if s:distractionFreeMode == 0
		let s:distractionFreeMode = 1
		set nocursorline
		set laststatus=0
		set noshowmode
		set noruler
		set noshowcmd
		set nonumber
		hi NonText ctermfg=black guifg=black
	else
		let s:distractionFreeMode = 0
		set cursorline
		set showmode
		set ruler
		set laststatus=2
		set showcmd
		set number
		hi NonText ctermfg=black guifg=black
		colorscheme base16-donokai
	endif
endfunction

" prevents normal window navigation and closing while in DistractionFreeMode
fun! CheckCloseDistractionFreeMode()
	if s:distractionFreeMode == 1
		call DistractionFreeModeFunc()
	endif
endfunction

" run the previous checking function every time we leave a window
if has('autocmd')
	autocmd WinLeave * call CheckCloseDistractionFreeMode()
endif

nnoremap <silent> <Leader>df :DistractionFreeMode<CR>

:command! DistractionFreeMode call DistractionFreeModeFunc()

let bindingsfile=$vimdir.'/bindings.vim'
exec 'source ' . bindingsfile

" modify higlight colors
hi Search cterm=NONE ctermbg=blue ctermfg=black
highlight LineNr ctermbg=none ctermfg=8
highlight CursorLineNr ctermbg=18 ctermfg=gray
hi IndentGuidesEven ctermbg=18

fun! VueModifiedFT()
	set ft=vue
endfunction
:command! VueModifiedFT call VueModifiedFT()
autocmd BufRead,BufNewFile *.vue VueModifiedFT
