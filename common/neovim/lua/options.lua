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
	undodir = vimdir .. '/undo',
	undolevels = 1000,
	undoreload = 1000,
	spellfile = vimdir .. '/spell/en.utf-8.add',
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
	termguicolors = true,
}
for k,v in pairs(options) do
	vim.o[k] = v
end

vim.api.nvim_exec([[
	hi Search cterm=NONE ctermbg=blue ctermfg=black
	hi LineNr ctermbg=0 ctermfg=8
	hi CursorLineNr ctermbg=18 ctermfg=gray
	hi IndentGuidesEven ctermbg=18
	hi Normal ctermbg=NONE
	hi ActiveBuffer ctermbg=4 ctermfg=0
	hi DirtyBuffer ctermbg=3 ctermfg=0
	hi StatusLine ctermbg=1 ctermfg=7
	hi StatusLineNC ctermbg=2 ctermfg=7
	command! W write
	augroup oncommit
		au! BufReadPost *
		if stridx(&ft, 'commit') >= 0
			exe "startinsert!"
		endif
	augroup END
	augroup slime
		au! BufNewFile,BufRead *.slimleex set syntax=slim
	augroup END
	colorscheme base16-donokai
]], false)
