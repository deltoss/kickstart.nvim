local keymap = vim.keymap.set

vim.g.firenvim_config = {
  globalSettings = { alt = 'all' },
  localSettings = {
    ['.*'] = {
      cmdline = 'neovim',
      content = 'text',
      priority = 0,
      selector = 'textarea',
      takeover = 'never',
    },
  },
}

if vim.g.started_by_firenvim then
  keymap('n', 'q', ':wq<CR>', { noremap = true, silent = true })
  keymap('n', '<CR>', ':wq<CR>', { noremap = true, silent = true })
  keymap('n', '<ESC>', ':wq<CR>', { noremap = true, silent = true })
  vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = 'github.com_*.txt',
    command = 'set filetype=markdown',
  })
end

return {
  'glacambre/firenvim',
  build = ':call firenvim#install(0)',
}
