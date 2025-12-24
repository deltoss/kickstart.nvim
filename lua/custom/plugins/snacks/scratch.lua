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
      '<leader>Ss',
      function()
        Snacks.scratch()
      end,
      desc = '[S]cratch Buffer',
    },
    {
      '<leader>SS',
      function()
        Snacks.scratch.select()
      end,
      desc = '[S]cratch Select Buffer',
    },
  },
}
