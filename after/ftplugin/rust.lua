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
  vim.cmd.RustLsp { 'run', bang = true }
end, { silent = true, buffer = bufnr, desc = '[R]un Last Target' })
vim.keymap.set('n', '<leader>rR', function()
  vim.cmd.RustLsp 'runnables'
end, { silent = true, buffer = bufnr, desc = '[R]unnables' })
vim.keymap.set('n', '<leader>rt', function()
  vim.cmd.RustLsp { 'testables', bang = true }
end, { silent = true, buffer = bufnr, desc = '[t]est Previous Target' })
vim.keymap.set('n', '<leader>rT', function()
  vim.cmd.RustLsp 'testables'
end, { silent = true, buffer = bufnr, desc = '[T]estables' })
vim.keymap.set('n', '<leader>rx', function()
  vim.cmd.RustLsp 'renderDiagnostic'
end, { silent = true, buffer = bufnr, desc = '[x] Diagnostics' })
vim.keymap.set('n', '<leader>rX', function()
  vim.cmd.RustLsp 'relatedDiagnostics'
end, { silent = true, buffer = bufnr, desc = '[X] Related Diagnostics' })
vim.keymap.set('n', '<leader>re', function()
  vim.cmd.RustLsp 'explainError'
end, { silent = true, buffer = bufnr, desc = '[E]xplain error' })
vim.keymap.set('n', '<leader>ro', function()
  vim.cmd.RustLsp 'openDocs'
end, { silent = true, buffer = bufnr, desc = '[O]pen Docs' })
