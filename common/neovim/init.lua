local kmap = vim.api.nvim_set_keymap
local excmd = vim.api.nvim_command
local nvim_exec = vim.api.nvim_exec

-- TODO: learn about the wildmenu `q:`
-- TODO: what is `let &fcs = 'eob: '` for?

local evalvim = function(vimscript, output)
	if (output == nil) then
		output = false
	end
	nvim_exec(vimscript, output)
end

require('plugins').setup()
require'options'
require'keymap'

do
	local plugin_setups = {
		telescope = {
			defaults = {
				mappings = {i = {['c-u'] = false, ['c-d'] = false}},
				generic_sorter = require('telescope.sorters').get_fzy_sorter,
				file_sorter = require('telescope.sorters').get_fzy_sorter,
			}
		},
		fold = true,
		statusline = true,
		lsp = true,
	}
	for k,v in pairs(plugin_setups) do
		if type(v) == 'function' then
			v(require(k))
		elseif type(v) == 'table' then
			require(k).setup(v)
		elseif v == true then
			require(k).setup()
		end
	end
end
