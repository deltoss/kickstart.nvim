return {
  'snacks.nvim', -- only the name of the plugin needs to be specified since it already exists
  ---@type snacks.Config
  opts = {
    scratch = {
      enabled = true,
    },
  },
  keys = {
    {
      '<leader>nn',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Buffer',
    },
    {
      '<leader>ns',
      function()
        Snacks.scratch.select()
      end,
      desc = '[S]elect Buffer',
    },
  },
}
