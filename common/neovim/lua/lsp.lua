local lsp = require 'lspconfig'
-- local coq = require'coq'

-- TODO: replace with nvim lsp bindings for jumping to next linting issue?
--vim.api.nvim_set_keymap('n', '[d', '<cmd>)<CR>', opts)

local opts = {
	noremap = true,
	silent = true,
}

local lsp_format = require 'lsp-format'

local on_attach = function(client, bufnr)
	lsp_format.on_attach(client)

	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)

	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-a>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-a>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>', opts)
end

local capabilities = require 'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local common_config = {
	capabilities = capabilities,
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150
	},
}

--[[

set els_path ~/.local/share/nvim/lsp_servers/elixir
curl -fLO https://github.com/elixir-lsp/elixir-ls/releases/latest/download/elixir-ls.zip
mkdir -p $els_path
unzip elixir-ls.zip -d $els_path/elixir-ls/
chmod +x $els_path/elixir-ls/language_server.sh

]]

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

for server, config in pairs(lsp_configs) do
	for k, v in pairs(common_config) do config[k] = v end
	lsp[server].setup(config)
end

local lsp_installer = require 'nvim-lsp-installer'
lsp_installer.on_server_ready(function(server)
	local server_opts = {}

	-- if server.name == "elixirls" then
	-- 	server_opts.cmd = { vim.fn.expand'~/.local/share/nvim/lsp_servers/elixir/elixir-ls/language_server.sh' }
	-- end

	server:setup(server_opts)
end)
