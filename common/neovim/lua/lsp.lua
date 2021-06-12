local opts = {noremap=true, silent=true}

vim.api.nvim_set_keymap('n', '[g', '<Plug>(coc-diagnostic-prev)', opts)
vim.api.nvim_set_keymap('n', ']g', '<Plug>(coc-diagnostic-next)', opts)

vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', opts)
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', opts)

local nvim_lsp = require('lspconfig')
local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local kmaps = {
    ['gD']='<Cmd>lua vim.lsp.buf.declaration()<CR>'
  }

  for k,v in pairs(kmaps) do
    vim.api.nvim_buf_set_keymap(bufnr, 'n', k, v, opts)
  end

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

local servers = {'clangd', 'rust_analyzer', 'pyright', 'tsserver'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup{on_attach=on_attach}
end

local sumneko_root_path = vim.fn.getenv('HOME')..'/.local/bin/sumneko_lua'
local sumneko_binary_path = '/bin/linux/lua-language-server'
nvim_lsp.sumneko_lua.setup{
  cmd={sumneko_root_path .. sumneko_binary_path, '-E', sumneko_root_path..'/main.lua'};
  on_attach=on_attach,
  settings={
    Lua={
      runtime={
        version='LuaJIT',
        path=vim.split(package.path, ';'),
      },
      diagnostics={
        globals={'vim'},
      },
      workspace={
        library={
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}

vim.cmd "command! Format execute 'lua vim.lsp.buf.formatting()'"
vim.o.completeopt = 'menuone,noinsert'

-- Compe setup
require'compe'.setup{
  enabled=true,
  autocomplete=true,
  debug=false,
  min_length=1,
  preselect='enable',
  throttle_time=80,
  source_timeout=200,
  incomplete_delay=400,
  max_abbr_width=100,
  max_kind_width=100,
  max_menu_width=100,
  documentation=true,
  source={path=true, nvim_lsp=true},
}

return {
  setup=function()
  end
}
