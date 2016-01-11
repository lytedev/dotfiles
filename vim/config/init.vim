" Based on dotfiles from @viccuad on GitHub - <3

" Plugins {{{
" Get plugin manager if it doesn't exist
if empty(glob('~/.config/nvim/autoload/plug.vim'))
		silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall
endif

" Initialize plugin manager
if has("unix")
  call plug#begin('~/.config/nvim/bundle')
endif

" Pretty status line and tabs/buffers
Plug 'bling/vim-airline'
	let g:airline_powerline_fonts = 0
	let g:airline#extensions#tabline#fnamemod = ':t'
	set laststatus=2 " Always show statusline
	set noshowmode " Hides default mode
	let g:airline#extensions#tabline#enabled = 1 " Automatically displays all buffers when there's only one tab open

	let g:airline#extensions#tabline#left_sep = ''
	let g:airline#extensions#tabline#left_alt_sep = ''

  let g:airline_right_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_left_alt_sep= ''
  let g:airline_left_sep = ''

" Plugins that make text-wizarding much more fun
Plug 'majutsushi/tagbar' " shows a list of tags (requires ctags)
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Plug 'kien/ctrlp.vim'
"   " The \| escapes the regex OR operator and is the delimiter
"   let g:ctrlp_custom_ignore = 'node_modules\|bower_components'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTree']}
	let g:NERDSpaceDelims = 1
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/syntastic'
Plug 'LargeFile'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tasklist.vim' " <leader>, t will show TODOs and FIXMEs
Plug 'christoomey/vim-tmux-navigator'
Plug 'godlygeek/tabular'
Plug 'jez/vim-superman'
	noremap K :SuperMan <cword><CR>

" Plugins for code completion and snippets
Plug 'Shougo/deoplete.nvim'
  let g:deoplete#enable_at_startup = 1
" Plug 'Valloric/YouCompleteMe', {'do': './install.sh --clang-completer'}		" (NEEDS to be compiled, read the docs!)
" 	let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" TODO: Setup snippets? I honestly never use them...
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
" 	let g:UltiSnipsSnippetDirectories=["snippets_UltiSnips"]
" 	function! g:UltiSnips_Complete()
" 		call UltiSnips#ExpandSnippet()
" 		if g:ulti_expand_res == 0
" 			if pumvisible()
" 				return "\<C-n>"
" 			else
" 				call UltiSnips#JumpForwards()
" 				if g:ulti_jump_forwards_res == 0
" 					return "\<TAB>"
" 				endif
" 			endif
" 		endif
" 		return ""
" 	endfunction
" 	au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
" 	let g:UltiSnipsJumpForwardTrigger="<tab>"
" 	let g:UltiSnipsListSnippets="<c-e>"

" 	" this maps Enter key to <C-y> to chose the current highlight item
" 	" and close the selection list, same as other IDEs:
" 	" CONFLICTS with some plugins like tpope/Endwise
" 	inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Filetype handling
Plug 'kchmck/vim-coffee-script', {'for': ['coffee', 'coffeescript', 'vue']}
Plug 'posva/vim-vue', {'for': ['vue']}
Plug 'elixir-lang/vim-elixir', {'for': ['elixir']}
Plug 'wavded/vim-stylus', {'for': ['styl', 'stylus', 'vue']}
Plug 'rust-lang/rust.vim', {'for': ['rs', 'rust']}
Plug 'plasticboy/vim-markdown', {'for': ['md', 'markdown']}
Plug 'digitaltoad/vim-jade', {'for': ['jade', 'vue']}
Plug 'freitass/todo.txt-vim', {'for': ['todo']}
Plug 'leafo/moonscript-vim', {'for': ['moon', 'moonscript']}

Plug 'c.vim', {'for': 'c'}
	let g:C_LocalTemplateFile = $HOME.'/.vim/snippets_Cvim/c-support/templates/Templates' " this allows for the templates to be versioned on .dotfiles

Plug 'hdima/python-syntax', {'for': 'python'}
	let python_highlight_all = 1
	" you can change between py v2 and v3 with :Python2Syntax and :Python3Syntax

call plug#end()
" }}}

" Filetype & languages {{{
filetype on
filetype indent on
filetype plugin on

" C language
let c_space_errors = 1
let c_comment_strings = 0		" dont highlight strings inside C comments

" Python language
let python_space_errors = 1
autocmd FileType python setl tabstop=2 expandtab shiftwidth=2 softtabstop=2

" HamlC
autocmd BufRead,BufNewFile *.hamlc set ft=haml

" Markdown instead of modula2
autocmd BufNewFile,BufReadPost *.md setl filetype=markdown spell textwidth=0 wrapmargin=0

" TXT files
autocmd BufNewFile,BufReadPost *.txt setl spell textwidth=0 wrapmargin=0
" }}}

" Spaces and tabs {{{
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent smartindent
set listchars=tab:\ \ ,trail:·
set list
" }}}

" Line wrap {{{
" let &colorcolumn=join(range(81,400),",") " colors columns past 80
set wrap
set linebreak
set breakindent
set textwidth=80
set formatoptions=tcrql1j
  " t autowrap to textwidth
  " c autowrap comments to textwidth
  " r autoinsert comment leader with <enter>
  " q allow formatting of comments with gq
  " l	Long lines are not broken in insert mode: When a line was longer than 'textwidth' when the insert command started, Vim does not automatically format it.
  " 1	Don't break a line after a one-letter word. It's broken before it instead (if possible).
  " j	Where it makes sense, remove a comment leader when joining lines
" }}}

" Look and feel {{{
set title
set synmaxcol=2048
set number
"set relativenumber
set cursorline
"set cursorcolumn
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
set vb t_vb=
set nobackup
set nowritebackup
set noswapfile
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif
set timeout
set ttimeoutlen=200

set t_Co=256
let base16colorspace=256
set background=dark
colorscheme current
highlight ColorColumn ctermbg=235 guibg=#262626

highlight clear SignColumn

if &term == 'xterm-256color' || &term == 'screen-256color'
	let &t_SI = "\<Esc>[5 q"
	let &t_EI = "\<Esc>[1 q"
endif

if &term == 'rxvt-unicode-256color'
	let &t_SI = "\<Esc>[3 q"
	let &t_EI = "\<Esc>[1 q"
endif
" }}}

" Persistence {{{

" No empty buffer on startup
autocmd VimEnter * nested if  bufname('')==''  &&  line('$') == 1 &&  col('$')==1 &&  !&modified | bd % | endif

set hidden
set shortmess=I
set history=1000
set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=1000
set undoreload=10000
" }}}

" Backup, Swap, Spell files {{{
set backupdir=$HOME/.config/nvim/backup
set directory=$HOME/.config/nvim/backup
set spellfile=$HOME/.config/nvim/spell/en.utf-8.add
" }}}

" Searching {{{
set ignorecase
set smartcase
set incsearch
set hlsearch
set wrapscan
" }}}

" Mappings {{{
" make these commonly mistyped commands still work:
command! WQ wq
command! Wq wq
command! Wqa wqa
command! W w
command! Q q

let mapleader = "\<Space>"

" use tab key to cycle through the buffers:
nnoremap <leader><Tab>   :bnext<CR>
nnoremap <leader><S-Tab> :bprevious<CR>

" don't kill vim
nnoremap <leader>K <Nop>

" quick paragraph formatting
vmap Q gq
nmap Q gqap

" launch fzf for the current git repo
nnoremap <C-P> :GitFiles<CR>

" use ctrl j and k to switch buffers as well
nnoremap <leader>k :bnext<CR>
nnoremap <leader>j :bprevious<CR>

" fast word change
nnoremap <leader>c ciw
nnoremap <leader>C ciW

" bash-like deletion
inoremap <C-BS> <C-w>
inoremap <A-BS> <C-w>

" clear search higlight
nnoremap <leader>/ :let @/ = ""<CR>

" remap jk to escape in insert mode
inoremap jk <Esc>
inoremap jj <Esc>

" use hjkl-movement between rows when soft wrapping:
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" workaround for an issue where nvim reads C-H as <BS> in normal mode
if has('nvim')
  nmap <bs> :<c-u>TmuxNavigateLeft<cr>
endif

" move between tabs:
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" remove trailing whitespace:
map <F3> :%s/\s\+$//<CR>:let @/ = ""<CR>

nnoremap <S-K> <NOP>

" close buffer:
nnoremap <silent> <leader>w <Esc>:bd<CR>
map <silent> <F4> <Esc>:bd<CR>

" toggle spell checking:
map <F5> :setlocal spell!<CR>

" open urls, files, etc. example: http://google.com:
noremap <leader>o :!xdg-open <cfile><CR><CR>
set isfname+=32

" previous c error (c.vim plugin):
map  <silent> <F7>    <Esc>:cprevious<CR>

" next c error (c.vim plugin)
map  <silent> <F8>    <Esc>:cnext<CR>

" keep that dumb window from popping up
map q: :q

" sane n/N behavior
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" better command history navigation
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" keep selection after indenting visual
xnoremap < <gv
xnoremap > >gv

command! UseFoldMarkers set foldmethod=marker

" compile & link c code (alt+<F9> write + compile, ctrl+<F9> compile + run) (c.vim plugin)
"<F9>
" }}}

" Folding {{{
set foldmethod=syntax
set foldlevel=99
set foldnestmax=10
set nofoldenable
set foldlevelstart=1
" }}}

" Launch {{{
set encoding=utf8
set autowrite
set autochdir
"autocmd BufEnter * silent! lcd %:p:h		" automatically cd into the dir of the file. this breaks less
set autoread
set nomodeline

" jump to the last position when reopening a file:
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" }}}
