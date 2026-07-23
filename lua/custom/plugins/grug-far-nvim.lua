return {
  'MagicDuck/grug-far.nvim',
  -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
  -- additional lazy config to defer loading is not really needed...
  config = function()
    require('grug-far').setup();
  end,
  keys = {
    {
      '<leader>sG',
      function()
        require('grug-far').open({
          engine = 'astgrep',
          instanceName = 'far',
          staticTitle = 'Find and Replace',
          visualSelectionUsage = 'auto-detect',
          transient = true
        })
      end,
      desc = 'ast-[G]rep',
    },
  },
}
