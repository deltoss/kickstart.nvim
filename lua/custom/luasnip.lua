return {
  config = function()
    local keymap = vim.keymap.set
    local ls = require 'luasnip'
    local types = require 'luasnip.util.types'

    keymap('i', '<C-c>', function()
      require 'luasnip.extras.select_choice'()
    end)

    ls.config.set_config {
      history = true,
      ext_opts = {
        [types.choiceNode] = {
          passive = {
            virt_text = { { '○', 'Comment' } },
            hl_mode = 'combine',
          },
          active = {
            virt_text = { { '●', 'DiagnosticHint' } },
            hl_mode = 'combine',
          },
        },
        [types.insertNode] = {
          passive = {
            virt_text = { { '○', 'Comment' } },
            hl_mode = 'combine',
          },
          active = {
            virt_text = { { '●', 'DiagnosticHint' } },
            hl_mode = 'combine',
          },
        },
      },
    }
  end,
}
