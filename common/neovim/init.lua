vim.g.vimdir = os.getenv('XDG_CONFIG_HOME') .. '/nvim'

local packer_install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if #vim.fn.glob(packer_install_path) == 0 then
	vim.fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', packer_install_path }
	vim.cmd 'packadd packer.nvim'
end

local has_words_before = function()
	local line, col = vim.api.nvim_win_get_cursor(0)
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local packer = require 'packer'

packer.startup(function()
	local plugins = {
		'wbthomason/packer.nvim', -- neovim plugin manager

		'vim-scripts/LargeFile', -- degrade gracefully with large files
		'tpope/vim-repeat', -- enable repeat for plugin maps
		'tpope/vim-sleuth', -- use whatever whitespace is in the file
		'editorconfig/editorconfig-vim', -- handle .editorconfig files
		'christoomey/vim-tmux-navigator', -- navigate vim splits and tmux panes fluidly
		'machakann/vim-sandwich', -- edit surrounding characters
		'michaeljsmith/vim-indent-object', -- adds indent-level text objects
		-- 'wellle/targets.vim', -- add many other text objects
		'bkad/CamelCaseMotion', -- invaluable motions for properly operating on various casings

		{
			-- session management
			'olimorris/persisted.nvim',
			config = function()
				local should_autoload = #vim.v.argv >= 1
				require 'persisted'.setup {
					autoload = should_autoload,
					autosave = should_autoload,
				}
			end
		},
		{
			-- toggle comments
			'terrortylor/nvim-comment',
			config = function()
				require 'nvim_comment'.setup()
			end
		},
		{
			-- fuzzy finder
			'nvim-telescope/telescope.nvim',
			requires = {
				'nvim-lua/popup.nvim',
				'nvim-lua/plenary.nvim',
			}
		},
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			run = 'make',
		},
		{
			'tzachar/cmp-fuzzy-path',
			requires = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' },
		},

		-- TODO: add keymap <leader>ig for toggling these
		'lukas-reineke/indent-blankline.nvim', -- indentation guide lines
		'L3MON4D3/LuaSnip',

		{
			-- completion engine
			'hrsh7th/nvim-cmp',
			config = function()
				local cmp = require 'cmp'
				local luasnip = require 'luasnip'

				--[[
				local prev_item = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end

				local next_item = function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end
				]] --

				cmp.setup {
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					window = {
					},
					mapping = {
						['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
						['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
						['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
						-- ['<C-y>'] = cmp.config.n
						['<C-e>'] = cmp.mapping {
							i = cmp.mapping.close,
							c = cmp.mapping.close,
						},
						['<CR>'] = cmp.mapping.confirm { select = false },
						-- ["<Tab>"] = cmp.mapping(next_item, { "i", "s" }),
						-- ["<S-Tab>"] = cmp.mapping(prev_item, { "i", "s" }),
						-- ['<C-n>'] = cmp.mapping(next_item, { "i", "s" }),
						-- ['<C-p>'] = cmp.mapping(prev_item, { "i", "s" }),
					},
					sources = cmp.config.sources({
						{ name = 'nvim_lsp' },
						{ name = 'nvim_lsp_signature_help' },
						{ name = 'luasnip' },
					}, {
						{ name = 'buffer' },
						{ name = 'path' },
						{ name = 'fuzzy_path' },
					}),
					formatting = {
						format = require("lspkind").cmp_format {
							with_text = true,
							menu = {
								nvim_lsp = "[LSP]",
							},
						}
					},
				}

				cmp.setup.cmdline('/', {
					mapping = cmp.mapping.preset.cmdline(),
					sources = {
						{ name = 'buffer' },
						{ name = 'fuzzy_path' },
					}
				})

				cmp.setup.cmdline(':', {
					mapping = cmp.mapping.preset.cmdline(),
					sources = cmp.config.sources({
						{ name = 'path' }
					}, {
						{ name = 'cmdline' }
					})
				})
			end,
		},
		'neovim/nvim-lspconfig', -- language server configuration helper
		'williamboman/nvim-lsp-installer', -- plugin containing installation commands for many language servers
		'hrsh7th/cmp-nvim-lsp-signature-help',
		'hrsh7th/cmp-nvim-lsp', -- add lsp to completion engine
		'hrsh7th/cmp-buffer', -- add buffer information to completion engine
		'hrsh7th/cmp-path', -- add filesystem information to complete enging
		'hrsh7th/cmp-cmdline', -- add completion for vim commands
		'onsails/lspkind-nvim',
		'saadparwaiz1/cmp_luasnip',
		-- TODO: automate this installation process of :COQdeps<cr>:COQnow<cr>
		-- {'ms-jpq/coq_nvim', branch = 'coq'},
		-- {'ms-jpq/coq.thirdparty', branch = '3p'},
		{
			-- syntax highlighting and indentation
			'nvim-treesitter/nvim-treesitter',
			run = ':TSUpdate',
			config = function()
				require 'nvim-treesitter.configs'.setup {
					ensure_installed = "all",
					sync_install = false,
					ignore_install = { "phpdoc" },
					indent = {
						enable = true,
					},
					highlight = {
						enable = true,
						disable = {},
						-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
						-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
						-- Using this option may slow down your editor, and you may see some duplicate highlights.
						-- Instead of true it can also be a list of languages
						-- additional_vim_regex_highlighting = false,
					},
				}
			end
		},
		'lukas-reineke/lsp-format.nvim',
	}
	for _, plugin in pairs(plugins) do packer.use(plugin) end
end)

local globals = {
	mapleader = ' ',
	maplocalleader = ' ',
	-- skipview_files = { 'COMMIT_EDITMSG' },
	indent_blankline_char = '▏',
	indent_blankline_filetype_exclude = { 'help', 'packer' },
	indent_blankline_buftype_exclude = { 'terminal', 'nofile' },
	indent_blankline_char_highlight = 'LineNr',
}
for k, v in pairs(globals) do vim.g[k] = v end

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
	undodir = vim.fn.stdpath 'data' .. '/undo',
	undolevels = 1000,
	undoreload = 1000,
	spellfile = vim.fn.stdpath 'data' .. '/spell/en.utf-8.add',
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
	autochdir = false,
	autoread = true,
	modeline = false,
	showmode = false,
	showcmd = false,
	laststatus = 2,
	ruler = false,
	number = true,
	-- cmdheight = 0,
}
for k, v in pairs(options) do
	vim.o[k] = v
end

vim.api.nvim_command 'colorscheme donokai'

function SynGroup()
	local s = vim.fn.synID(vim.fn.line('.'), vim.fn.col('.'), 1)
	-- TODO: instead of printing, put it in a popup? virtual text?
	print(vim.fn.synIDattr(s, 'name') .. ' -> ' .. vim.fn.synIDattr(vim.fn.synIDtrans(s), 'name'))
end

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank { higroup = 'Search', timeout = 200 }
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	callback = function()
		vim.cmd 'startinsert'
	end,
})

vim.cmd 'command! W write'

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

for _, keys in ipairs { 'jj', 'jJ', 'Jj', 'JJ', 'jk', 'jK', 'Jk', 'JK' } do
	vim.api.nvim_set_keymap('i', keys, '<Esc>', {})
end

local m = {
	s = { silent = true },
	n = { noremap = true },
	sn = { silent = true, noremap = true },
}
local keymap = {
	n = {
		['<leader>/'] = { ':let @/ = ""<cr>:<BACKSPACE>', m.s },

		['<leader>r'] = { ':luafile ' .. vim.g.vimdir .. '/init.lua<cr>:echo \'Reloaded init.lua\'<cr>', m.s },
		['<leader>gv'] = { ':e ' .. vim.g.vimdir .. '/init.lua<cr>', m.s },

		['<leader>w'] = { ':bd<cr>', m.s },
		['<leader>h'] = { ':b#<cr>', m.s },
		['<leader>k'] = { ':bnext<cr>', m.s },
		['<leader>j'] = { ':bprevious<cr>', m.s },

		['<c-q>'] = ':qa<cr>',

		['<c-p>'] = '<cmd>Telescope git_files<cr>',
		['<c-g>'] = '<cmd>Telescope live_grep<cr>',
		['<c-b>'] = '<cmd>Telescope buffers<cr>',
		['<leader>t'] = '<cmd>Telescope help_tags<cr>',

		['<c-h>'] = ':TmuxNavigateLeft<cr>',
		['<c-j>'] = ':TmuxNavigateDown<cr>',
		['<c-k>'] = ':TmuxNavigateUp<cr>',
		['<c-l>'] = ':TmuxNavigateRight<cr>',

		['<expr> n'] = "'Nn'[v:searchforward]",
		['<expr> N'] = "'nN'[v:searchforward]",
		['<c-m>'] = ':lua SynGroup()<cr>',

		['<leader>s'] = "<cmd>SessionToggle<cr><cmd>echo 'Persisting Session: ' .. g:persisting .. ' (' .. getcwd() .. ')'<cr>",
		['<leader>S'] = "<cmd>SessionSave<cr><cmd>echo 'Saved Session: ' .. getcwd()<cr>",
		['<leader>l'] = "<cmd>SessionLoad<cr><cmd>echo 'Loaded Session: ' .. getcwd()<cr>",
		['<leader>L'] = "<cmd>SessionLoadLast<cr><cmd>echo 'Loaded Last Session: ' .. getcwd()<cr>",
		['<leader>d'] = "<cmd>SessionDelete<cr><cmd>echo 'Deleted Session for cwd: ' .. getcwd()<cr>",
	},

	-- terminal bindings
	t = {},

	[''] = {
		['<space>'] = { '<nop>', m.sn },

		-- remove trailing whitespace
		['<f3>'] = 'mw:%s/\\s\\+$//<cr>:let @/ = ""<cr>\'w',
		['<leader>gs'] = ':setlocal spell!<cr>',
		[',w'] = { '<Plug>CamelCaseMotion_w', m.s },
		[',b'] = { '<Plug>CamelCaseMotion_b', m.s },
		[',e'] = { '<Plug>CamelCaseMotion_e', m.s },
		[',ge'] = { '<Plug>CamelCaseMotion_ge', m.s },
	},
	o = {
		['ib'] = { '<Plug>CamelCaseMotion_ib', m.s },
		['ie'] = { '<Plug>CamelCaseMotion_ie', m.s },
	},
	x = {
		['<'] = '<gv',
		['>'] = '>gv',
		['ib'] = { '<Plug>CamelCaseMotion_ib', m.s },
		['ie'] = { '<Plug>CamelCaseMotion_ie', m.s },
	},
	i = {
		['<c-q>'] = '<esc><c-q>',
	},
}
for mode, mappings in pairs(keymap) do
	for key, bind in pairs(mappings) do
		if type(bind) == 'table' then
			vim.api.nvim_set_keymap(mode, key, bind[1], bind[2])
		else
			vim.api.nvim_set_keymap(mode, key, bind, {})
		end
	end
end

local status_line_max_length = 5

-- TODO: only update this portion when needed instead of every render?
local status_line_buffer_by_num = function(bufnum)
	local is_active = false
	local bufinfo = vim.fn.getbufinfo(bufnum)[1]
	local prefix = ' %#InactiveBuffer#'
	local suffix = '%* '

	if bufinfo.changed == 1 then
		prefix = '%#DirtyBuffer# '
		suffix = ' %*'
	end

	local windex = vim.fn.index(bufinfo.windows, vim.g.statusline_winid)
	if bufinfo.hidden and windex >= 0 then
		is_active = true
		prefix = '%#ActiveBuffer# '
		suffix = ' %*'
		if bufinfo.changed == 1 then
			prefix = '%#ActiveDirtyBuffer# *'
			suffix = ' %*'
		end
	end

	return (prefix .. vim.fn.fnamemodify(vim.fn.bufname(bufnum), ':t') .. suffix), is_active
end

local status_line_buffers = function()
	local active_index = -1
	local acc = {}
	for _, bufnum in ipairs(vim.api.nvim_list_bufs()) do
		local bufinfo = vim.fn.getbufinfo(bufnum)[1]
		if bufinfo.listed ~= 0 then
			local entry, is_active = status_line_buffer_by_num(bufnum)
			table.insert(acc, entry)
			if is_active then
				active_index = #acc
			end
		end
	end
	if active_index >= 0 then
		local offset = status_line_max_length / 2
		local min_buf_num = math.max(0, (active_index - offset))
		local max_buf_num = math.min(#acc - 1, min_buf_num + status_line_max_length - 1)
		min_buf_num = math.max(0, max_buf_num - status_line_max_length + 1)
		local buflist = table.concat({ unpack(acc, min_buf_num + 1, max_buf_num + 1) }, '')
		local prefix = ''
		local suffix = ''
		if min_buf_num > 0 then
			prefix = '< '
		end
		if max_buf_num < (#acc - 1) then
			suffix = ' >'
		end
		return prefix .. buflist .. suffix
	else
		local suffix = ''
		if #acc - 1 > status_line_max_length then
			suffix = ' >'
		end
		local buflist = table.concat({ unpack(acc, 1, math.min(#acc, status_line_max_length)) }, '')
		return buflist .. suffix .. active_index
	end
end

local whitespace = function()
	local result = ""
	if vim.o.expandtab == true then
		result = result .. vim.o.shiftwidth .. "S"
	else
		result = result .. vim.o.tabstop .. "T"
	end
	return result
end

function StatusLine()
	return status_line_buffers() .. '%*%=%{&filetype} %l;%c (%p%%/%L) ' .. whitespace()
end

vim.o.statusline = '%!v:lua.StatusLine()'

local lsp = require 'lspconfig'
-- local coq = require'coq'

local lsp_format = require 'lsp-format'

local on_attach = function(client, bufnr)
	lsp_format.on_attach(client)

	local lsp_mappings = {
		['n'] = {
			['<leader>e'] = 'vim.diagnostic.open_float()',
			['<C-a>'] = 'vim.lsp.buf.signature_help()',
			['gi'] = 'vim.lsp.buf.implementation()',
			['K'] = 'vim.lsp.buf.hover()',
			['gd'] = 'vim.lsp.buf.definition()',
			['gD'] = 'vim.lsp.buf.declaration()',
			['g['] = 'vim.diagnostic.goto_prev()',
			['g]'] = 'vim.diagnostic.goto_next()',
			['<space>wa'] = 'vim.lsp.buf.add_workspace_folder()',
			['<space>wr'] = 'vim.lsp.buf.remove_workspace_folder()',
			['<space>wl'] = 'print(vim.inspect(vim.lsp.buf.list_workspace_folders()))',
			['<space>D'] = 'vim.lsp.buf.type_definition()',
			['<space>rn'] = 'vim.lsp.buf.rename()',
			['<space>ca'] = 'vim.lsp.buf.code_action()',
			['gr'] = 'vim.lsp.buf.references()',
			['<space>f'] = 'vim.lsp.buf.formatting_seq_sync()',
		}
	}

	for mode, mappings in pairs(lsp_mappings) do
		for keys, script in pairs(mappings) do
			vim.api.nvim_buf_set_keymap(bufnr, mode, keys, '<cmd>lua ' .. script .. '<cr>', m.sn)
		end
	end
end

--[[

set els_path ~/.local/share/nvim/lsp_servers/elixir
curl -fLO https://github.com/elixir-lsp/elixir-ls/releases/latest/download/elixir-ls.zip
mkdir -p $els_path
unzip elixir-ls.zip -d $els_path/elixir-ls/
chmod +x $els_path/elixir-ls/language_server.sh

]] --

local lsp_configs = {
	gopls = {},
	elixirls = {
		cmd = { vim.fn.expand '~/.local/share/nvim/lsp_servers/elixir/elixir-ls/language_server.sh' },
		settings = {
			elixirLS = {
				dialyzerEnabled = true,
				fetchDeps = false,
			}
		}
	},
	sumneko_lua = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { 'vim' }
				}
			}
		}
	},
	vimls = {},
	rust_analyzer = {},
	-- tsserver = {},
	pylsp = {},
	denols = {
		root_dir = lsp.util.root_pattern("deno.json"),
	},
}

local capabilities = require 'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local common_config = {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150
	},
}

for server, config in pairs(lsp_configs) do
	for k, v in pairs(common_config) do config[k] = v end
	lsp[server].setup(config)
end

require 'nvim-lsp-installer'.setup {
	automatic_installation = true,
}
