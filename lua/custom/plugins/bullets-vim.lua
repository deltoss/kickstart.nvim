vim.g.bullets_set_mappings = 0
return {
  'bullets-vim/bullets.vim',
  ft = { 'markdown', 'text', 'gitcommit' }, -- only load for these file types
  keys = {
    -- Insert mode mappings
    { '<cr>', '<Plug>(bullets-newline)', mode = 'i', desc = 'Bullets newline' },
    { '<C-cr>', '<cr>', mode = 'i', desc = 'Regular newline' },

    -- Normal mode mappings
    { 'o', '<Plug>(bullets-newline)', desc = 'Bullets newline' },
    { 'gN', '<Plug>(bullets-renumber)', desc = 'Renumber bullets' },
    { '>>', '<Plug>(bullets-demote)', desc = 'Demote bullet' },
    { '<<', '<Plug>(bullets-promote)', desc = 'Promote bullet' },

    -- Visual mode mappings
    { 'gN', '<Plug>(bullets-renumber)', mode = 'v', desc = 'Renumber bullets' },
    { '>', '<Plug>(bullets-demote)gv', mode = 'v', desc = 'Demote bullet' },
    { '<', '<Plug>(bullets-promote)gv', mode = 'v', desc = 'Promote bullet' },
  },
}
