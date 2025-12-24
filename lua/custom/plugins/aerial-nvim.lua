return {
  'stevearc/aerial.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
    'folke/snacks.nvim',
  },
  opts = {},
  keys = {
    {
      '<leader>so',
      function()
        require('aerial').snacks_picker()
      end,
      desc = '[O]utline (Aerial)',
    },
    {
      '{',
      '<cmd>AerialPrev<CR><cmd>AerialOpen!<CR>',
      desc = 'Previous Symbol (Aerial)',
    },
    {
      '}',
      '<cmd>AerialNext<CR><cmd>AerialOpen!<CR>',
      desc = 'Next Symbol (Aerial)',
    },
    {
      '<leader>oa',
      '<cmd>AerialToggle!<CR>',
      desc = '[A]erial',
    },
  },
}
