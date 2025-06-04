return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      mode = 'tabs', -- set to "tabs" to only show tabpages instead
      numbers = 'ordinal',
      diagnostics = 'nvim_lsp',
    },
  },
  keys = {
    {
      'gb',
      ':BufferLinePick<CR>',
      desc = 'Pick buffer',
    },
    {
      '<leader>1',
      '<Cmd>BufferLineGoToBuffer 1<CR>',
      desc = 'Pick buffer 1',
    },
    {
      '<leader>2',
      '<Cmd>BufferLineGoToBuffer 2<CR>',
      desc = 'Pick buffer 2',
    },
    {
      '<leader>3',
      '<Cmd>BufferLineGoToBuffer 3<CR>',
      desc = 'Pick buffer 3',
    },
    {
      '<leader>4',
      '<Cmd>BufferLineGoToBuffer 4<CR>',
      desc = 'Pick buffer 4',
    },
    {
      '<leader>5',
      '<Cmd>BufferLineGoToBuffer 5<CR>',
      desc = 'Pick buffer 5',
    },
    {
      '<leader>6',
      '<Cmd>BufferLineGoToBuffer 6<CR>',
      desc = 'Pick buffer 6',
    },
    {
      '<leader>7',
      '<Cmd>BufferLineGoToBuffer 7<CR>',
      desc = 'Pick buffer 7',
    },
    {
      '<leader>8',
      '<Cmd>BufferLineGoToBuffer 8<CR>',
      desc = 'Pick buffer 8',
    },
    {
      '<leader>9',
      '<Cmd>BufferLineGoToBuffer 9<CR>',
      desc = 'Pick buffer 9',
    },
    {
      '<leader>$',
      '<Cmd>BufferLineGoToBuffer -1<CR>',
      desc = 'Pick last buffer',
    },
  },
}
