let g:elixirls = {
	\ 'path': printf('%s/%s', stdpath('config'), 'bundle/elixir-ls'),
	\ }

let g:elixirls.lsp = printf(
		\ '%s/%s',
	\ g:elixirls.path,
	\ 'release/language_server.sh')

function! g:elixirls.compile(...)
	let l:commands = join([
		\ 'mix local.hex --force',
		\ 'mix local.rebar --force',
		\ 'mix deps.get',
		\ 'mix compile',
		\ 'mix elixir_ls.release'
		\ ], '&&')

	echom '>>> Compiling elixirls'
	silent call system(l:commands)
	echom '>>> elixirls compiled'
endfunction

call coc#config('languageserver', {
	\ 'elixir': {
	\	 'command': g:elixirls.lsp,
	\	 'trace.server': 'verbose',
	\	 'filetypes': ['elixir', 'eelixir']
	\ }
	\})

