local keymap = vim.keymap.set

-- Spelling correction
keymap('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u', { noremap = true, silent = true })

-- Undo/redo mappings
keymap('n', '<C-z>', 'u', { noremap = true })
keymap('v', '<C-z>', 'u', { noremap = true })
keymap('i', '<C-z>', '<C-o>u', { noremap = true })
keymap('n', '<C-y>', '<C-r>', { noremap = true })
keymap('v', '<C-y>', '<C-r>', { noremap = true })
keymap('i', '<C-y>', '<C-o><C-r>', { noremap = true })
keymap('i', '<C-r><C-r>', '<C-r>*', { noremap = true })
keymap('i', '<C-r>r', '<C-r>*', { noremap = true })
keymap('c', '<C-r><C-r>', '<C-r>*', { noremap = true })

-- Better Navigations
keymap('n', '<C-u>', '<C-u>zz', { noremap = true })
keymap('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
keymap('n', '<C-e>', '<C-d>zz', { noremap = true })

-- Wrapped line navigation
keymap('n', '<C-Up>', 'gk', { noremap = true })
keymap('v', '<C-Up>', 'gk', { noremap = true })
keymap('i', '<Up>', '<C-o>gk', { noremap = true })
keymap('n', '<C-Down>', 'gj', { noremap = true })
keymap('v', '<C-Down>', 'gj', { noremap = true })
keymap('i', '<Down>', '<C-o>gj', { noremap = true })

-- Save with Ctrl+S

if vim.g.started_by_firenvim then
  keymap('n', '<C-s>', ':wq<CR>', { noremap = true, silent = true })
  keymap('i', '<C-s>', '<Esc>:wq<CR>', { noremap = true, silent = true })
else
  keymap('n', '<C-s>', ':update<CR>', { noremap = true, silent = true })
  keymap('i', '<C-s>', '<Esc>:update<CR>', { noremap = true, silent = true })
end

-- Indent and outdent with < and > in visual mode
keymap('v', '<', '<gv', { noremap = true })
keymap('v', '>', '>gv', { noremap = true })

-- Autocompletion
keymap('i', '<A-,>', '<C-p>', { noremap = true })
keymap('i', '<A-.>', '<C-n>', { noremap = true })

-- Map Ctrl+Backspace to delete the previous word in insert mode
keymap('i', '<C-BS>', '<C-w>', { noremap = true })
keymap('i', '<C-H>', '<C-w>', { noremap = true })
-- Map Ctrl+Delete to delete the next word in insert mode
keymap('i', '<C-Del>', '<C-o>dw', { noremap = true })

-- Window operations
vim.keymap.set('n', '<leader><Up>', ':split<CR>', { desc = 'Horizontal split (above)' })
vim.keymap.set('n', '<leader><Down>', ':split<CR>', { desc = 'Horizontal split (below)' })
vim.keymap.set('n', '<leader><Left>', ':vsplit<CR>', { desc = 'Vertical split (left)' })
vim.keymap.set('n', '<leader><Right>', ':vsplit<CR>', { desc = 'Vertical split (right)' })

-- Delete without yanking
keymap('n', '<leader>d', '"_d', { noremap = true })
keymap('v', '<leader>d', '"_d', { noremap = true })
keymap('n', '<leader>D', '"_D', { noremap = true })
keymap('v', '<leader>D', '"_D', { noremap = true })

-- Change without yanking
keymap('n', '<leader>c', '"_c', { noremap = true })
keymap('v', '<leader>c', '"_c', { noremap = true })

-- Replace currently selected text with default register without yanking it
keymap('v', '<leader>p', '"_dP', { noremap = true })
keymap('v', 'p', '"_dP', { noremap = true })

-- Join lines
keymap('n', '<leader>j', 'J', { noremap = true })
