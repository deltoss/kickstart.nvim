return {
  'snacks.nvim', -- only the name of the plugin needs to be specified since it already exists
  ---@type snacks.Config
  opts = {
    notifier = {
      enabled = true,
      timeout = 8000,
      ---@type snacks.notifier.style
      style = 'fancy',
      top_down = false, -- place notifications from bottom to top
    },
  },
  keys = {
    {
      '<leader>zm',
      function()
        Snacks.notifier.hide()
      end,
      desc = '[M]essages',
    },
  },
}
