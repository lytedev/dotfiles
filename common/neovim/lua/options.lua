local globals = {
	coq_settings = {
		['display.icons.mode'] = 'none'
	},
	dashboard_default_executive = 'telescope',
	mapleader = ' ',
	maplocalleader = ' ',
	completion_enable_auto_popup = 0,
	skipview_files = {'COMMIT_EDITMSG'},
	indent_blankline_char = '▏',
	indent_blankline_filetype_exclude = {'help', 'packer'},
	indent_blankline_buftype_exclude = {'terminal', 'nofile'},
	indent_blankline_char_highlight = 'LineNr',
	svelte_preprocessors = {'typescript', 'coffeescript', 'sass', 'pug'},
	svelte_preprocessor_tags = {
		{name = 'sass', tag = 'lang', as = 'sass'},
		{name = 'coffeescript', tag = 'lang', as = 'coffeescript'},
		{name = 'pug', tag = 'pug', as = 'pug'},
	},
	svelte_indent_script = 0,
	svelte_indent_style = 0,
}
for k,v in pairs(globals) do vim.g[k] = v end

local options = {
	clipboard = 'unnamedplus',
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

function SynGroup()
	local s = vim.fn.synID(vim.fn.line('.'), vim.fn.col('.'), 1)
	print(vim.fn.synIDattr(s, 'name') .. ' -> ' .. vim.fn.synIDattr(vim.fn.synIDtrans(s), 'name'))
end

vim.api.nvim_exec([[
au! TextYankPost * silent! lua vim.highlight.on_yank { higroup='Search', timeout=200 }
au! FileType gitcommit exec 'norm gg' | startinsert!
au! BufNewFile,BufRead *.slimleex set syntax=slime
command! W write
]], true)
-- au! VimEnter * COQnow -s

function NeatFoldText()
	-- TODO: finish this!
	-- local lines_count = vim.foldend - vim.foldstart + 1
	-- local foldchar = vim.fn.matchstr(vim.fillchars, 'fold:\\zs.')
	-- local foldtextstart = vim.fn.strpart('^' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
	-- let foldtextend = printf("%s %".(winwidth(0)-20)."dL", foldtextstart, getline(v:foldstart), lines_count)
	-- let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
	-- return printf("%s%d", substitute(getline(v:foldstart), "^.", ">"), lines_count)
end
-- set foldtext=NeatFoldText()
