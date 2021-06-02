local execute = vim.api.nvim_command
local kmap = vim.api.nvim_set_keymap
local kmapnore = function(mode, keys, command)
  kmap(mode, keys, command, {noremap=true})
end

-- plugin manager
local vimdir = vim.fn.getenv("XDG_CONFIG_HOME")..'/nvim'
local packer_install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim "..packer_install_path)
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
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}
  use 'joshdick/onedark.vim'
  use {'lukas-reineke/indent-blankline.nvim', branch="lua"}
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
	use 'sheerun/vim-polyglot'
end)

local globals = {
  mapleader=" ",
  maplocalleader=" ",
  completion_enable_auto_popup=0,
  indent_guide_auto_colors=1,
  indent_guides_enable_on_vim_startup=1,
  skipview_files={'COMMIT_EDITMSG'},
  indent_blankline_char="┊",
  indent_blankline_filetype_exclude={'help', 'packer'},
  indent_blankline_buftype_exclude={'terminal', 'nofile'},
  indent_blankline_char_highlight='LineNr',
}

for k,v in pairs(globals) do
  vim.g[k] = v
end

local options = {
  inccommand="nosplit",
  tabstop=2,
  softtabstop=2,
  smartindent=true,
  list=true,
  listchars='trail:-,tab:  ,trail:~',
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
  history=100000,
  undofile=true,
  undofir=vimdir..'/undo',
  undolevels=100000,
  undoreload=100000,
  spellfile=vimdir..'/spell/en.utf-8.add',
  ignorecase=true,
  smartcase=true,
  incsearch=true,
  wrapscan=true,
  hlsearch=true,
  foldmethod='syntax',
  foldlevel=99,
  foldnextmax=10,
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
  vim.o[k] = v
end

-- let &fcs = 'eob: '

vim.cmd[[colorscheme base16-donokai]]

-- hi Search cterm=NONE ctermbg=blue ctermfg=black
-- hi LineNr ctermbg=none ctermfg=8
-- hi CursorLineNr ctermbg=18 ctermfg=gray
-- hi IndentGuidesEven ctermbg=18
-- hi Normal ctermbg=NONE
-- hi ColorColumn ctermbg=18
-- hi TooLongColorColumn ctermbg=18 ctermfg=1
-- hi ActiveBuffer ctermbg=4 ctermfg=0
-- hi DirtyBuffer ctermbg=3 ctermfg=0
-- hi StatusLine ctermbg=18 ctermfg=7
-- hi StatusLineNC ctermbg=18 ctermfg=7

execute[[call matchadd('ColorColumn', '\\%81v', 100)]]
execute[[call matchadd('TooLongColorColumn', '\\%121v', 200)]]

vim.cmd[[command! W write]]

local escapes = {'jj', 'jJ', 'Jj', 'JJ', 'jk', 'jK', 'Jk', 'JK'}
for keys in escapes do
  kmap('i', keys, '<Esc>')
end

kmapnore('n', '<C-q>', ':qa<CR>')
kmapnore('n', '<C-q>', '<Esc><C-q>')

require('telescope').setup{
  defaults={
    mappings={
      i={
        ["<C-u>"]=false,
        ["<C-d>"]=false,
      },
    },
    generic_sorter=require'telescope.sorters'.get_fzy_sorter,
    file_sorter=require'telescope.sorters'.get_fzy_sorter,
  }
}

-- TODO: telescope bindings
-- kmapnore('n', '<C-p>', ':GitFiles<CR>')
-- nnoremap <C-o> :Files<CR>
-- nnoremap <C-u> :GFiles?<CR>
-- nnoremap <C-b> :Buffers<CR>

kmapnore('n', '<C-h>', ':TmuxNavigateLeft<CR>')
kmapnore('n', '<C-j>', ':TmuxNavigateDown<CR>')
kmapnore('n', '<C-k>', ':TmuxNavigateUp<CR>')
kmapnore('n', '<C-l>', ':TmuxNavigateRight<CR>')
kmapnore('t', '<C-h>', '<C-\\><C-n>:TmuxNavigateLeft<CR>')
kmapnore('t', '<C-j>', '<C-\\><C-n>:TmuxNavigateDown<CR>')
kmapnore('t', '<C-k>', '<C-\\><C-n>:TmuxNavigateUp<CR>')
kmapnore('t', '<C-l>', '<C-\\><C-n>:TmuxNavigateRight<CR>')

kmap('', '<silent> ,w', '<Plug>CamelCaseMotion_w')
kmap('', '<silent> ,b', '<Plug>CamelCaseMotion_b')
kmap('', '<silent> ,e', '<Plug>CamelCaseMotion_e')
kmap('', '<silent> ,ge', '<Plug>CamelCaseMotion_ge')
kmap('o', '<silent> ib', '<Plug>CamelCaseMotion_ib')
kmap('x', '<silent> ib', '<Plug>CamelCaseMotion_ib')
kmap('o', '<silent> ie', '<Plug>CamelCaseMotion_ie')
kmap('x', '<silent> ie', '<Plug>CamelCaseMotion_ie')

kmap('', '<F3>', 'mw:%s/\\s\\+$//<CR>:let @/ = ""<CR>\'w')
kmap('', '<F4>', ':setlocal spell!<CR>')
kmapnore('n', '<expr> n', "'Nn'[v:searchforward]")
kmapnore('n', '<expr> N', "'nN'[v:searchforward]")
kmapnore('c', '<c-n>', '<down>')
kmapnore('c', '<c-p>', '<up>')
kmapnore('x', '<', '<gv')
kmapnore('x', '>', '>gv')

-- TODO: learn about the wildmenu `q:`
kmap('', '<Space>', '<Nop>', {noremap=true, silent=true})

kmap('n', '<silent> <leader>r', ':source '..vimdir..'/init.vim<CR>:echo \'Reloaded init.vim\'<CR>')
kmap('n', '<silent> <leader>gv', ':e '..vimdir..'/init.vim<CR>')
kmap('n', '<silent> <leader>w', ':bd<CR>')
kmap('n', '<silent> <leader>h', ':b#<CR>')
kmap('n', '<silent> <leader>k', ':bnext<CR>')
kmap('n', '<silent> <leader>j', ':bprevious<CR>')
kmap('n', '<leader>/', ':let @/ = ""<CR>:<BACKSPACE>')
kmapnore('n', '<leader>t', ':split<CR>:term<CR>:resize 24<CR>:startinsert<CR>')
kmapnore('t', '<C-w>', '<C-\\><C-n>:q!<CR>')

function neatFoldText()
	-- TODO: finish this!
	-- local lines_count = vim.foldend - vim.foldstart + 1
	-- local foldchar = vim.fn.matchstr(vim.fillchars, 'fold:\\zs.')
	-- local foldtextstart = vim.fn.strpart('^' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
	-- let foldtextend = printf("%s %".(winwidth(0)-20)."dL", foldtextstart, getline(v:foldstart), lines_count)
	-- let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
	-- return printf("%s%d", substitute(getline(v:foldstart), "^.", ">"), lines_count)
end
-- set foldtext=NeatFoldText()

-- TODO: only update this portion when needed instead of every render?
function statusLineBufferByNum(bufnum)
	local bufinfo = vim.fn.getbufinfo(bufnum)[0]
	local prefix = ' %#InactiveBuffer#'
	local suffix = '%* '

	if bufinfo.changed then
		prefix = '%#DirtyBuffer# '
		suffix = ' %*'
	end

	if bufinfo.hidden == 0 and vim.fn.index(bufinfo.windows, vim.g.statusline_winid) >= 0 then
		prefix = '%#ActiveBuffer# '
		suffix = ' %*'
		if bufinfo.changed then
			prefix = '%#ActiveBuffer# *'
			suffix = ' %*'
		end
  end

	return prefix..vim.fn.fnamemodify(vim.fn.bufname(bufnum), ':t')..suffix
end

execute[[au BufReadPost * | if stridx(&ft, 'commit') >= 0 | exe "startinsert!" | endif]]

local status_line_max_length = 5

function statusLineBuffers()
	-- TODO: mark buffers with unsaved changes

	local active_index = -1
	local acc = {}
	for bufnum in vim.fn.nvim_list_bufs() do
		local bufinfo = vim.fn.getbufinfo(bufnum)[0]
		if bufinfo.listed ~= 0 then
      local entry = statusLineBufferByNum(bufnum)
      table.insert(acc, entry)
      if vim.fn.matchstr(entry, '^%#ActiveBuffer#') then
        active_index = vim.fn.index(acc, entry)
      end
		end
	end
	if active_index >= 0 then
		-- TODO: instead implement this as a wraparound carousel?
		local offset = status_line_max_length / 2
		local min_buf_num = math.max(0, (active_index - offset))
		local max_buf_num = math.min(#acc - 1, min_buf_num + status_line_max_length - 1)
		min_buf_num = math.max(0, max_buf_num - status_line_max_length + 1)
    local buflist = table.concat({table.unpack(acc, min_buf_num, max_buf_num)}, '')
		local prefix = ''
		local suffix = ''
		if min_buf_num > 0 then
			prefix = '< '
		end
		if max_buf_num < (#acc - 1) then
			suffix = ' >'
		end
		return prefix..buflist..suffix
	else
		return table.concat(acc, '')
	end
end

function statusLine()
  return statusLineBuffers()..'%*%=%c,%l/%L (%p%%)'
end

vim.api.nvim_exec[[
augroup slime
  au!
  autocmd BufNewFile,BufRead *.slimleex set syntax=slim
augroup END
]]

vim.o.statusline = '%'..statusLine()

kmap('i', '<silent> <c-n>', '<Plug>(completion_trigger)')
