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
	nnoremap <C-t> :vsplit term://bash<CR>
	nnoremap <C-S-T> :split term://bash<CR>
	" tnoremap <C-t> <C-\><C-n>:call TerminalSplit()<CR>

	" close the terminal
	tnoremap <C-w> <C-\><C-n>:q!<CR>

	" moving between terminal splits
	" tnoremap <C-h> <C-\><C-n><C-w>h
	" tnoremap <C-j> <C-\><C-n><C-w>j
	" tnoremap <C-k> <C-\><C-n><C-w>k
	" tnoremap <C-l> <C-\><C-n><C-w>l
endif

" enter insert mode when entering a terminal buffer
augroup InsertModeOnBlankTerminal
	autocmd BufWinEnter,WinEnter term://* startinsert
augroup END

" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
	let line = line('.')
	let column = col('.')
	let lastline = line('$')
	let indent = indent(line)
	let stepvalue = a:fwd ? 1 : -1
	while (line > 0 && line <= lastline)
		let line = line + stepvalue
		if ( ! a:lowerlevel && indent(line) == indent ||
					\ a:lowerlevel && indent(line) < indent)
			if (! a:skipblanks || strlen(getline(line)) > 0)
				if (a:exclusive)
					let line = line - stepvalue
				endif
				exe line
				exe 'normal ' column . '|'
				return
			endif
		endif
	endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>

" run make with leader,m
nnoremap <leader>m :call RunMake()<CR>

" show project viewer with leader,n
nnoremap <leader>n :call OpenProjectViewer()<CR>

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
	echo '@'.getcmdline()
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
nnoremap <leader>/ :let @/ = ""<CR>:<BACKSPACE>

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

" run `make run`
nnoremap <leader>R :ProjectRootExe !make run<cfile><CR><CR>

" insert newline
" doesn't work in terminals?
" noremap <S-Enter> i<Enter><Esc>
" noremap <C-o> i<Enter><Esc>

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

nmap ga <Plug><EasyAlign>
xmap ga <Plug><EasyAlign>

nnoremap <silent> <Leader>df :DistractionFreeMode<CR>
