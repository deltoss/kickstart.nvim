return {
  'm4xshen/hardtime.nvim',
  lazy = false,
  dependencies = { 'MunifTanjim/nui.nvim' },
  opts = {
    disabled_keys = {
      ['<Up>'] = false,
      ['<Right>'] = false,
      ['<Down>'] = false,
      ['<Left>'] = false,
    },
    restricted_keys = {
      ['<Up>'] = { 'n', 'x' },
      ['<Right>'] = { 'n', 'x' },
      ['<Down>'] = { 'n', 'x' },
      ['<Left>'] = { 'n', 'x' },
      ['gj'] = { 'n', 'x' },
      ['gk'] = { 'n', 'x' },
      ['<C-M>'] = { 'n', 'x' },
      ['<C-N>'] = { 'n', 'x' },
      ['<C-P>'] = { 'n', 'x' },
    },
  },
}
