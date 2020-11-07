scriptencoding utf-8
set fileencoding=utf8

let $vimdir = $XDG_CONFIG_HOME.'/nvim'

if empty(glob($vimdir.'/autoload/plug.vim'))
  silent !curl -fLo $vimdir/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $vimdir.'init.vim'
endif

let g:indent_guide_auto_colors = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:prosession_dir = $vimdir."/session/"
let g:jsonnet_fmt_on_save = 0

call plug#begin($vimdir.'/plugged')
	Plug 'junegunn/vim-plug'                  " plugin manager should manage itself
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'                   " helpers for using fzf in vim
	Plug 'nathanaelkane/vim-indent-guides'    " indentation guides
	Plug 'bkad/CamelCaseMotion'               " camel case and underscore word movements
	Plug 'vim-scripts/LargeFile'              " gracefully handle very large files
	Plug 'tpope/vim-commentary'               " toggle comments in code easily
	Plug 'tpope/vim-repeat'                   " better vim repeating for plugin-provided actions
	Plug 'christoomey/vim-tmux-navigator'     " allow window navigation to play nicely with tmux
	Plug 'machakann/vim-sandwich'             " quickly modify text surrounding objects
	Plug 'michaeljsmith/vim-indent-object'    " adds an indentation level text object
	Plug 'wellle/targets.vim'                 " adds some more handy text objects
	Plug 'junegunn/goyo.vim'                  " better distraction-free editing
	Plug 'tpope/vim-sleuth'                   " try and detect indent method
	Plug 'editorconfig/editorconfig-vim'      " loads project-specific editor settings
	Plug 'google/vim-jsonnet', {'for': ['jsonnet', 'libsonnet']}
	Plug 'calviken/vim-gdscript3', {'for': ['gdscript']}
call plug#end()

filetype on
filetype indent on
filetype plugin on

" use :h option-list if you need to know what these do
set encoding=utf8
set tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
set autoindent smartindent
set list nostartofline listchars=trail:·,tab:\ \ ,trail:~
set linebreak formatoptions=crql1jn " TODO: anything else useful? :h fo-table
set synmaxcol=200
set lazyredraw
set scrolloff=8 sidescrolloff=15
set mouse=a
set splitright splitbelow
set noerrorbells visualbell t_vb=
set nobackup nowritebackup noswapfile
set timeout ttimeoutlen=100 timeoutlen=150
set hidden shortmess+=Ia
set history=1000
set undofile undodir=$vimdir/undo undolevels=1000 undoreload=10000
set spellfile=$vimdir/spell/en.utf-8.add
set ignorecase smartcase incsearch wrapscan hlsearch
set foldmethod=syntax foldlevel=99 foldnestmax=10 foldlevelstart=99 " TODO: get good at folding
set noautowrite autochdir autoread
set nomodeline noshowmode noshowcmd laststatus=0 " TODO: custom modeline and buffer list?
set clipboard+=unnamedplus
set t_Co=256

syntax enable
colorscheme base16-donokai

call matchadd('ColorColumn', '\%81v', 100)

hi Search cterm=NONE ctermbg=blue ctermfg=black
hi LineNr ctermbg=none ctermfg=8
hi CursorLineNr ctermbg=18 ctermfg=gray
hi IndentGuidesEven ctermbg=18
hi Normal ctermbg=NONE
hi ColorColumn ctermbg=7 ctermfg=0

" jump to last opened position in file except in git commits
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") && index(['gitcommit'], &ft) | exe "normal! g'\"" | endif

inoremap jj <Esc>
inoremap jk <Esc>

nnoremap <C-p> :GitFiles<CR>
nnoremap <C-o> :Files<CR>
nnoremap <C-u> :GFiles?<CR>
nnoremap <C-b> :Buffers<CR>
au FileType fzf tnoremap <Esc> <C-c><C-c>

nnoremap <C-h> :TmuxNavigateLeft<CR>
nnoremap <C-j> :TmuxNavigateDown<CR>
nnoremap <C-k> :TmuxNavigateUp<CR>
nnoremap <C-l> :TmuxNavigateRight<CR>
tnoremap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
tnoremap <C-j> <C-\><C-n>:TmuxNavigateDown<CR>
tnoremap <C-k> <C-\><C-n>:TmuxNavigateUp<CR>
tnoremap <C-l> <C-\><C-n>:TmuxNavigateRight<CR>

map <silent> ,w <Plug>CamelCaseMotion_w
map <silent> ,b <Plug>CamelCaseMotion_b
map <silent> ,e <Plug>CamelCaseMotion_e
map <silent> ,ge <Plug>CamelCaseMotion_ge
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie

map <F3> mw:%s/\s\+$//<CR>:let @/ = ""<CR>'w
map <F4> :setlocal spell!<CR>

nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

cnoremap <c-n> <down>
cnoremap <c-p> <up>

xnoremap < <gv
xnoremap > >gv

let mapleader = "\<Space>"
nnoremap <silent> <leader>w :bd<CR>
nnoremap <leader>h :b#<CR>
nnoremap <leader>k :bnext<CR>
nnoremap <leader>j :bprevious<CR>
nnoremap <silent> <leader>/ :let @/ = ""<CR>:<BACKSPACE>

nnoremap <leader>t :split<CR>:term<CR>:resize 24<CR>:startinsert<CR>
tnoremap <C-w> <C-\><C-n>:q!<CR>

" TODO: learn about the wildmenu `q:`
