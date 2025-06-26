return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
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
            desc = ' Zoxide',
            group = 'DiagnosticHint',
            action = 'Telescope zoxide list',
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
              require('telescope').extensions.projects.projects()
            end,
            key = 'p',
          },
          {
            desc = '󰂺 Neovim Configs',
            group = 'DiagnosticHint',
            action = function()
              require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
            end,
            key = 'n',
          },
        },
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
