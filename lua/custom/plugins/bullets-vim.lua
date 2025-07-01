vim.g.bullets_set_mappings = 0
return {
  'bullets-vim/bullets.vim',
  ft = { 'markdown', 'text', 'gitcommit' }, -- only load for these file types
  keys = {
    -- Insert mode mappings
    { '<cr>', '<Plug>(bullets-newline)', mode = 'i', desc = 'Bullets newline' },
    { '<C-cr>', '<cr>', mode = 'i', desc = 'Regular newline' },
    { '<C-t>', '<Plug>(bullets-demote)', mode = 'i', desc = 'Demote bullet' },
    { '<C-d>', '<Plug>(bullets-promote)', mode = 'i', desc = 'Promote bullet' },

    -- Normal mode mappings
    { 'o', '<Plug>(bullets-newline)', desc = 'Bullets newline' },
    { 'gN', '<Plug>(bullets-renumber)', desc = 'Renumber bullets' },
    -- { '<leader>x', '<Plug>(bullets-toggle-checkbox)', desc = 'Toggle checkbox' },
    { '>>', '<Plug>(bullets-demote)', desc = 'Demote bullet' },
    { '<<', '<Plug>(bullets-promote)', desc = 'Promote bullet' },

    -- Visual mode mappings
    { 'gN', '<Plug>(bullets-renumber)', mode = 'v', desc = 'Renumber bullets' },
    { '>', '<Plug>(bullets-demote)', mode = 'v', desc = 'Demote bullet' },
    { '<', '<Plug>(bullets-promote)', mode = 'v', desc = 'Promote bullet' },
  },
}
