local keymap = vim.keymap.set

return {
  'glacambre/firenvim',
  build = ':call firenvim#install(0)',
  init = function()
    if vim.g.started_by_firenvim then
      keymap('n', '<C-s>', ':wq<CR>', { noremap = true, silent = true })
      keymap('i', '<C-s>', '<Esc>:wq<CR>', { noremap = true, silent = true })

      keymap('n', 'q', ':wq<CR>', { noremap = true, silent = true })
      vim.api.nvim_create_autocmd({ 'BufEnter' }, {
        pattern = 'github.com_*.txt',
        command = 'set filetype=markdown',
      })
    end
  end,
}
