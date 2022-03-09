for _,keys in ipairs{'jj', 'jJ', 'Jj', 'JJ', 'jk', 'jK', 'Jk', 'JK'} do vim.api.nvim_set_keymap('i', keys, '<Esc>', {}) end

local m = {
	s = {silent = true},
	n = {noremap = true},
	sn = {silent = true, noremap = true},
}
local keymap = {
	n = {
		['<leader>/'] = {':let @/ = ""<cr>:<BACKSPACE>', m.s},

		['<leader>r'] = {':luafile ' .. vim.g.vimdir .. '/init.lua<cr>:echo \'Reloaded init.lua\'<cr>', m.s},
		['<leader>gv'] = {':e ' .. vim.g.vimdir .. '/init.lua<cr>', m.s},

		['<leader>w'] = {':bd<cr>', m.s},
		['<leader>h'] = {':b#<cr>', m.s},
		['<leader>k'] = {':bnext<cr>', m.s},
		['<leader>j'] = {':bprevious<cr>', m.s},

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
		['<space>'] = {'<nop>', m.sn},

		-- remove trailing whitespace
		['<f3>'] = 'mw:%s/\\s\\+$//<cr>:let @/ = ""<cr>\'w',
		['<leader>gs'] = ':setlocal spell!<cr>',
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
