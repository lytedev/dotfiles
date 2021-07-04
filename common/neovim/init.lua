vim.g.vimdir = os.getenv('XDG_CONFIG_HOME') .. '/nvim'

-- TODO: learn about the wildmenu `q:`
-- TODO: what is `let &fcs = 'eob: '` for?

require('plugins').setup()
require'options'
require'keymap'
require('fold').setup()
-- require('lsp').setup()
require('statusline').setup()

local plugin_setups = {
	telescope = {
		defaults = {
			mappings = {i = {['c-u'] = false, ['c-d'] = false}},
			generic_sorter = require('telescope.sorters').get_fzy_sorter,
			file_sorter = require('telescope.sorters').get_fzy_sorter,
		}
	},
}

for k,v in pairs(plugin_setups) do
	if type(v) == 'function' then
		v(require(k))
	elseif type(v) == 'table' then
		require(k).setup(v)
	elseif type(v) == 'string' then
		require(k)[v]()
	elseif v == true then
		require(k)
	end
end
