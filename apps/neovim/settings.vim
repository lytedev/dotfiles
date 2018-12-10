scriptencoding utf8

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

let g:indent_guide_auto_colors = 1
let g:indent_guides_enable_on_vim_startup = 1

let g:ale_elixir_elixir_ls_release = '/home/daniel/code/open-source/elixir-ls/release'

let g:ale_sign_column_always = 0
let g:ale_set_signs = 0
highlight clear ALEErrorSign
highlight clear ALEWarningSign

let g:fzf_layout = { 'window': 'enew' }

set completeopt=noinsert,menuone,noselect,longest,preview

" fix neovim cursor
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

let g:ale_fix_on_save = 1

" line number defaults
set nonumber
set norelativenumber

" different settings if using vim as a manpage viewer
" if exists('asmanviewer')
" 	set nonumber " no line numbers when viewing a man page
" 	set norelativenumber " no line numbers when viewing a man page
" else
" 	set nonumber " line numbers
" 	set norelativenumber " line numbers
" endif

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

" try and keep text (and code) to a width of 80 characters
set wrap
set linebreak
set breakindent
set textwidth=80
set formatoptions=crql1j " :h fo-table

" handle window title
set title

" don't do syntax highlighting on lines longer than 2048 characters
set synmaxcol=2048

" don't highlight the current line
set nocursorline

" set cursorcolumn " highlight the current column
" let &colorcolumn=join(range(81,400),",") " colors columns past 80

" highlight the 81st character in a line where it exists
highlight ColorColumn ctermbg=magenta ctermfg=7
call matchadd('ColorColumn', '\%81v', 100)

set noshowcmd
set nowildmenu
set wildmode=longest,list,full
set cpoptions-=$
set showmatch
set mouse=a
set mousehide
set backspace=indent,eol,start
set noruler
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

" no freakin' bell
set visualbell t_vb=
if has('autocmd')
	augroup DisableVisualVell
		autocmd GUIEnter * set visualbell t_vb=
	augroup END
endif

" color scheme
let base16colorspace=256
set background=dark
syntax enable
colorscheme base16-donokai

" hide stuff
highlight SignColumn ctermbg=black guibg=black
highlight GitGutterAdd ctermbg=black guibg=black
highlight GitGutterDelete ctermbg=black guibg=black
highlight GitGutterChange ctermbg=black guibg=black
highlight GitGutterChangeDelete ctermbg=black guibg=black

hi NonText ctermfg=black guifg=black

set hidden " allows buffer switching without saving
set shortmess=Ia
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
set foldlevelstart=0

set autowrite
set autochdir
set autoread
set nomodeline
set noshowmode
set noshowcmd

set laststatus=0

" yank to OS clipboard
set clipboard+=unnamedplus

set nofoldenable
setlocal nofoldenable

" no empty buffer on startup
augroup DisableEmptyBuffer
	autocmd VimEnter * nested if bufname('')=='' && line('$') == 1 && col('$')==1 && !&modified | bd % | endif
augroup END

" modify higlight colors
hi Search cterm=NONE ctermbg=blue ctermfg=black
highlight LineNr ctermbg=none ctermfg=8
highlight CursorLineNr ctermbg=18 ctermfg=gray
hi IndentGuidesEven ctermbg=18
