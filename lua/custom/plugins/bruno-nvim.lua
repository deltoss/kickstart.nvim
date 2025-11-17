return {
  'deltoss/bruno.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  lazy = false,
  config = function()
    local home = os.getenv 'HOME' or os.getenv 'USERPROFILE'
    require('bruno').setup {
      -- Paths to your bruno collections.
      collection_paths = {
        { name = 'Main', path = home .. '/.bruno/Collections/' },
      },
      picker = 'telescope',
      show_formatted_output = true,
      -- If formatting fails for whatever reason, don't show error message (will always fallback to unformatted output).
      suppress_formatting_errors = false,
    }
  end,
  keys = {
    {
      '<leader>hh',
      ':BrunoSearch<CR>',
      desc = 'Search Bruno Files',
    },
    {
      '<leader>hs',
      ':BrunoSearch<CR>',
      desc = '[S]earch Bruno Files',
    },
    {
      '<leader>sB',
      ':BrunoSearch<CR>',
      desc = 'Search [B]runo Files',
    },
    {
      '<leader>hr',
      ':BrunoRun<CR>',
      desc = '[R]un Current Bruno File',
    },
    {
      '<leader>hf',
      ':BrunoToggleFormat<CR>',
      desc = 'Toggle Bruno [F]ormat',
    },
    {
      '<leader>he',
      ':BrunoEnv<CR>',
      desc = 'Switch Bruno [E]nvironment',
    },
  },
}
