set nocompatible

" initial plugin manager installation
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

" if vim is being launched to view man pages, don't do our magical session
" stuff!
if exists('asmanviewer')
	let g:prosession_dir = '/dev/null'
else
	Plug 'tpope/vim-obsession' " session ease-of-use
	Plug 'dhruvasagar/vim-prosession' " more session ease-of-use
	let g:prosession_dir = '~/.config/nvim/session/'
endif

Plug 'vim-airline/vim-airline' " statusline
" let g:airline_powerline_fonts = 0
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

Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTree']} " nice sidebar for files
let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close vim if last buffer is a NERD buffer

Plug 'nathanaelkane/vim-indent-guides' " indentation guides (NOTE: doesn't seem to work with my colorscheme)
let g:indent_guides_start_level = 0
let g:indent_guides_auto_color = 1

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " autocomplete
let g:deoplete#enable_at_startup = 1

Plug 'scrooloose/syntastic' " syntax checker
Plug 'bkad/CamelCaseMotion' " camel case and underscore word movements
Plug 'LargeFile' " gracefully handle very large files
Plug 'tpope/vim-commentary' " toggle comments in code easily
Plug 'tpope/vim-repeat' " toggle comments in code easily
Plug 'othree/html5.vim' " HTML5 syntax
Plug 'tmux-plugins/vim-tmux-focus-events' " allow transitions within tmux
Plug 'christoomey/vim-tmux-navigator' " allow transitions within tmux
Plug 'tasklist.vim' " show tasks with leader,t
Plug 'godlygeek/tabular' " align text lines together
Plug 'dhruvasagar/vim-table-mode' " for creating and editing character tables
Plug 'lytedev/vim-superman' " view man pages with vim
Plug 'tpope/vim-surround' " quickly modify text surrounding objects
Plug 'tpope/vim-speeddating' " vim knows about date-like text objects
Plug 'michaeljsmith/vim-indent-object' " adds an indentation level text object
Plug 'wellle/targets.vim' " adds some more handy text objects
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' } " javascript helpful things
Plug 'mikewest/vimroom' " distraction-free editing
Plug 'editorconfig/editorconfig-vim' " loads project-specific editor settings
let g:vimroom_sidebar_height = 0

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} " fuzzy file finding
Plug 'junegunn/fzf.vim' " helpers for using fzf in vim
let g:fzf_layout = { 'window': 'enew' }

" plugins for specific file types

Plug 'kchmck/vim-coffee-script', {'for': ['coffee', 'coffeescript', 'vue']}
Plug 'posva/vim-vue', {'for': ['vue']}
Plug 'elixir-lang/vim-elixir', {'for': ['elixir']}
Plug 'mattn/emmet-vim', {'for': ['html']}
Plug 'wavded/vim-stylus', {'for': ['styl', 'stylus', 'vue']}
Plug 'rust-lang/rust.vim', {'for': ['rs', 'rust']}
" Plug 'plasticboy/vim-markdown', {'for': ['md', 'markdown']}
" Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer'), 'for': ['md', 'markdown'] }
Plug 'digitaltoad/vim-jade', {'for': ['pug', 'jade', 'vue']}
Plug 'leafo/moonscript-vim', {'for': ['moon', 'moonscript']}
Plug 'evidens/vim-twig'
Plug 'leafgarland/typescript-vim', {'for': ['ts', 'typescript']}
Plug 'jwalton512/vim-blade', {'for': ['blade', 'blade.php']}

call plug#end()

filetype on
filetype indent on
filetype plugin on

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

" whitespace
" use tabs at a two-space width
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noexpandtab

" auto/smart indent
set autoindent smartindent

" show certain whitespace characters
set list
set nostartofline
set listchars=trail:·,tab:\ \ ,trail:~
" set listchars=eol:\ ,tab:>-,trail:~,extends:>,precedes:<,space:·

" look and feel
"
" try and keep text (and code) to a width of 80 characters
set wrap
set linebreak
set breakindent
set textwidth=80
set formatoptions=crql1j
" t autowrap to textwidth
" c autowrap comments to textwidth
" r autoinsert comment leader with <enter>
" q allow formatting of comments with gq
" l lines longer than 'textwidth' on insert do not get formatted
" 1 don't break a line after a one-letter word - break it before
" j where it makes sense, remove a comment leader when joining lines

" handle window title
set title

" don't do syntax highlighting on lines longer than 2048 characters
set synmaxcol=2048

if exists('asmanviewer')
	set nonumber " no line numbers when viewing a man page
else
	set number " line numbers
endif

" relative line numbers
set relativenumber

" highlight the current line
set cursorline

" set cursorcolumn " highlight the current column
" let &colorcolumn=join(range(81,400),",") " colors columns past 80

" highlight the 81st character in a line where it exists
highlight ColorColumn ctermbg=magenta ctermfg=7
call matchadd('ColorColumn', '\%81v', 100)

set showcmd
set nowildmenu
set wildmode=longest,list,full
set cpoptions-=$
set showmatch
set mouse=a
set mousehide
set backspace=indent,eol,start
set ruler
set lazyredraw
set scrolloff=8
set sidescrolloff=8
set splitright
set splitbelow
set noerrorbells
set visualbell
set nobackup
set nowritebackup
set noswapfile
set timeout
set ttimeoutlen=200
set isfname+=32

set vb t_vb=
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif

let base16colorspace=256
set background=dark
colorscheme base16-donokai

" TODO: need a way to toggle this and maybe make it on by default except in
" files where space indentation is expected
fun! ShowSpaceIndentation()
	hi LeadingWhiteSpaces ctermfg=black ctermbg=8
endfunction
fun! HideSpaceIndentation()
	hi LeadingWhiteSpaces ctermfg=black ctermbg=black
endfunction
hi LeadingWhiteSpaces ctermfg=black ctermbg=black

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
		hi NonText ctermfg=gray guifg=gray
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

nnoremap <silent> <Leader>mz :DistractionFreeMode<CR>

:command! SpaceIndents call ShowSpaceIndentation()
:command! ShowSpaceIndents call ShowSpaceIndentation()
:command! HideSpaceIndents call HideSpaceIndentation()
:command! DistractionFreeMode call DistractionFreeModeFunc()

set hidden " allows buffer switching without saving
set shortmess=I
set history=1000

" undo files
set undofile
set undodir=$vimdir/undo
set undolevels=1000
set undoreload=10000

" backup files
set backupdir=$vimdir/backup
set directory=$vimdir/backup

" spell file
set spellfile=$vimdir/spell/en.utf-8.add

" smart case insensitivity by default
set ignorecase
set smartcase
set incsearch
set hlsearch
set wrapscan

set foldmethod=syntax
set foldlevel=99
set foldnestmax=10
set nofoldenable
set foldlevelstart=0

set autowrite
set autochdir
set autoread
set nomodeline

" yank to OS clipboard
set clipboard+=unnamed

" allows for manual and syntax folding... supposedly
augroup vimrc
	au BufReadPre * setlocal foldmethod=indent
	au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

" jump to last opened position in file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" no empty buffer on startup
autocmd VimEnter * nested if bufname('')=='' && line('$') == 1 && col('$')==1 && !&modified | bd % | endif

" terminal split in neovim
if has('nvim')
	function! TerminalSplit()
		let current_file = @%
		echo current_file
		if match(current_file, "term://*") != -1
			split
			terminal
		else
			vsplit
			vertical resize 80
			terminal
		endif
	endfunction
endif

" bindings

" common typo fixes
command! WQ wq
command! Wq wq
command! Wqa wqa
command! W w
command! Q q

" best leader
let mapleader = "\<Space>"

if has('nvim')
	" terminal mappings
	" open a terminal split at 80 columns
	nnoremap <C-t> :call TerminalSplit()<CR>
	tnoremap <C-t> <C-\><C-n>:call TerminalSplit()<CR>

	" close the terminal
	tnoremap <C-w> <C-\><C-n>:q!<CR>

	" moving between terminal splits
	tnoremap <C-h> <C-\><C-n><C-w>h
	tnoremap <C-j> <C-\><C-n><C-w>j
	tnoremap <C-k> <C-\><C-n><C-w>k
	tnoremap <C-l> <C-\><C-n><C-w>l
endif

" enter insert mode when entering a terminal buffer
autocmd BufWinEnter,WinEnter term://* startinsert

" change buffers with leader,tab
nnoremap <leader><Tab>		:bnext<CR>
nnoremap <leader><S-Tab>	:bprevious<CR>

" don't kill vim
nnoremap <leader>K <Nop>
nnoremap <S-K> <NOP>

" nerdtree
nnoremap <C-n> :NERDTree<CR>

" run macro across visually selected lines
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
	echo "@".getcmdline()
	execute ":'<,'>normal @".nr2char(getchar())
endfunction

" quick paragraph formatting
vmap Q gq
nmap Q gqap

" launch fzf for the current git repo
nnoremap <C-p> :GitFiles<CR>

" launch fzf for files in the current directory
nnoremap <C-o> :Files<CR>

" launch fzf for files modified or not in git
nnoremap <C-u> :GFiles?<CR>

" launch fzf for open buffers (files)
nnoremap <C-b> :Buffers<CR>

" launch fzf for open buffers (files)
nnoremap <leader>l :Buffers<CR>

" switch to previous buffer
nnoremap <leader>h :b#<CR>

" use leader j and k to switch buffers as well
nnoremap <leader>k :bnext<CR>
nnoremap <leader>j :bprevious<CR>
nnoremap <C-k> :bnext<CR>
nnoremap <C-j> :bprevious<CR>

" fast word change
nnoremap <leader>c ciw
nnoremap <leader>C ciW

" bash-like deletion
inoremap <C-BS> <C-w>
inoremap <A-BS> <C-w>

" clear search higlight
nnoremap <leader>/ :let @/ = ""<CR>

" remap jk/jj and its variants to escape
inoremap jj <Esc>
inoremap Jj <Esc>
inoremap Jj <Esc>
inoremap JJ <Esc>
inoremap jk <Esc>
inoremap Jk <Esc>
inoremap jK <Esc>
inoremap JK <Esc>

" use hjkl-movement between rows when soft wrapping:
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" camel case movements
map <silent> ,w <Plug>CamelCaseMotion_w
map <silent> ,b <Plug>CamelCaseMotion_b
map <silent> ,e <Plug>CamelCaseMotion_e
map <silent> ,ge <Plug>CamelCaseMotion_ge

" inner _ objects
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie

" a _ objects
" omap <silent> aw <Plug>CamelCaseMotion_aw
" xmap <silent> aw <Plug>CamelCaseMotion_aw
omap <silent> ab <Plug>CamelCaseMotion_ab
xmap <silent> ab <Plug>CamelCaseMotion_ab
omap <silent> ae <Plug>CamelCaseMotion_ae
xmap <silent> ae <Plug>CamelCaseMotion_ae

" remove trailing whitespace
map <F3> mw:%s/\s\+$//<CR>:let @/ = ""<CR>'w

" close buffer with leader-w
nnoremap <silent> <leader>w :bd<CR>

" toggle spell checking:
map <F5> :setlocal spell!<CR>

" open urls, files, etc. example: http://google.com:
noremap <leader>o :!xdg-open <cfile><CR><CR>

" insert newline
noremap <S-Enter> i<Enter><Esc>
noremap <C-S-o> i<Enter><Esc>

" keep that dumb window from popping up (wild something or another)
map q: :q
noremap qqq: q:

" sane n/N behavior
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" better command history navigation
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" keep selection after indenting visual selection
xnoremap < <gv
xnoremap > >gv

" modify higlight colors
hi Search cterm=NONE ctermbg=blue ctermfg=black
highlight LineNr ctermbg=none ctermfg=8
highlight CursorLineNr ctermbg=18 ctermfg=gray
