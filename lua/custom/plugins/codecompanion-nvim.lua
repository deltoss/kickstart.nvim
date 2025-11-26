return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local homeDir = os.getenv 'HOME'
    homeDir = homeDir or os.getenv 'USERPROFIlE'
    local keys = require('custom.utils').read_json_file(homeDir .. '/.config/codecompanion.nvim/api_keys.json')

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd [[cab cc CodeCompanion]]

    require('codecompanion').setup {
      strategies = {
        chat = {
          adapter = 'anthropic',
        },
        inline = {
          adapter = 'anthropic',
        },
        cmd = {
          adapter = 'anthropic',
        },
      },
      adapters = {
        http = {
          anthropic = function()
            local key = keys and keys.anthropic or nil
            return require('codecompanion.adapters').extend('anthropic', {
              env = {
                api_key = key,
              },
            })
          end,
        },
      },
    }
  end,
  keys = {
    {
      '<leader>acc',
      '<cmd>CodeCompanionChat Toggle<cr>',
      desc = '[C]hat',
      mode = { 'n', 'v' },
    },
    {
      '<leader>aca',
      '<cmd>CodeCompanionChat Add<cr>',
      desc = '[A]dd',
      mode = { 'v' },
    },
    {
      '<leader>ace',
      function()
        require('codecompanion').prompt 'explain'
      end,
      desc = '[E]xplain',
      mode = { 'n', 'v' },
    },
    {
      '<leader>acf',
      function()
        require('codecompanion').prompt 'fix'
      end,
      desc = '[F]ix',
      mode = { 'n', 'v' },
    },
    {
      '<leader>acd',
      function()
        require('codecompanion').prompt 'lsp'
      end,
      desc = 'Explain LSP [D]iagnostics',
      mode = { 'n', 'v' },
    },
    {
      '<leader>act',
      function()
        require('codecompanion').prompt 'test'
      end,
      desc = 'Generate [T]ests',
      mode = { 'n', 'v' },
    },
    {
      '<leader>acp',
      '<cmd>CodeCompanionActions<cr>',
      desc = '[P]alette',
      mode = { 'n', 'v' },
    },
    {
      '<leader>acC',
      '<cmd>CodeCompanionCmd ',
      desc = 'Neovim [C]ommands',
    },
    {
      '<leader>acP',
      ':CodeCompanion /',
      desc = '[P]rompts',
    },
  },
}
