local keymap = vim.keymap.set

-- Spelling correction
keymap('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u', { noremap = true, silent = true })

-- Undo/redo mappings
keymap('n', '<C-z>', 'u', { noremap = true })
keymap('v', '<C-z>', 'u', { noremap = true })
keymap('i', '<C-z>', '<C-o>u', { noremap = true })
keymap('n', '<C-S-z>', '<C-r>', { noremap = true })
keymap('v', '<C-S-z>', '<C-r>', { noremap = true })
keymap('i', '<C-S-z>', '<C-o><C-r>', { noremap = true })

-- Better Navigations
keymap('n', '<C-u>', '<C-u>zz', { noremap = true })
keymap('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
keymap('n', '<C-e>', '<C-d>zz', { noremap = true })
keymap('n', '<C-y>', '<Nop>', { noremap = true, silent = true })

-- Wrapped line navigation
keymap('n', '<C-Up>', 'gk', { noremap = true })
keymap('v', '<C-Up>', 'gk', { noremap = true })
keymap('i', '<Up>', '<C-o>gk', { noremap = true })
keymap('n', '<C-Down>', 'gj', { noremap = true })
keymap('v', '<C-Down>', 'gj', { noremap = true })
keymap('i', '<Down>', '<C-o>gj', { noremap = true })

-- Save with Ctrl+S
keymap('n', '<C-s>', ':update<CR>', { noremap = true, silent = true })
keymap('i', '<C-s>', '<Esc>:update<CR>', { noremap = true, silent = true })

-- Indent and outdent with < and > in visual mode
keymap('v', '<', '<gv', { noremap = true })
keymap('v', '>', '>gv', { noremap = true })

-- Autocompletion
keymap('i', '<A-,>', '<C-p>', { noremap = true })
keymap('i', '<A-.>', '<C-n>', { noremap = true })

-- Map Ctrl+Backspace to delete the previous word in insert mode
keymap('i', '<C-BS>', '<C-w>', { noremap = true })
-- Map Ctrl+Delete to delete the next word in insert mode
keymap('i', '<C-Del>', '<C-o>dw', { noremap = true })

-- Window operations
keymap('n', '<C-w>y', '<C-w>h', { noremap = true })
keymap('n', '<C-w>h', '<C-w>j', { noremap = true })
keymap('n', '<C-w>a', '<C-w>k', { noremap = true })
keymap('n', '<C-w>e', '<C-w>l', { noremap = true })
keymap('n', '<leader>y', '<C-w>h', { noremap = true })
keymap('n', '<leader>h', '<C-w>j', { noremap = true })
keymap('n', '<leader>a', '<C-w>k', { noremap = true })
keymap('n', '<leader>e', '<C-w>l', { noremap = true })

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