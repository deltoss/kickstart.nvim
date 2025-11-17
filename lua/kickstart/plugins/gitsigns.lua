-- Adds git related signs to the gutter, as well as utilities for managing changes
-- NOTE: gitsigns is already included in init.lua but contains only the base
-- config. This will add also the recommended keymaps.

return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [s]tage hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [r]eset hunk' })
        -- normal mode
        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = '[s]tage hunk' })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[r]eset hunk' })
        map('n', '<leader>gS', gitsigns.stage_buffer, { desc = '[S]tage buffer' })
        map('n', '<leader>gu', gitsigns.stage_hunk, { desc = '[u]ndo stage hunk' })
        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[R]eset buffer' })
        map('n', '<leader>gp', gitsigns.preview_hunk, { desc = '[p]review hunk' })
        map('n', '<leader>gb', gitsigns.blame_line, { desc = '[b]lame line' })
        map('n', '<leader>gc', gitsigns.diffthis, { desc = '[c]hanges compared to index' })
        map('n', '<leader>gC', function()
          gitsigns.diffthis '@'
        end, { desc = '[C]hanges compared to last commit' })
        -- Toggles
        map('n', '<leader><leader>ob', gitsigns.toggle_current_line_blame, { desc = 'Toggle git show [b]lame line' })
        map('n', '<leader><leader>oD', gitsigns.preview_hunk_inline, { desc = 'Toggle git show [D]eleted' })

        map('n', '<leader>gHl', gitsigns.setloclist, { desc = 'Get [h]unk [l]ocations for current buffer' })
        map('n', '<leader>gHL', function()
          gitsigns.setloclist(nil, 'all')
        end, { desc = 'Get [h]unk [L]ocations for repository' })

        map('n', '<leader>gq', gitsigns.setqflist, { desc = 'Get [q]uickfix list for current buffer' })
        map('n', '<leader>gQ', function()
          gitsigns.setqflist 'all'
        end, { desc = 'Get [Q]uickfix list for repository' })
      end,
    },
  },
}
