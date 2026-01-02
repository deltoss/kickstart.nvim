return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-treesitter.configs').setup {
      textobjects = {
        lsp_interop = {
          enable = true,
          border = 'rounded',
          floating_preview_opts = {},
          peek_definition_code = {
            ['<leader>kc'] = { query = '@class.outer', desc = '[C]lass', silent = true },
            ['<leader>kf'] = { query = '@function.outer', desc = '[F]unction', silent = true },
          },
        },
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = { query = '@function.outer', desc = 'outer [f]unction region' },
            ['if'] = { query = '@function.inner', desc = 'inner [f]unction region' },
            ['aC'] = { query = '@class.outer', desc = 'outer [c]lass region' },
            ['iC'] = { query = '@class.inner', desc = 'inner [c]lass region' },
            ['ac'] = { query = '@conditional.outer', desc = 'outer [c]onditional region' },
            ['ic'] = { query = '@conditional.inner', desc = 'inner [c]onditional region' },
            ['al'] = { query = '@loop.outer', desc = 'outer [l]oop region' },
            ['il'] = { query = '@loop.inner', desc = 'inner [l]oop region' },
            ['is'] = { query = '@statement.inner', desc = 'inner [s]tatement region' },
            ['as'] = { query = '@statement.outer', desc = 'outer [s]tatement region' },
            ['aS'] = { query = '@block.outer', desc = 'outer block region' },
            ['iS'] = { query = '@block.inner', desc = 'inner block region' },
            ['ad'] = { query = '@comment.outer', desc = 'outer [d]ocumentation/comment region' },
            ['aa'] = { query = '@call.outer', desc = 'outer [a]rguments/call region' },
            ['ia'] = { query = '@call.inner', desc = 'inner [a]rguments/call region' },
            ['ap'] = { query = '@parameter.outer', desc = 'outer [p]arameter region' },
            ['ip'] = { query = '@parameter.inner', desc = 'inner [p]arameter region' },
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']f'] = { query = { '@class.outer', '@function.outer' }, desc = 'Next class/function start' },
          },
          goto_next_end = {
            [']F'] = { query = { '@class.outer', '@function.outer' }, desc = 'Next class/function end' },
          },
          goto_previous_start = {
            ['[f'] = { query = { '@class.outer', '@function.outer' }, desc = 'Previous class/function start' },
          },
          goto_previous_end = {
            ['[F'] = { query = { '@class.outer', '@function.outer' }, desc = 'Previous class/function end' },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>Sn'] = { query = '@parameter.inner', desc = '[N]ext parameter' },
          },
          swap_previous = {
            ['<leader>Sp'] = { query = '@parameter.inner', desc = '[P]revious parameter' },
          },
        },
      },
    }

    local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

    -- Repeat movement with ; and ,
    -- ensure ; goes forward and , goes backward regardless of the last direction
    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

    -- vim way: ; goes to the direction you were moving.
    -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}
