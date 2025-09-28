return {
  'karb94/neoscroll.nvim',
  config = function()
    neoscroll = require 'neoscroll'
    neoscroll.setup {
      -- Default easing function used in any animation where
      -- the `easing` argument has not been explicitly supplied
      easing = 'quadratic',
    }
    local keymap = {
      -- Use the "sine" easing function
      ['<C-u>'] = function()
        neoscroll.ctrl_u { duration = 250, easing = 'sine' }
      end,
      ['<C-d>'] = function()
        neoscroll.ctrl_d { duration = 250, easing = 'sine' }
      end,
      -- Map Ctrl+e to Ctrl+d
      ['<C-e>'] = function()
        neoscroll.ctrl_d { duration = 250, easing = 'sine' }
      end,
      -- Use the "circular" easing function
      ['<C-b>'] = function()
        neoscroll.ctrl_b { duration = 450, easing = 'circular' }
      end,
      ['<C-f>'] = function()
        neoscroll.ctrl_f { duration = 450, easing = 'circular' }
      end,
    }
    local modes = { 'n', 'v', 'x' }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
