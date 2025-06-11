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
            ['<leader>pc'] = { query = '@class.outer', desc = '[P]eek [c]lass', silent = true },
            ['<leader>pf'] = { query = '@function.outer', desc = '[P]eek [f]unction', silent = true },
          },
        },
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = { query = '@function.outer', desc = 'Select outer part of a [f]unction region' },
            ['if'] = { query = '@function.inner', desc = 'Select inner part of a [f]unction region' },
            ['aC'] = { query = '@class.outer', desc = 'Select outer part of a [c]lass region' },
            ['iC'] = { query = '@class.inner', desc = 'Select inner part of a [c]lass region' },
            ['ac'] = { query = '@conditional.outer', desc = 'Select outer part of a [c]onditional region' },
            ['ic'] = { query = '@conditional.inner', desc = 'Select inner part of a [c]onditional region' },
            ['al'] = { query = '@loop.outer', desc = 'Select outer part of a [l]oop region' },
            ['il'] = { query = '@loop.inner', desc = 'Select inner part of a [l]oop region' },
            ['is'] = { query = '@statement.inner', desc = 'Select inner part of a [s]tatement region' },
            ['as'] = { query = '@statement.outer', desc = 'Select outer part of a [s]tatement region' },
            ['aS'] = { query = '@block.outer', desc = 'Select outer part of a block region' },
            ['iS'] = { query = '@block.inner', desc = 'Select inner part of a block region' },
            ['ad'] = { query = '@comment.outer', desc = 'Select outer part of a [d]ocumentation/comment region' },
            ['aa'] = { query = '@call.outer', desc = 'Select outer part of a [a]rguments/call region' },
            ['ia'] = { query = '@call.inner', desc = 'Select inner part of a [a]rguments/call region' },
            ['ap'] = { query = '@parameter.outer', desc = 'Select outer part of a [p]arameter region' },
            ['ip'] = { query = '@parameter.inner', desc = 'Select inner part of a [p]arameter region' },
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']]'] = { query = { '@class.outer', '@function.outer' }, desc = 'Next class/function start' },
          },
          goto_next_end = {
            [']['] = { query = { '@class.outer', '@function.outer' }, desc = 'Next class/function end' },
          },
          goto_previous_start = {
            ['[['] = { query = { '@class.outer', '@function.outer' }, desc = 'Next class/function end' },
          },
          goto_previous_end = {
            ['[]'] = { query = { '@class.outer', '@function.outer' }, desc = 'Next class/function end' },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>e'] = { query = '@parameter.inner', desc = '[E]xchange next parameter' },
          },
          swap_previous = {
            ['<leader>E'] = { query = '@parameter.inner', desc = '[E]xchange previous parameter' },
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
