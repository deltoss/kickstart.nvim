return {
  'Weissle/persistent-breakpoints.nvim',
  dependencies = { 'mfussenegger/nvim-dap' },
  config = function()
    require('persistent-breakpoints').setup {
      load_breakpoints_event = { 'BufReadPost' },
    }
    vim.keymap.set('n', '<leader>ba', function()
      require('persistent-breakpoints.api').toggle_breakpoint()
    end, { desc = '[A]dd/Toggle Breakpoint' })

    vim.keymap.set('n', '<leader>bA', function()
      require('persistent-breakpoints.api').set_conditional_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = '[A]dd Conditional Breakpoint' })
  end,
}
