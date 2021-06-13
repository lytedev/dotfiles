local vimdir = os.getenv('XDG_CONFIG_HOME') .. '/nvim'

for _,keys in ipairs{'jj', 'jJ', 'Jj', 'JJ', 'jk', 'jK', 'Jk', 'JK'} do kmap('i', keys, '<Esc>', {}) end

local m = {
	s = {silent = true},
	n = {noremap = true},
	sn = {silent = true, noremap = true},
}
local keymap = {
	n = {
		['<leader>r'] = {':luafile ' .. vimdir .. '/init.lua<cr>:echo \'Reloaded init.lua\'<cr>', m.s},
		['<leader>gv'] = {':e ' .. vimdir .. '/init.lua<cr>', m.s},
		['<leader>w'] = {':bd<cr>', m.s},
		['<leader>h'] = {'b#<cr>', m.s},
		['<leader>k'] = {':bnext<cr>', m.s},
		['<leader>j'] = {':bprevious<cr>', m.s},
		['<leader>/'] = {':let @/ = ""<cr>:<BACKSPACE>', m.s},
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
	},
	t = {},
	[''] = {
		['<space>'] = {'<nop>', m.sn},
		['<f3>'] = 'mw:%s/\\s\\+$//<cr>:let @/ = ""<cr>\'w',
		['<f4>'] = ':setlocal spell!<cr>',
		[',w'] = {'<Plug>CamelCaseMotion_w', m.s},
		[',b'] = {'<Plug>CamelCaseMotion_b', m.s},
		[',e'] = {'<Plug>CamelCaseMotion_e', m.s},
		[',ge'] = {'<Plug>CamelCaseMotion_ge', m.s},
	},
	o = {
		['ib'] = {'<Plug>CamelCaseMotion_ib', m.s},
		['ie'] = {'<Plug>CamelCaseMotion_ie', m.s},
	},
	x = {
		['<'] = '<gv',
		['>'] = '>gv',
		['ib'] = {'<Plug>CamelCaseMotion_ib', m.s},
		['ie'] = {'<Plug>CamelCaseMotion_ie', m.s},
	},
	c = {
		['<c-n>'] = '<down>',
		['<c-p>'] = '<up>',
	},
	i = {
		['<c-q>'] = '<esc><c-q>',
		['<c-n>'] = {'<Plug>(completion_trigger)', m.s},
	},
}
for mode,mappings in pairs(keymap) do
	for key,bind in pairs(mappings) do
		if type(bind) == 'table' then
			vim.api.nvim_set_keymap(mode, key, bind[1], bind[2])
		else
			vim.api.nvim_set_keymap(mode, key, bind, {})
		end
	end
end
