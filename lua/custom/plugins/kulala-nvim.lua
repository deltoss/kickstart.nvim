local filetypes = { 'http', 'rest' }

return {
  'mistweaverco/kulala.nvim',
  ft = filetypes,
  keys = {
    {
      '<localleader>s',
      function()
        require('kulala').run()
      end,
      mode = { 'n', 'v' },
      ft = filetypes,
      desc = 'Send request',
    },
    {
      '<localleader>a',
      function()
        require('kulala').run_all()
      end,
      mode = { 'n', 'v' },
      ft = filetypes,
      desc = 'Send all requests',
    },
    {
      '<localleader>S',
      function()
        require('kulala').scratchpad()
      end,
      ft = filetypes,
      desc = 'Open scratchpad',
    },
  },
  opts = {
    global_keymaps = false,
    kulala_keymaps_prefix = '',
  },
}
