return {
  'Weissle/persistent-breakpoints.nvim',
  dependencies = { 'mfussenegger/nvim-dap' },
  config = function()
    require('persistent-breakpoints').setup {
      load_breakpoints_event = { 'BufReadPost' },
    }
  end,
}
