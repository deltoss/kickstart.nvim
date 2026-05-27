return {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  config = function()
    require('lspsaga').setup {
      lightbulb = {
        enable = false,
      },
      outline = {
        keys = {
          jump = '<cr>',
          quit = '<esc>',
          toggle_or_jump = '<C-cr>',
        },
        close_after_jump = true,
      },
    }
  end,
  dependencies = {
    'romus204/tree-sitter-manager.nvim',
    'nvim-tree/nvim-web-devicons',
  },
}
