return {
  'snacks.nvim', -- only the name of the plugin needs to be specified since it already exists
  ---@type snacks.Config
  opts = {
    lazygit = { enabled = true, configure = false },
  },
  keys = {
    {
      '<leader>Gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Open Lazygit',
    },
    {
      '<leader>Gl',
      function()
        Snacks.lazygit.log()
      end,
      desc = 'Repository [L]og',
    },
    {
      '<leader>Gf',
      function()
        Snacks.lazygit.log_file()
      end,
      desc = 'Current [F]ile Log',
    },
  },
}
