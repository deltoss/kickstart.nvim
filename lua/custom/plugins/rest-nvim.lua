return {
  'rest-nvim/rest.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, 'http')
    end,
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('telescope').load_extension 'rest'
  end,
  keys = {
    {
      '<leader>ho',
      ':Rest open',
      desc = '[H]TTP [O]pen Result Pane',
    },
    {
      '<leader>hr',
      ':Rest run',
      desc = '[H]TTP [R]un Request Under Cursor',
    },
    {
      '<leader>hp',
      ':Rest last',
      desc = '[H]TTP Run [P]revious Request',
    },
    {
      '<leader>hl',
      ':Rest logs',
      desc = '[H]TTP Edit [L]ogs File',
    },
    {
      '<leader>hc',
      ':Rest cookies',
      desc = '[H]TTP Edit [C]ookies File',
    },
    {
      '<leader>hev',
      ':Rest env show',
      desc = '[H]TTP [E]nv [V]iew File',
    },
    {
      '<leader>hes',
      function()
        require('telescope').extensions.rest.select_env()
      end,
      desc = '[H]TTP [E]nv [S]elect File',
    },
  },
}
