return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'folke/snacks.nvim',
  },
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        project = { enable = false },
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            desc = '󰂺 New File',
            group = 'DiagnosticHint',
            action = 'enew',
            key = 'n',
          },
          {
            desc = ' Zoxide',
            group = 'DiagnosticHint',
            action = function()
              Snacks.picker.zoxide()
            end,
            key = 'z',
          },
          {
            desc = ' Everything Search',
            group = 'DiagnosticHint',
            action = 'Telescope everything',
            key = 'e',
          },
          {
            desc = '󰂺 Projects',
            group = 'DiagnosticHint',
            action = function()
              Snacks.picker.projects()
            end,
            key = 'p',
          },
          {
            desc = '󰂺 Neovim Configs',
            group = 'DiagnosticHint',
            action = function()
              Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
            end,
            key = 'c',
          },
        },
      },
    }
  end,
}
