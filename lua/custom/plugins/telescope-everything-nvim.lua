return {
  'deltoss/telescope-everything.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('telescope').load_extension 'everything'
  end,
  keys = {
    { '<leader>se', ':Telescope everything<CR>', desc = '[E]verything' },
  },
}
