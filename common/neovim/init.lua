vim.g.vimdir = os.getenv('XDG_CONFIG_HOME') .. '/nvim'

-- TODO: learn about the wildmenu `q:`
-- TODO: what is `let &fcs = 'eob: '` for?

require('plugins').setup()
require'options'
require'keymap'
require('fold').setup()
-- require('lsp').setup()
require('statusline').setup()

function Dbg(a, d)
	if d == nil then d = 0 end
	if type(a) == 'table' then
		local s = '{\n'
		local indent = string.rep('  ', d)
		for k,v in pairs(a) do
			s = s .. '  ' .. indent .. tostring(k) .. '=' .. Dbg(v, d+1) .. '\n'
		end
		return s .. '\n' .. indent .. '}'
	elseif type(a) == 'string' then
		return a
	elseif type(a) == 'number' then
		return tostring(a)
	else
		return 'type:'..type(a)..',tostring:'..tostring(a)
	end
end

local plugin_setups = {
	telescope = {
		defaults = {
			prompt_prefix = "",
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
