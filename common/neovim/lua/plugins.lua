local packer_install_path = vim.fn.stdpath'data' .. '/site/pack/packer/start/packer.nvim'
if #vim.fn.glob(packer_install_path) == 0 then
	vim.fn.system{'git', 'clone', 'https://github.com/wbthomason/packer.nvim', packer_install_path}
	vim.api.nvim_command'packadd packer.nvim'
end

local has_words_before = function()
	local line, col = vim.api.nvim_win_get_cursor(0)
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local packer = require'packer'

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
		'wellle/targets.vim', -- add many other text objects
		'bkad/CamelCaseMotion', -- invaluable motions for properly operating on various casings

		{
			-- session management
			'olimorris/persisted.nvim',
			config = function()
				local should_autoload = #vim.v.argv == 1
				require'persisted'.setup{
					autoload = should_autoload,
					autosave = should_autoload,
				}
			end
		},
		{
			-- toggle comments
			'terrortylor/nvim-comment',
			config = function()
				require'nvim_comment'.setup()
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
			requires = {'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim'},
		},
		-- TODO: add keymap <leader>ig for toggling these
		'lukas-reineke/indent-blankline.nvim', -- indentation guide lines
		'L3MON4D3/LuaSnip',

		'neovim/nvim-lspconfig', -- language server configuration helper
		'williamboman/nvim-lsp-installer', -- plugin containing installation commands for many language servers
		'hrsh7th/cmp-nvim-lsp-signature-help',
		'hrsh7th/cmp-nvim-lsp', -- add lsp to completion engine
		'hrsh7th/cmp-buffer', -- add buffer information to completion engine
		'hrsh7th/cmp-path', -- add filesystem information to complete enging
		'hrsh7th/cmp-cmdline', -- add completion for vim commands
		'saadparwaiz1/cmp_luasnip',
		{
			-- completion engine
			'hrsh7th/nvim-cmp',
			config = function()
				local cmp = require'cmp'
				local luasnip = require'luasnip'

				cmp.setup{
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					mapping = {
						['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
						['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
						['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
						['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
						['<C-e>'] = cmp.mapping{
							i = cmp.mapping.abort(),
							c = cmp.mapping.close(),
						},
						['<Tab>'] = cmp.config.disable,
						['<S-Tab>'] = cmp.config.disable,
						['<CR>'] = cmp.mapping.confirm{select = true}, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
						--[[ ["<Tab>"] = cmp.mapping(function(fallback)

							if cmp.visible() then
								cmp.select_next_item()
							elseif luasnip.expand_or_jumpable() then
								luasnip.expand_or_jump()
							elseif has_words_before() then
								cmp.complete()
							else
								fallback()
							end
						end, { "i", "s" }),
						["<S-Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							elseif luasnip.jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end, { "i", "s" }),
						]]--
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
				}

				cmp.setup.cmdline('/', {
					sources = {
						{name = 'buffer'},
						{name = 'fuzzy_path'},
					}
				})

				cmp.setup.cmdline(':', {
					sources = cmp.config.sources({
						{name = 'path'}
					}, {
						{name = 'cmdline'}
					})
				})
			end,
		},
		-- TODO: automate this installation process of :COQdeps<cr>:COQnow<cr>
		-- {'ms-jpq/coq_nvim', branch = 'coq'},
		-- {'ms-jpq/coq.thirdparty', branch = '3p'},
		{
			-- syntax highlighting and indentation
			'nvim-treesitter/nvim-treesitter',
			run = ':TSUpdate',
			config = function()
				require'nvim-treesitter.configs'.setup {
					ensure_installed = "maintained",
					sync_install = false,
					ignore_install = {},
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
	for _,plugin in pairs(plugins) do packer.use(plugin) end
end)
