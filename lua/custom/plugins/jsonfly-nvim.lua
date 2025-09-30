return {
  'https://git.myzel394.app/Myzel394/jsonfly.nvim',
  ft = 'json',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('telescope').load_extension 'jsonfly'
  end,
  keys = {
    { '<leader>sj', ':Telescope jsonfly<CR>', desc = '[J]son(fly)', ft = { 'json' }, mode = 'n' },
  },
}
