return {
  dir = vim.fn.stdpath 'config' .. '/lua/custom/modules/everything-nvim',
  config = function()
    require('everything').setup()
  end,
  keys = {
    {
      '<leader>sR',
      '<cmd>EverythingGitRepo<cr>',
      desc = 'Git [R]epositories',
    },
    {
      '<leader>gr',
      '<cmd>EverythingGitRepo<cr>',
      desc = 'Git [R]epositories',
    },
  },
}
