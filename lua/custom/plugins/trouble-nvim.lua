return {
  'folke/trouble.nvim',
  opts = {},
  cmd = 'Trouble',
  keys = {
    {
      '<leader>ee',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = '[D]iagnostics (Trouble)',
    },
    {
      '<leader>eE',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = '[B]uffer Diagnostics (Trouble)',
    },
    {
      '<leader>es',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = '[S]ymbols (Trouble)',
    },
    {
      '<leader>el',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = '[L]SP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>eL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = '[L]ocation List (Trouble)',
    },
    {
      '<leader>eQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = '[Q]uickfix List (Trouble)',
    },
  },
}
