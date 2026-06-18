local bufnr = vim.api.nvim_get_current_buf()
local wk = require 'which-key'
vim.keymap.set('n', '<leader>ra', function()
  vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
  -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr, desc = 'Code [A]ction' })
vim.keymap.set(
  'n',
  'K', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp { 'hover', 'actions' }
  end,
  { silent = true, buffer = bufnr }
)

wk.add {
  { '<leader>r', group = '[R]ustcean', icon = {
    icon = '',
    color = 'orange',
  }, mode = { 'n' }, buffer = bufnr },
}
vim.keymap.set('n', '<leader>rd', function()
  vim.cmd.RustLsp 'debuggables'
end, { silent = true, buffer = bufnr, desc = '[d]ebuggables' })
vim.keymap.set('n', '<leader>rD', function()
  vim.cmd.RustLsp 'debug'
end, { silent = true, buffer = bufnr, desc = '[D]ebug Cursor Target' })
vim.keymap.set('n', '<leader>rr', function()
  vim.cmd.RustLsp 'runnables'
end, { silent = true, buffer = bufnr, desc = '[r]unnables' })
vim.keymap.set('n', '<leader>rR', function()
  vim.cmd.RustLsp 'run'
end, { silent = true, buffer = bufnr, desc = '[R]un Cursor Target' })
vim.keymap.set('n', '<leader>rt', function()
  vim.cmd.RustLsp 'testables'
end, { silent = true, buffer = bufnr, desc = '[t]estables' })
vim.keymap.set('n', '<leader>rT', function()
  vim.cmd.RustLsp { 'testables', bang = true }
end, { silent = true, buffer = bufnr, desc = '[T]est Previous Target' })
