return {
  'karb94/neoscroll.nvim',
  config = function()
    local neoscroll = require 'neoscroll'
    neoscroll.setup {
      -- Default easing function used in any animation where
      -- the `easing` argument has not been explicitly supplied
      easing = 'quadratic',

      -- neoscroll suppresses CursorMoved/WinScrolled (via eventignore) for the
      -- whole animation, so nvim-origami's fold-highlight tracking (which only
      -- listens for CursorMoved) never sees the cursor land on its final row.
      -- Resync it directly here once the scroll finishes.
      post_hook = function()
        local winid = vim.api.nvim_get_current_win()
        local bufnr = vim.api.nvim_win_get_buf(winid)
        local row = vim.api.nvim_win_get_cursor(winid)[1]
        require('custom.utils.code_folds').update_current_fold(row, bufnr, winid)
      end,
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
      ['n'] = function()
        vim.cmd 'normal! n'
        neoscroll.zz { half_win_duration = 350, easing = 'sine' }
      end,
      ['N'] = function()
        vim.cmd 'normal! N'
        neoscroll.zz { half_win_duration = 350, easing = 'sine' }
      end,
    }
    local modes = { 'n', 'v', 'x' }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
