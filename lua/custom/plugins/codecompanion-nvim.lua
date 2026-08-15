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
            content = '\n#{buffer} ',
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
            name = 'pi',
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
          openai = function()
            local key = keys and keys.openai or nil
            return require('codecompanion.adapters').extend('openai', {
              env = {
                api_key = key,
              },
            })
          end,
        },
        acp = {
          -- See https://github.com/olimorris/codecompanion.nvim/discussions/3215
          pi = function()
            local helpers = require 'codecompanion.adapters.acp.helpers'
            return {
              name = 'pi',
              formatted_name = 'pi coding agent',
              type = 'acp',
              roles = {
                llm = 'assistant',
                user = 'user',
              },
              commands = {
                default = {
                  'npx',
                  '-y',
                  'pi-acp',
                },
              },
              defaults = {
                mcpServers = {},
                timeout = 20000,
              },
              parameters = {
                protocolVersion = 1,
                clientCapabilities = {
                  fs = { readTextFile = true, writeTextFile = true },
                },
                clientInfo = {
                  name = 'CodeCompanion.nvim',
                  version = '1.0.0',
                },
              },
              handlers = {
                setup = function(self)
                  return true
                end,
                auth = function(self)
                  return true
                end,
                form_messages = function(self, messages, capabilities)
                  return helpers.form_messages(self, messages, capabilities)
                end,
                on_exit = function(self, code) end,
              },
            }
          end,
          claude_code = function()
            local key = keys and keys.anthropic or nil
            return require('codecompanion.adapters').extend('claude_code', {
              env = {
                ANTHROPIC_API_KEY = key,
              },
            })
          end,
          codex = function()
            local key = keys and keys.openai or nil
            return require('codecompanion.adapters').extend('codex', {
              defaults = {
                auth_method = 'openai-api-key', -- "openai-api-key"|"codex-api-key"|"chatgpt"
              },
              env = {
                OPENAI_API_KEY = key,
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
