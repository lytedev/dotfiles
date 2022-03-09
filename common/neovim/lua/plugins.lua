local packer_install_path = vim.fn.stdpath'data' .. '/site/pack/packer/start/packer.nvim'
if #vim.fn.glob(packer_install_path) == 0 then
	vim.fn.system{'git', 'clone', 'https://github.com/wbthomason/packer.nvim', packer_install_path}
	vim.api.nvim_command'packadd packer.nvim'
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
				-- TODO: only load session if no arguments passed?
				require'persisted'.setup{
					autoload = true,
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
		-- TODO: add keymap <leader>ig for toggling these
		'lukas-reineke/indent-blankline.nvim', -- indentation guide lines
		'neovim/nvim-lspconfig', -- language server configuration helper
    'williamboman/nvim-lsp-installer', -- plugin containing installation commands for many language servers
		'hrsh7th/cmp-nvim-lsp', -- add lsp to completion engine
		'hrsh7th/cmp-buffer', -- add buffer information to completion engine
		'hrsh7th/cmp-path', -- add filesystem information to complete enging
		'hrsh7th/cmp-cmdline', -- add completion for vim commands
		{
			-- completion engine
			'hrsh7th/nvim-cmp',
			config = function()
				local cmp = require'cmp'

				cmp.setup{
					mapping = {
						['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
						['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
						['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
						['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
						['<C-e>'] = cmp.mapping{
							i = cmp.mapping.abort(),
							c = cmp.mapping.close(),
						},
						['<CR>'] = cmp.mapping.confirm{select = true}, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					},
					sources = cmp.config.sources{
						{ name = 'nvim_lsp' },
						{ name = 'buffer' },
					},
				}

				cmp.setup.cmdline('/', {
					sources = {
						{name = 'buffer'},
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
	}
	for _,plugin in pairs(plugins) do packer.use(plugin) end
end)
