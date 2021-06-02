vim.g.vimdir = vim.fn.getenv('XDG_CONFIG_HOME')..'/nvim'

-- plugin manager
local packer_install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local execute = vim.api.nvim_command

if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
	vim.fn.system{'git', 'clone', 'https://github.com/wbthomason/packer.nvim', packer_install_path}
	execute'packadd packer.nvim'
end

vim.api.nvim_exec([[
	augroup Packer
		autocmd!
		autocmd BufWritePost init.lua PackerCompile
	augroup end
]], false)

local use = require('packer').use

require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'editorconfig/editorconfig-vim'
	use 'tpope/vim-sleuth'
	use 'vim-scripts/LargeFile'
	use 'vim-scripts/restore_view.vim'
	use 'christoomey/vim-tmux-navigator'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-rhubarb'
	use 'tpope/vim-commentary'
	use 'tpope/vim-repeat'
	use 'machakann/vim-sandwich'
	use 'michaeljsmith/vim-indent-object'
	use 'wellle/targets.vim'
	use 'bkad/CamelCaseMotion'
	use 'ludovicchabant/vim-gutentags'
	use 'tpope/vim-obsession'
	use 'dhruvasagar/vim-prosession'
	use {'nvim-telescope/telescope.nvim', requires={{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}
	use 'joshdick/onedark.vim'
	use {'lukas-reineke/indent-blankline.nvim', branch='lua'}
	use {'lewis6991/gitsigns.nvim', requires={'nvim-lua/plenary.nvim'}}
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-compe'
	use 'sheerun/vim-polyglot'
	use {'neoclide/coc.nvim', branch='release'}
end)

local globals = {
	mapleader=' ',
	maplocalleader=' ',
	completion_enable_auto_popup=0,
	skipview_files={'COMMIT_EDITMSG'},
	indent_blankline_char='▏',
	indent_blankline_filetype_exclude={'help', 'packer'},
	indent_blankline_buftype_exclude={'terminal', 'nofile'},
	indent_blankline_char_highlight='LineNr',
}

for k,v in pairs(globals) do
	vim.g[k] = v
end

local options = {
	inccommand='nosplit',
	tabstop=2,
	softtabstop=2,
	shiftwidth=2,
	smartindent=true,
	list=true,
	listchars='trail:·,tab:  ,trail:~',
	linebreak=true,
	formatoptions='crql1jn',
	synmaxcol=200,
	lazyredraw=true,
	scrolloff=8,
	sidescrolloff=15,
	mouse='a',
	splitright=true,
	splitbelow=true,
	errorbells=false,
	visualbell=true,
	backup=false,
	writebackup=false,
	swapfile=false,
	timeout=true,
	timeoutlen=150,
	hidden=true,
	shortmess='filnxToOFIac',
	history=1000,
	undofile=true,
	undodir=vim.g.vimdir..'/undo',
	undolevels=1000,
	undoreload=1000,
	spellfile=vim.g.vimdir..'/spell/en.utf-8.add',
	ignorecase=true,
	smartcase=true,
	incsearch=true,
	wrapscan=true,
	hlsearch=true,
	foldmethod='syntax',
	foldlevel=99,
	foldnestmax=10,
	foldlevelstart=99,
	autowrite=false,
	autochdir=true,
	autoread=true,
	modeline=false,
	showmode=false,
	showcmd=false,
	laststatus=2,
	ruler=false,
	termguicolors=true,
}

for k,v in pairs(options) do
	-- print(tostring(k)..tostring(v))
	vim.o[k] = v
end

-- let &fcs = 'eob: '

vim.cmd[[colorscheme base16-donokai]]

vim.cmd[[
hi Search cterm=NONE ctermbg=blue ctermfg=black
hi LineNr ctermbg=none ctermfg=8
hi CursorLineNr ctermbg=18 ctermfg=gray
hi IndentGuidesEven ctermbg=18
hi Normal ctermbg=NONE
hi ColorColumn ctermbg=18
hi TooLongColorColumn ctermbg=18 ctermfg=1
hi ActiveBuffer ctermbg=4 ctermfg=0
hi DirtyBuffer ctermbg=3 ctermfg=0
hi StatusLine ctermbg=18 ctermfg=7
hi StatusLineNC ctermbg=18 ctermfg=7
]]

execute[[call matchadd('ColorColumn', '\\%81v', 100)]]
execute[[call matchadd('TooLongColorColumn', '\\%121v', 200)]]

vim.cmd[[command! W write]]

function kmap(mode, keys, command, opts)
	if opts == nil then opts = {} end
	vim.api.nvim_set_keymap(mode, keys, command, opts)
end

function kmapnore(mode, keys, command)
	kmap(mode, keys, command, {noremap=true})
end

local escapes = {'jj', 'jJ', 'Jj', 'JJ', 'jk', 'jK', 'Jk', 'JK'}
for _,keys in ipairs(escapes) do
	kmap('i', keys, '<Esc>')
end

kmapnore('n', '<C-q>', ':qa<cr>')
kmapnore('n', '<C-q>', '<Esc><C-q>')

kmapnore('n', '<C-p>', '<cmd>Telescope git_files<cr>')
kmapnore('n', '<C-g>', '<cmd>Telescope live_grep<cr>')
kmapnore('n', '<C-b>', '<cmd>Telescope buffers<cr>')
-- kmapnore('n', '???', '<cmd>Telescope help_tags<cr>')

kmapnore('n', '<C-h>', ':TmuxNavigateLeft<cr>')
kmapnore('n', '<C-j>', ':TmuxNavigateDown<cr>')
kmapnore('n', '<C-k>', ':TmuxNavigateUp<cr>')
kmapnore('n', '<C-l>', ':TmuxNavigateRight<cr>')
kmapnore('t', '<C-h>', '<C-\\><C-n>:TmuxNavigateLeft<cr>')
kmapnore('t', '<C-j>', '<C-\\><C-n>:TmuxNavigateDown<cr>')
kmapnore('t', '<C-k>', '<C-\\><C-n>:TmuxNavigateUp<cr>')
kmapnore('t', '<C-l>', '<C-\\><C-n>:TmuxNavigateRight<cr>')

kmap('', ',w', '<Plug>CamelCaseMotion_w', {silent=true})
kmap('', ',b', '<Plug>CamelCaseMotion_b', {silent=true})
kmap('', ',e', '<Plug>CamelCaseMotion_e', {silent=true})
kmap('', ',ge', '<Plug>CamelCaseMotion_ge', {silent=true})
kmap('o', 'ib', '<Plug>CamelCaseMotion_ib', {silent=true})
kmap('x', 'ib', '<Plug>CamelCaseMotion_ib', {silent=true})
kmap('o', 'ie', '<Plug>CamelCaseMotion_ie', {silent=true})
kmap('x', 'ie', '<Plug>CamelCaseMotion_ie', {silent=true})

kmap('', '<F3>', 'mw:%s/\\s\\+$//<cr>:let @/ = ""<cr>\'w')
kmap('', '<F4>', ':setlocal spell!<cr>')
kmapnore('n', '<expr> n', "'Nn'[v:searchforward]")
kmapnore('n', '<expr> N', "'nN'[v:searchforward]")
kmapnore('c', '<c-n>', '<down>')
kmapnore('c', '<c-p>', '<up>')
kmapnore('x', '<', '<gv')
kmapnore('x', '>', '>gv')

-- TODO: learn about the wildmenu `q:`
kmap('', '<Space>', '<Nop>', {noremap=true, silent=true})

kmap('n', '<leader>r', ':luafile '..vim.g.vimdir..'/init.lua<cr>:echo \'Reloaded init.lua\'<cr>', {silent=true})
kmap('n', '<leader>gv', ':e '..vim.g.vimdir..'/init.lua<cr>', {silent=true})
kmap('n', '<leader>w', ':bd<cr>', {silent=true})
kmap('n', '<leader>h', ':b#<cr>', {silent=true})
kmap('n', '<leader>k', ':bnext<cr>', {silent=true})
kmap('n', '<leader>j', ':bprevious<cr>', {silent=true})
kmap('n', '<leader>/', ':let @/ = ""<cr>:<BACKSPACE>', {silent=true})
kmapnore('n', '<leader>t', ':split<cr>:term<cr>:resize 24<cr>:startinsert<cr>', {silent=true})
kmapnore('t', '<C-w>', '<C-\\><C-n>:q!<cr>', {silent=true})

kmap('i', '<c-n>', '<Plug>(completion_trigger)', {silent=true})

execute[[au BufReadPost * | if stridx(&ft, 'commit') >= 0 | exe "startinsert!" | endif]]

vim.api.nvim_exec([[
augroup slime
	au!
	autocmd BufNewFile,BufRead *.slimleex set syntax=slim
augroup END
]], false)

require('telescope').setup{
	defaults={
		mappings={
			i={
				['<C-u>']=false,
				['<C-d>']=false,
			},
		},
		generic_sorter=require'telescope.sorters'.get_fzy_sorter,
		file_sorter=require'telescope.sorters'.get_fzy_sorter,
	}
}

require('fold').setup()
require('statusline').setup()
require('lsp').setup()
