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

" allows for manual and syntax folding... supposedly
augroup vimrc
	au BufReadPre * setlocal foldmethod=indent
	au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

" jump to last opened position in file except in git commits
let jump_to_pos_blacklist = ['gitcommit']
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") && index(jump_to_pos_blacklist, &ft) | exe "normal! g'\"" | endif
endif

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

" Make any necessary directories in the path when saving a file
fun! <SID>AutoMakeDirectory()
	let s:directory = expand("<afile>:p:h")
	if !isdirectory(s:directory)
		call mkdir(s:directory, "p")
	endif
endfun
autocmd BufWritePre,FileWritePre * :call <SID>AutoMakeDirectory()

if !exists("g:make_args")
	let g:make_args="default"
endif
fun! RunMake()
	split
	if has('nvim')
		" run from the root of the current git repository
		let path = system("git rev-parse --show-toplevel | tr -d '\\n'")
		" TODO: handle non-git situations
		execute 'terminal cd ' . path . ' && make ' . g:make_args
		startinsert
	else
		execute '!make ' . g:make_args
	endif
endfun

" kill the terminal buffer when the process exits
autocmd TermClose * call feedkeys('<cr>')

fun! OpenProjectViewer()
	let path = system("git rev-parse --show-toplevel | tr -d '\\n'")
	execute 'NERDTree' path
endfun

" a toggle-able minimalistic distraction-free text editing mode
let s:distractionFreeMode = 0
fun! DistractionFreeModeFunc()
	if s:distractionFreeMode == 0
		let s:distractionFreeMode = 1
		AirlineToggle
		Goyo
	else
		let s:distractionFreeMode = 0
		Goyo!
		AirlineToggle
		AirlineRefresh
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
	" autocmd WinLeave * call CheckCloseDistractionFreeMode()
endif

command! DistractionFreeMode call DistractionFreeModeFunc()
