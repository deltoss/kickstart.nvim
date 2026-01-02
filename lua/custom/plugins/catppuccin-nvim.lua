return {
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'catppuccin/nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('catppuccin').setup {
      term_colors = true,
      flavour = 'latte',
    }

    vim.cmd.colorscheme 'catppuccin'
  end,
}
