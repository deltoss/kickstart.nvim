return {
  'cuducos/yaml.nvim',
  ft = { 'yaml' },
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    { '<leader>sy', ':YAMLTelescope<CR>', desc = '[Y]aml', ft = { 'yaml' }, mode = 'n' },
  },
  config = function()
    vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorMoved' }, {
      pattern = { '*.yaml' },
      callback = function()
        vim.opt_local.winbar = require('yaml_nvim').get_yaml_key_and_value()
      end,
    })
  end,
}
