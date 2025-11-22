return {
  'jvgrootveld/telescope-zoxide',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    local telescope = require 'telescope'

    telescope.setup {
      extensions = {
        zoxide = {
          mappings = {
            default = {
              after_action = function(selection)
                -- Launch default explorer
                vim.cmd('edit ' .. selection.path)
              end,
            },
          },
        },
      },
    }

    telescope.load_extension 'zoxide'
  end,
  keys = {
    {
      '<leader>sz',
      function()
        local opts = {}

        if vim.o.shell == 'pwsh' or vim.o.shell == 'powershell' then
          local zoxideListCmd = require('telescope._extensions.zoxide.config').get_config().list_command
          opts.cmd = { vim.o.shell, '-NoLogo', '-NoProfile', '-Command', zoxideListCmd }
        end

        require('telescope').extensions.zoxide.list(opts)
      end,
      desc = '[Z]oxide',
    },
  },
}
