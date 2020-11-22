set fileencoding=utf8

let $vimdir = $XDG_CONFIG_HOME.'/nvim'

if empty(glob($vimdir.'/autoload/plug.vim'))
	silent !curl -fLo $vimdir/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $vimdir.'init.vim'
endif

let g:completion_enable_auto_popup = 0
let g:indent_guide_auto_colors = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:jsonnet_fmt_on_save = 0
let g:fzf_preview_window = ['down:40%:hidden', 'ctrl-/']

call plug#begin($vimdir.'/plugged')
	Plug 'junegunn/vim-plug'               " plugin manager should manage itself
	Plug 'sheerun/vim-polyglot'            " handles language-specific configuration
	Plug 'neovim/nvim-lspconfig'           " deeper language integration via language servers
	Plug 'nvim-lua/completion-nvim'        " language server completion
	Plug 'junegunn/fzf',                   { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'                " helpers for using fzf in vim
	Plug 'editorconfig/editorconfig-vim'   " loads project-specific editor settings
	Plug 'tpope/vim-sleuth'                " try and detect indent method
	Plug 'vim-scripts/LargeFile'           " gracefully handle very large files
	Plug 'vim-scripts/restore_view.vim'    " persistent buffer views
	Plug 'nathanaelkane/vim-indent-guides' " indentation guides
	Plug 'christoomey/vim-tmux-navigator'  " allow window navigation to play nicely with tmux
	Plug 'tpope/vim-commentary'            " toggle comments in code easily
	Plug 'tpope/vim-repeat'                " better vim repeating for plugin-provided actions
	Plug 'machakann/vim-sandwich'          " quickly modify text surrounding objects
	Plug 'michaeljsmith/vim-indent-object' " adds an indentation level text object
	Plug 'bkad/CamelCaseMotion'            " camel case and underscore word movements
	Plug 'wellle/targets.vim'              " adds some more handy text objects
	Plug 'tpope/vim-obsession'             " even better session handling
	Plug 'dhruvasagar/vim-prosession'      " even better session handling
	Plug 'dhruvasagar/vim-prosession'      " even better session handling
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" luafile $vimdir/lsp.lua
" autocmd BufEnter * lua require('completion').on_attach()

filetype on
filetype indent on
filetype plugin on

" use :h option-list if you need to know what these do
set encoding=utf8
set tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
set autoindent smartindent
set list nostartofline listchars=trail:·,tab:\ \ ,trail:~
set linebreak formatoptions=crql1jn " TODO: see if there is more in `:h fo-table`
set synmaxcol=200
set lazyredraw
set scrolloff=8 sidescrolloff=15
set mouse=a
set splitright splitbelow
set noerrorbells visualbell t_vb=
set nobackup nowritebackup noswapfile
set timeout ttimeoutlen=100 timeoutlen=150
set hidden shortmess+=Iac
set history=1000
set undofile undodir=$vimdir/undo undolevels=1000 undoreload=10000
set spellfile=$vimdir/spell/en.utf-8.add
set ignorecase smartcase incsearch wrapscan hlsearch
set foldmethod=syntax foldlevel=99 foldnestmax=10 foldlevelstart=99 " TODO: get good at folding
set noautowrite autochdir autoread
set nomodeline noshowmode noshowcmd laststatus=2 noruler
set clipboard+=unnamedplus
set t_Co=256
let &fcs = 'eob: '

syntax enable
colorscheme base16-donokai

hi Search cterm=NONE ctermbg=blue ctermfg=black
hi LineNr ctermbg=none ctermfg=8
hi CursorLineNr ctermbg=18 ctermfg=gray
hi IndentGuidesEven ctermbg=18
hi Normal ctermbg=NONE
hi ColorColumn ctermbg=18
hi TooLongColorColumn ctermbg=18 ctermfg=1
hi ActiveBuffer ctermbg=4 ctermfg=0
hi StatusLine ctermbg=18 ctermfg=7
hi StatusLineNC ctermbg=18 ctermfg=7

call matchadd('ColorColumn', '\%81v', 100)
call matchadd('TooLongColorColumn', '\%121v', 200)

command! W write

inoremap jj <Esc>
inoremap jk <Esc>

nnoremap <C-q> :qa<CR>
inoremap <C-q> <Esc><C-q>

nnoremap <C-p> :GitFiles<CR>
nnoremap <C-o> :Files<CR>
nnoremap <C-u> :GFiles?<CR>
nnoremap <C-b> :Buffers<CR>

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

" TODO: learn about the wildmenu `q:`

let mapleader = "\<Space>"
nnoremap <silent> <leader>r :source $vimdir/init.vim<CR>:echo 'Reloaded init.vim'<CR>
nnoremap <silent> <leader>w :bd<CR>
nnoremap <silent> <leader>h :b#<CR>
nnoremap <silent> <leader>k :bnext<CR>
nnoremap <silent> <leader>j :bprevious<CR>
nnoremap <leader>/ :let @/ = ""<CR>:<BACKSPACE>

nnoremap <leader>t :split<CR>:term<CR>:resize 24<CR>:startinsert<CR>
tnoremap <C-w> <C-\><C-n>:q!<CR>

function! NeatFoldText()
	" TODO: finish this!
	let lines_count = v:foldend - v:foldstart + 1
	let foldchar = matchstr(&fillchars, 'fold:\zs.')
	let foldtextstart = strpart('^' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
	let foldtextend = printf("%s %".(winwidth(0)-20)."dL", foldtextstart, getline(v:foldstart), lines_count)
	let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
	return printf("%s%d", substitute(getline(v:foldstart), "^.", ">"), lines_count)
endfunction
set foldtext=NeatFoldText()

" TODO: only update this portion when needed instead of every render?
function! StatusLineBufferByNum(bufnum)
	let l:prefix = ' %#InactiveBuffer#'
	let l:suffix = '%* '
	let l:bufinfo = getbufinfo(a:bufnum)[0]
	if l:bufinfo['hidden'] == 0 && index(l:bufinfo['windows'], g:statusline_winid) >= 0
		let l:prefix = '%#ActiveBuffer# '
		let l:suffix = ' %*'
	endif
	return l:prefix . fnamemodify(bufname(a:bufnum), ':t') . l:suffix
endfunction

au BufReadPost * | if stridx(&ft, 'commit') >= 0 | exe "startinsert!" | endif

let g:status_line_max_length = 5
function! StatusLineBuffers()
	let l:active_index = -1
	let l:acc = []
	for l:bufnum in nvim_list_bufs()
		let l:bufinfo = getbufinfo(l:bufnum)[0]
		if l:bufinfo.listed == 0
			continue
		end
		let l:entry = StatusLineBufferByNum(bufnum)
		let l:acc = add(l:acc, l:entry)
		if l:entry =~ "^%#ActiveBuffer#"
			let l:active_index = index(l:acc, l:entry)
		endif
	endfor
	if l:active_index >= 0
		" TODO: instead implement this as a wraparound carousel?
		let l:offset = g:status_line_max_length / 2
		let l:min_buf_num = max([0, (l:active_index - offset)])
		let l:max_buf_num = min([(len(l:acc) - 1), (l:min_buf_num + g:status_line_max_length - 1)])
		let l:min_buf_num = max([0, (l:max_buf_num - g:status_line_max_length + 1)])
		let l:buflist = join(l:acc[(l:min_buf_num):(l:max_buf_num)], '')
		let l:prefix = ""
		let l:suffix = ""
		if l:min_buf_num > 0
			let l:prefix = "< "
		endif
		if l:max_buf_num < len(l:acc) - 1
			let l:suffix = " >"
		endif
		return l:prefix . l:buflist . l:suffix
	else
		return join(l:acc, '')
	endif
endfunction

function! StatusLine()
	" try
		return StatusLineBuffers().'%*%=%c,%l/%L (%p%%)'
	" catch
		" return 'buflisterr%*%=%c,%l/%L (%p%%)'
	" endtry
endfunction

" set laststatus=0 showtabline tabline=%!StatusLine()
set statusline=%!StatusLine()

imap <silent> <c-n> <Plug>(completion_trigger)
