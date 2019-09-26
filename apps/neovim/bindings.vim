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
	tnoremap <C-h> :TmuxNavigateLeft<CR>
	tnoremap <C-j> :TmuxNavigateDown<CR>
	tnoremap <C-k> :TmuxNavigateUp<CR>
	tnoremap <C-l> :TmuxNavigateRight<CR>
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
		if ( a:lowerlevel == 0 && indent(line) == indent ||
					\ a:lowerlevel == 1 && indent(line) < indent || 
					\ a:lowerlevel == -1 && indent(line) > indent)
			if (! a:skipblanks || strlen(getline(line)) > 0)
				if (a:exclusive)
					let line = line - stepvalue
				endif
				exe line
				exe 'normal ' (column+1) . '|'
				return
			endif
		endif
	endwhile
endfunction

" moving back and forth between lines of same or lower indentation should be sane
nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
nnoremap <silent> [<C-l> :call NextIndent(0, 0, -1, 1)<CR>
nnoremap <silent> ]<C-l> :call NextIndent(0, 1, -1, 1)<CR>
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

" NERDTree bindings
" show file manager in current directory
nnoremap <C-n>      :NERDTreeToggle<CR>
" show file manager in git repo root
nnoremap <leader>n  :call NERDProjectViewer()<CR>
" focus the current file in NERDTree
nnoremap <leader>gn :NERDTreeFind<CR>

" don't kill vim
" REBIND
nnoremap <leader>K <Nop>
nnoremap <S-K> <NOP>

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

nnoremap <leader>r :source ~/.config/nvim/init.vim<CR>

" change buffers with leader,tab
nnoremap <leader><Tab>		:bnext<CR>
nnoremap <leader><S-Tab>	:bprevious<CR>

" fast word change
nnoremap <leader>c ciw
nnoremap <leader>C ciW

" fast splits
nnoremap <silent> <leader>s :split<CR>
nnoremap <silent> <leader>v :vsplit<CR>

" fast split closing
nnoremap <silent> <leader>q <C-w>q

" clear search higlight
nnoremap <silent> <leader>/ :let @/ = ""<CR>:<BACKSPACE>

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

" camel case motions
map <silent> ,w <Plug>CamelCaseMotion_w
map <silent> ,b <Plug>CamelCaseMotion_b
map <silent> ,e <Plug>CamelCaseMotion_e
map <silent> ,ge <Plug>CamelCaseMotion_ge

" inner _ objects
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie

" remove trailing whitespace
map <F3> mw:%s/\s\+$//<CR>:let @/ = ""<CR>'w

" close buffer with leader-w
nnoremap <silent> <leader>w :bd<CR>

" toggle spell checking:
map <F4> :setlocal spell!<CR>

" open urls, files, etc. example: http://google.com:
noremap <leader>o :!xdg-open <cfile><CR><CR>

" insert newline
" NOTE: doesn't work in terminals?
" noremap <S-Enter> i<Enter><Esc>
" noremap <C-o> i<Enter><Esc>

" prevent wildmenu
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

" distraction-free mode
nnoremap <silent> <leader>df :DistractionFreeMode<CR>

" recalc syntax highlighting
nnoremap <leader>gs :syntax sync fromstart<CR>

" lsp bindings

" coc

" open coc config
nnoremap <leader><space>c :CocConfig<CR>

" go to definitions
nnoremap <leader>d <Plug>(coc-jump-definition)

" ale

" go to definitions
" nnoremap <leader>gd :ALEGoToDefinition<CR>
" nnoremap <leader>gh :ALEGoToDefinitionInSplit<CR>
" nnoremap <leader>gv :ALEGoToDefinitionInVSplit<CR>

