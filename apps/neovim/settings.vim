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

" relative line numbers
set relativenumber

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

set vb t_vb=
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif

let base16colorspace=256
set background=dark
colorscheme base16-donokai

highlight SignColumn ctermbg=black guibg=black
highlight GitGutterAdd ctermbg=black guibg=black
highlight GitGutterDelete ctermbg=black guibg=black
highlight GitGutterChange ctermbg=black guibg=black
highlight GitGutterChangeDelete ctermbg=black guibg=black

" TODO: need a way to toggle this and maybe make it on by default except in
" files where space indentation is expected
fun! ShowSpaceIndentation()
	hi LeadingWhiteSpaces ctermfg=black ctermbg=8
endfunction
fun! HideSpaceIndentation()
	hi LeadingWhiteSpaces ctermfg=black ctermbg=black
endfunction
hi LeadingWhiteSpaces ctermfg=black ctermbg=black

:command! SpaceIndents call ShowSpaceIndentation()
:command! ShowSpaceIndents call ShowSpaceIndentation()
:command! HideSpaceIndents call HideSpaceIndentation()

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
set clipboard+=unnamed

" allows for manual and syntax folding... supposedly
augroup vimrc
	au BufReadPre * setlocal foldmethod=indent
	au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

set nofoldenable
setlocal nofoldenable

" jump to last opened position in file except in git commits
let jump_to_pos_blacklist = ['gitcommit']
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") && index(jump_to_pos_blacklist, &ft) | exe "normal! g'\"" | endif
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
			split
			resize 24
			terminal
		endif
	endfunction
endif

