return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'CodeCompanionChatCreated',
      callback = function(args)
        local chat = require('codecompanion').buf_get_chat(args.data.bufnr)
        if chat then
          chat:add_buf_message {
            role = 'user',
            content = '#{buffer} ',
          }
        end
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'codecompanion',
      callback = function()
        local file_nav = require 'custom.modules.file-nav'
        vim.keymap.set('n', 'gf', file_nav.open_in_prev_win, { buffer = true })
        vim.keymap.set('n', 'gF', file_nav.open_in_prev_win, { buffer = true })
      end,
    })

    local homeDir = os.getenv 'HOME'
    homeDir = homeDir or os.getenv 'USERPROFIlE'
    local keys = require('custom.utils').read_json_file(homeDir .. '/.config/codecompanion.nvim/api_keys.json')

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd [[cab cc CodeCompanion]]

    require('codecompanion').setup {
      interactions = {
        chat = {
          adapter = {
            name = 'opencode',
          },
          keymaps = {
            fold_code = {
              modes = { n = 'zS' }, -- Default is gf, which conflicts with following a link
            },
            debug = {
              modes = { n = 'gA' }, -- Default is gd, which is going into definitions
              description = 'Show debug messages for the chat',
            },
          },
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
      '<leader>ac',
      '<cmd>CodeCompanionChat Toggle<cr>',
      desc = '[C]hat',
      mode = { 'n', 'v' },
    },
    {
      '<leader>aa',
      '<cmd>CodeCompanionChat Add<cr>',
      desc = '[A]dd',
      mode = { 'v' },
    },
    {
      '<leader>am',
      function()
        require('codecompanion').prompt 'commit'
      end,
      desc = 'Commit [M]essage',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ae',
      function()
        require('codecompanion').prompt 'explain'
      end,
      desc = '[E]xplain',
      mode = { 'n', 'v' },
    },
    {
      '<leader>af',
      function()
        require('codecompanion').prompt 'fix'
      end,
      desc = '[F]ix',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ad',
      function()
        require('codecompanion').prompt 'lsp'
      end,
      desc = 'Explain LSP [D]iagnostics',
      mode = { 'n', 'v' },
    },
    {
      '<leader>at',
      function()
        require('codecompanion').prompt 'test'
      end,
      desc = 'Generate [T]ests',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ap',
      '<cmd>CodeCompanionActions<cr>',
      desc = '[P]alette',
      mode = { 'n', 'v' },
    },
    {
      '<leader>aC',
      ':CodeCompanionCmd ',
      desc = 'Neovim [C]ommands',
    },
    {
      '<leader>aP',
      ':CodeCompanion /',
      desc = '[P]rompts',
    },
  },
}
