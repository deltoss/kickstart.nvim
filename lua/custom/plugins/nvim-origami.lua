return {
  'chrisgrieser/nvim-origami',
  event = 'VeryLazy',
  opts = {
    foldtext = {
      lineCount = {
        template = ' %d',
      },
    },
    foldKeymaps = {
      setup = false,
    },
  },
  init = function()
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99

    local fold_util = require 'custom.utils.code_folds'

    vim.keymap.set('n', '<CR>', function()
      -- Keep default <CR> in special buffers (quickfix, help, terminal, etc.)
      return vim.bo.buftype == '' and 'za' or '<CR>'
    end, { expr = true, noremap = true, silent = true })
    vim.keymap.set('n', '[[', fold_util.goto_previous_fold, { noremap = true, silent = true })
    vim.keymap.set('n', ']]', 'zj', { noremap = true, silent = true })

    vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave', 'LspAttach' }, {
      callback = function(opts)
        fold_util.update_ranges(opts.buf)
      end,
    })

    -- last_row and current_fold are tracked per-window: each window showing a
    -- buffer has its own cursor position, so a single shared value would leak
    -- state between splits/buffers (stale or "stuck" highlights).
    local last_row = {}
    local function sync_current_fold(winid, bufnr)
      local row = vim.api.nvim_win_get_cursor(winid)[1]
      last_row[winid] = row
      fold_util.update_current_fold(row, bufnr, winid)
    end

    vim.api.nvim_create_autocmd('CursorMoved', {
      callback = function(opts)
        local winid = vim.api.nvim_get_current_win()
        local row = vim.api.nvim_win_get_cursor(0)[1]
        if row ~= last_row[winid] then
          sync_current_fold(winid, opts.buf)
        end
      end,
    })

    -- Eagerly refresh when focus moves to a window whose cursor row happens
    -- to match the row last recorded for that window (e.g. freshly opened
    -- split), so the highlight isn't left pointing at the previous window's fold.
    vim.api.nvim_create_autocmd('WinEnter', {
      callback = function()
        local winid = vim.api.nvim_get_current_win()
        sync_current_fold(winid, vim.api.nvim_win_get_buf(winid))
      end,
    })

    -- Fallback safety net: some plugins (e.g. animated-scroll plugins like
    -- neoscroll) suppress CursorMoved via eventignore for the duration of an
    -- animation and never re-fire it once done, leaving current_fold stale.
    -- CursorHold isn't commonly suppressed that way, so resync once the
    -- cursor settles (after 'updatetime', 250ms here) as a general catch-all.
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      callback = function(opts)
        local winid = vim.api.nvim_get_current_win()
        sync_current_fold(winid, opts.buf)
      end,
    })

    vim.api.nvim_create_autocmd('WinClosed', {
      callback = function(opts)
        local winid = tonumber(opts.match)
        last_row[winid] = nil

        fold_util.clear_win(winid)
      end,
    })

    vim.api.nvim_create_autocmd({ 'BufUnload', 'BufWipeout' }, {
      callback = function(opts)
        fold_util.clear(opts.buf)
      end,
    })

    vim.opt.statuscolumn = '%!v:lua.StatusCol()'
    function _G.StatusCol()
      return fold_util.statuscol()
    end

    vim.keymap.set('n', '<Left>', function()
      require('origami').h()
    end)
    vim.keymap.set('n', '<Right>', function()
      require('origami').l()
    end)
    vim.keymap.set('n', '^', function()
      require('origami').caret()
    end)
    vim.keymap.set('n', '$', function()
      require('origami').dollar()
    end)
  end,
}
