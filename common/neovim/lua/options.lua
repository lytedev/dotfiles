local globals = {
	mapleader = ' ',
	maplocalleader = ' ',
	completion_enable_auto_popup = 0,
	skipview_files = {'COMMIT_EDITMSG'},
	indent_blankline_char = '▏',
	indent_blankline_filetype_exclude = {'help', 'packer'},
	indent_blankline_buftype_exclude = {'terminal', 'nofile'},
	indent_blankline_char_highlight = 'LineNr',
}
for k,v in pairs(globals) do vim.g[k] = v end

local options = {
	inccommand = 'nosplit',
	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 2,
	smartindent = true,
	list = true,
	listchars = 'trail:·,tab:  ',
	linebreak = true,
	formatoptions = 'crql1jn',
	synmaxcol = 200,
	lazyredraw = true,
	scrolloff = 8,
	sidescrolloff = 15,
	mouse = 'a',
	splitright = true,
	splitbelow = true,
	errorbells = false,
	visualbell = true,
	backup = false,
	writebackup = false,
	swapfile = false,
	timeout = true,
	timeoutlen = 150,
	hidden = true,
	shortmess = 'filnxToOFIac',
	history = 1000,
	undofile = true,
	undodir = vim.g.vimdir .. '/undo',
	undolevels = 1000,
	undoreload = 1000,
	spellfile = vim.g.vimdir .. '/spell/en.utf-8.add',
	ignorecase = true,
	smartcase = true,
	incsearch = true,
	wrapscan = true,
	hlsearch = true,
	foldmethod = 'syntax',
	foldlevel = 99,
	foldnestmax = 10,
	foldlevelstart = 99,
	autowrite = false,
	autochdir = true,
	autoread = true,
	modeline = false,
	showmode = false,
	showcmd = false,
	laststatus = 2,
	ruler = false,
	number = true,
}
for k,v in pairs(options) do
	vim.o[k] = v
end

vim.api.nvim_command'colorscheme donokai'

vim.api.nvim_command[[
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
nnoremap <c-m> :call SynGroup()<cr>
]]

-- vim.api.nvim_command[[
-- 	command! W write
-- 	augroup oncommit
-- 		au! BufReadPost *
-- 		if stridx(&ft, 'commit') >= 0
-- 			exe "startinsert!"
-- 		endif
-- 	augroup END
-- 	augroup slime
-- 		au! BufNewFile,BufRead *.slimleex set syntax=slim
-- 	augroup END
-- ]]
