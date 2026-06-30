return {
  dir = vim.fn.stdpath 'config' .. '/lua/custom/modules/everywhere-nvim',
  dependencies = { 'folke/snacks.nvim' },
  cmd = { 'Everywhere', 'EverywhereGitRepos' },
  config = function()
    require('everywhere').setup {
      match_path = true,
    }
  end,
  keys = {
    { '<leader>se', '<cmd>Everywhere<cr>', desc = '[E]verything' },
    { '<leader>sR', '<cmd>EverywhereGitRepos<cr>', desc = 'Git [R]epositories' },
    { '<leader>gr', '<cmd>EverywhereGitRepos<cr>', desc = 'Git [R]epositories' },
  },
}
