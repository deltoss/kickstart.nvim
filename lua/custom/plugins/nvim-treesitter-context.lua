return {
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesitter-context').setup {}
  end,
  keys = {
    {
      '[p',
      function()
        require('treesitter-context').go_to_context(vim.v.count1)
      end,
      desc = 'Go to [P]arent',
    },
  },
}
