local keymap = vim.keymap.set

if vim.g.started_by_firenvim then
  keymap('n', 'q', ':wq<CR>', { noremap = true, silent = true })
  keymap('n', '<CR>', ':wq<CR>', { noremap = true, silent = true })
  vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = 'github.com_*.txt',
    command = 'set filetype=markdown',
  })
end

return {
  'glacambre/firenvim',
  build = ':call firenvim#install(0)',
}
