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
    { '<leader>z', ':Telescope zoxide list<CR>', desc = '[Z]oxide Jump' },
    { '<leader>sz', ':Telescope zoxide list<CR>', desc = '[S]earch [Z]oxide Jump' },
  },
}
