vim.keymap.set('n', '<leader>z', ':Telescope zoxide list<CR>', { desc = '[Z]oxide Jump' })
vim.keymap.set('n', '<leader>sz', ':Telescope zoxide list<CR>', { desc = '[S]earch [Z]oxide Jump' })

return {
  'jvgrootveld/telescope-zoxide',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('telescope').load_extension 'zoxide'
  end,
}
