return {
  dir = vim.fn.stdpath 'config' .. '/lua/custom/modules/everywhere-nvim',
  dependencies = { 'folke/snacks.nvim' },
  config = function()
    require('everywhere').setup()
  end,
  keys = {
    { '<leader>se', '<cmd>Everywhere<cr>', desc = '[E]verything' },
  },
}
