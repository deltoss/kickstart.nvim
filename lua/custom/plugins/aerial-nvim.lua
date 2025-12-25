return {
  'stevearc/aerial.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
    'folke/snacks.nvim',
  },
  opts = {
    filter_kind = false,
    close_on_select = true,
    layout = {
      -- Determines the default direction to open the aerial window. The 'prefer'
      -- options will open the window in the other direction *if* there is a
      -- different buffer in the way of the preferred direction
      -- Enum: prefer_right, prefer_left, right, left, float
      default_direction = 'float',
    },
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
