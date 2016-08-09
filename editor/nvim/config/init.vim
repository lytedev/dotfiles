" initial plugin manager
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

" tell vim to reload the init.vim file when it saves it
autocmd! BufWritePost init.vim source %

" Initialize plugin manager
call plug#begin('~/.config/nvim/bundle')

" let plugin manager manage itself
Plug 'junegunn/vim-plug'

" plugins

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
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTree']} " nice sidebar for files
let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close vim if last buffer is a NERD buffer

Plug 'nathanaelkane/vim-indent-guides' " indentation guides (NOTE: doesn't seem to work with my colorscheme)
let g:indent_guides_start_level = 0
let g:indent_guides_auto_color = 1

Plug 'Shougo/deoplete.nvim' " autocomplete
let g:deoplete#enable_at_startup = 1

Plug 'scrooloose/syntastic' " syntax checker
Plug 'bkad/CamelCaseMotion' " camel case and underscore word movements
Plug 'LargeFile' " gracefully handle very large files
Plug 'tpope/vim-commentary' " toggle comments in code easily
Plug 'tmux-plugins/vim-tmux-focus-events' " allow transitions within tmux
Plug 'christoomey/vim-tmux-navigator' " allow transitions within tmux
Plug 'tasklist.vim' " show tasks with leader,t
Plug 'godlygeek/tabular' " align text lines together
Plug 'lytedev/vim-superman' " view man pages with vim
Plug 'tpope/vim-surround' " quickly modify text surrounding objects
Plug 'tpope/vim-speeddating' " vim knows about date-like text objects
Plug 'michaeljsmith/vim-indent-object' " adds an indentation level text object
Plug 'wellle/targets.vim' " adds some more handy text objects
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} " fuzzy file finding
Plug 'junegunn/fzf.vim' " helpers for using fzf in vim
let g:fzf_layout = { 'window': 'enew' }

" plugins for specific file types
Plug 'kchmck/vim-coffee-script', {'for': ['coffee', 'coffeescript', 'vue']}
Plug 'posva/vim-vue', {'for': ['vue']}
Plug 'elixir-lang/vim-elixir', {'for': ['elixir']}
Plug 'wavded/vim-stylus', {'for': ['styl', 'stylus', 'vue']}
Plug 'rust-lang/rust.vim', {'for': ['rs', 'rust']}
Plug 'plasticboy/vim-markdown', {'for': ['md', 'markdown']}
Plug 'digitaltoad/vim-jade', {'for': ['pug', 'jade', 'vue']}
Plug 'freitass/todo.txt-vim', {'for': ['todo']}
Plug 'leafo/moonscript-vim', {'for': ['moon', 'moonscript']}
Plug 'evidens/vim-twig'

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
autocmd FileType python setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

" HAMLC
autocmd BufRead,BufNewFile *.hamlc set ft=haml

" Markdown
autocmd BufNewFile,BufReadPost *.md setl filetype=markdown spell textwidth=0 wrapmargin=0

" Text
autocmd BufNewFile,BufReadPost *.txt setl spell textwidth=0 wrapmargin=0

" whitespace
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noexpandtab
set autoindent smartindent
set list
set nostartofline
set listchars=trail:·,tab:\ \ 

" look and feel

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

set title " handle window title
set synmaxcol=2048
if exists('asmanviewer')
	set nonumber " no line numbers when viewing a man page
else
	set number " line numbers
endif
" set relativenumber
set cursorline " highlight the current line
" set cursorcolumn " highlight the current column
" let &colorcolumn=join(range(81,400),",") " colors columns past 80
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
colorscheme current

fun! ShowSpaceIndentation()
	hi WhiteSpaces ctermfg=black ctermbg=8
	match WhiteSpaces /^ \+/
endfunction

:command! SpaceIndents call ShowSpaceIndentation()

set hidden " hides abandoned buffers or something
set shortmess=I
set history=1000
set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=1000
set undoreload=10000

set backupdir=$HOME/.config/nvim/backup
set directory=$HOME/.config/nvim/backup
set spellfile=$HOME/.config/nvim/spell/en.utf-8.add

set ignorecase
set smartcase
set incsearch
set hlsearch
set wrapscan

set foldmethod=syntax
set foldlevel=99
set foldnestmax=10
set nofoldenable
set foldlevelstart=1

if has('vim_starting')
	set encoding=utf8
endif
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

" bindings

" common typo fixes
command! WQ wq
command! Wq wq
command! Wqa wqa
command! W w
command! Q q

" best leader
let mapleader = "\<Space>"

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

" enter insert mode when entering a terminal buffer
autocmd BufWinEnter,WinEnter term://* startinsert

" change buffers with leader,tab
nnoremap <leader><Tab>   :bnext<CR>
nnoremap <leader><S-Tab> :bprevious<CR>

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
nnoremap <C-P> :GitFiles<CR>

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

" remap jk and kj to escape in insert mode
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
omap <silent> aw <Plug>CamelCaseMotion_aw
xmap <silent> aw <Plug>CamelCaseMotion_aw
omap <silent> ab <Plug>CamelCaseMotion_ab
xmap <silent> ab <Plug>CamelCaseMotion_ab
omap <silent> ae <Plug>CamelCaseMotion_ae
xmap <silent> ae <Plug>CamelCaseMotion_ae

" remove trailing whitespace:
map <F3> mw:%s/\s\+$//<CR>:let @/ = ""<CR>'w

" close buffer:
nnoremap <silent> <leader>w :bd<CR>

" toggle spell checking:
map <F5> :setlocal spell!<CR>

" open urls, files, etc. example: http://google.com:
noremap <leader>o :!xdg-open <cfile><CR><CR>

" keep that dumb window from popping up
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

