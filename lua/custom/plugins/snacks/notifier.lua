return {
  'snacks.nvim', -- only the name of the plugin needs to be specified since it already exists
  ---@type snacks.Config
  opts = {
    notifier = { enabled = true },
  },
  keys = {
    {
      '<leader>un',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss All Notifications',
    },
  },
}
