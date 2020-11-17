local lsp = require('lspconfig')
local homedir = os.getenv('HOME')
local ossdir = homedir..'/../code/open-source'

lsp.elixirls.setup{
	-- TODO: git clone and compile if needed
	-- preferably in a background thread with messages
	cmd = { ossdir..'/elixir-ls/release/language_server.sh' }
}
