return {
  'stevearc/aerial.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
    'folke/snacks.nvim',
  },
  opts = {
    filter_kind = false,
  },
  keys = {
    {
      '<leader>so',
      function()
        require('aerial').snacks_picker()
      end,
      desc = '[O]utline (Aerial)',
    },
  },
}
