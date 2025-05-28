return {
  'jvgrootveld/telescope-zoxide',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('telescope').load_extension 'zoxide'
  end,
  keys = {
    { '<leader>z', ':Telescope zoxide list<CR>', desc = '[Z]oxide Jump' },
    { '<leader>sz', ':Telescope zoxide list<CR>', desc = '[S]earch [Z]oxide Jump' },
  },
}
