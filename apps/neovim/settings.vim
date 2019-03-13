scriptencoding utf8

" ALE completeopt recommendation
set completeopt=menu,menuone,preview,noselect,noinsert
" set completeopt=noinsert,menuone,noselect,longest,preview

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

" use tabs at a two-space width like God intended
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

" limit syntax highlighting line length
set synmaxcol=500

" don't highlight the current line
set nocursorline

" don't highlight the current column
" set nocursorcolumn

" OBSOLETE: colors columns past 80
" let &colorcolumn=join(range(81,400),",")

" highlight the 81st character in a line where it exists
highlight ColorColumn ctermbg=magenta ctermfg=7
call matchadd('ColorColumn', '\%81v', 100)

" set noshowcmd
" set nowildmenu
" set wildmode=longest,list,full
set cpoptions-=$ " make buffer options more global
set noshowmatch " don't briefly highlight matching brackets
set mouse=a " enable mouse use
set mousehide " hide mouse when typing
set backspace=indent,eol,start " sane backspace
set noruler " hide the ruler - we have airline
set lazyredraw " don't draw during macros and other such things
set scrolloff=8 " keep lines above and below cursor (padding)
set sidescrolloff=15 " same but for columns
set splitright " don't split left
set splitbelow " don't split top
set noerrorbells " shhhh, vim
set visualbell " but visual noise for alerts is ok
set nobackup " sessions handle this quite nicely
set nowritebackup " no but really they do
set noswapfile " no seriously sessions are cool
set timeout " key combo mapping timeout
set ttimeoutlen=200 " ms for key combo mapping timeout
set isfname+=32 " allow filenames to show them 32s

" no freakin' bell
set visualbell t_vb=
if has('autocmd')
	augroup DisableVisualBell
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
set shortmess=Ia " hide vim intro, skip lots of file messages/prompts
set history=1000

" undo files
set undofile
set undodir=$vimdir/undo
set undolevels=1000
set undoreload=10000

" spell file
set spellfile=$vimdir/spell/en.utf-8.add

" more sane search settings
set ignorecase
set smartcase
set incsearch
set wrapscan

" highlight search matches
set hlsearch

" enable syntax folding
set foldmethod=syntax
set foldlevel=99
set foldnestmax=10
set foldlevelstart=99

set noautowrite " let me do the writing
set autochdir " `:e` all day
set autoread " this is fine with `u`
set nomodeline " airline wins
set noshowmode " airline is really good
set noshowcmd " be clean

set laststatus=0 " be clean

" yank to OS clipboard by default
set clipboard+=unnamedplus

" no empty buffer on startup
augroup DisableEmptyBuffer
	autocmd VimEnter * nested if bufname('')=='' && line('$') == 1 && col('$')==1 && !&modified | bd % | endif
augroup END

" modify higlight colors
hi Search cterm=NONE ctermbg=blue ctermfg=black
highlight LineNr ctermbg=none ctermfg=8
highlight CursorLineNr ctermbg=18 ctermfg=gray
hi IndentGuidesEven ctermbg=18
