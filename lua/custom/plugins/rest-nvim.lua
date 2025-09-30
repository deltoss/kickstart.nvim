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
      desc = '[O]pen Result Pane',
    },
    {
      '<leader>hr',
      ':Rest run',
      desc = '[R]un Request Under Cursor',
    },
    {
      '<leader>hp',
      ':Rest last',
      desc = 'Run [P]revious Request',
    },
    {
      '<leader>hl',
      ':Rest logs',
      desc = 'Edit [L]ogs File',
    },
    {
      '<leader>hc',
      ':Rest cookies',
      desc = 'Edit [C]ookies File',
    },
    {
      '<leader>hev',
      ':Rest env show',
      desc = '[V]iew File',
    },
    {
      '<leader>hes',
      function()
        require('telescope').extensions.rest.select_env()
      end,
      desc = '[S]elect File',
    },
  },
}
