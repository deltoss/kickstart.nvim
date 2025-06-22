return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- Start Oil when opening a directory
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['<C-s>'] = false,
      ['<C-h>'] = false,
      ['<leader><Right>'] = { 'actions.select', opts = { vertical = true } },
      ['<leader><Left>'] = { 'actions.select', opts = { vertical = true, split = 'aboveleft' } },
      ['<leader><Up>'] = { 'actions.select', opts = { horizontal = true, split = 'aboveleft' } },
      ['<leader><Down>'] = { 'actions.select', opts = { horizontal = true } },
      ['<leader>t'] = { 'actions.select', opts = { tab = true } },
      ['<leader>p'] = 'actions.preview',
      ['<leader>c'] = { 'actions.close', mode = 'n' },
      ['_'] = { 'actions.close', mode = 'n' },
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Open current directory' },
  },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
