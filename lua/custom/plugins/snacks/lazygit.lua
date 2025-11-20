return {
  'snacks.nvim', -- only the name of the plugin needs to be specified since it already exists
  ---@type snacks.Config
  opts = {
    lazygit = { enabled = true, configure = false },
  },
  keys = {
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>gL',
      function()
        Snacks.lazygit.log()
      end,
      desc = 'Lazygit [L]og',
    },
    {
      '<leader>gF',
      function()
        Snacks.lazygit.log_file()
      end,
      desc = 'Lazygit [L]og Current [F]ile',
    },
  },
}
