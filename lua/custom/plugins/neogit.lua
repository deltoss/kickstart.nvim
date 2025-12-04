return {
  'NeogitOrg/neogit',
  lazy = true,
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration
    'folke/snacks.nvim',
  },
  cmd = 'Neogit',
  keys = {
    { '<leader>gn', '<cmd>Neogit<cr>', desc = '[N]eogit' },
  },
}
