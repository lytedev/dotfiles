local homedir = os.getenv('HOME')
require 'nvim_lsp'.elixirls.setup{
	cmd = { homedir..'/../code/open-source/elixir-ls/release/language_server.sh' };
}
