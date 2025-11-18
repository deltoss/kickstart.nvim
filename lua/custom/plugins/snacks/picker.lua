return {
  'snacks.nvim', -- only the name of the plugin needs to be specified since it already exists
  ---@type snacks.Config
  opts = {
    picker = { enabled = true },
  },
  keys = {
    {
      '<leader>en',
      function()
        Snacks.picker.notifications()
      end,
      desc = '[E]rror Notifications',
      mode = { 'n', 'v' },
    },
  },
}
