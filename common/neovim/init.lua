vim.g.vimdir = os.getenv('XDG_CONFIG_HOME') .. '/nvim'

require'plugins'
require'options'
require'keymap'
require'statusline'
require'lsp'
