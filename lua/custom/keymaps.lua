local keymap = vim.keymap.set

keymap('n', 'Zq', ':q<cr>', { desc = '[Q]uit' })
keymap('n', 'ZQ', ':q<cr>', { desc = '[Q]uit' })
keymap('n', '<leader>zq', ':q<cr>', { desc = '[Q]uit' })
keymap('n', '<leader>zz', ':q<cr>', { desc = '[Q]uit' })
keymap('n', 'ZW', ':wq<cr>', { desc = '[W]rite and Quit' })
keymap('n', 'Zw', ':wq<cr>', { desc = '[W]rite and Quit' })
keymap('n', '<leader>zw', ':wq<cr>', { desc = '[W]rite and Quit' })
keymap('n', 'Zb', ':bd<cr>', { desc = 'Close Current [B]uffer' })
keymap('n', 'ZB', ':bd<cr>', { desc = 'Close Current [B]uffer' })
keymap('n', '<leader>zb', ':bd<cr>', { desc = 'Close Current [B]uffer' })

keymap('n', '<C-Enter>', 'o<Esc>', { desc = 'Insert newline after cursor' })
keymap('n', '<S-Enter>', 'O<Esc>', { desc = 'Insert newline before cursor' })

-- Spelling correction
keymap('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u', { noremap = true, silent = true })
keymap('n', '<C-l>', '[s1z=`]', { noremap = true, silent = true })

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
keymap({ 'n', 'v' }, '<C-u>', '<C-u>zz', { noremap = true })
keymap({ 'n', 'v' }, '<C-d>', '<C-d>zz', { noremap = true, silent = true })
keymap({ 'n', 'v' }, '<C-e>', '<C-d>zz', { noremap = true })

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
keymap('i', '<C-,>', '<C-p>', { noremap = true })
keymap('i', '<C-.>', '<C-n>', { noremap = true })

-- Map Ctrl+Backspace to delete the previous word in insert mode
keymap('i', '<C-BS>', '<C-w>', { noremap = true })
keymap('i', '<C-H>', '<C-w>', { noremap = true })
-- Map Ctrl+Delete to delete the next word in insert mode
keymap('i', '<C-Del>', '<C-o>dw', { noremap = true })

-- Buffer operations
keymap('n', '+', ':bn<CR>', { noremap = true, silent = true })
keymap('n', '_', ':bp<CR>', { noremap = true, silent = true })

-- Window operations
keymap('n', '<leader><Up>', ':split<CR>', { desc = 'Horizontal split (above)' })
keymap('n', '<leader><Down>', ':split<CR>', { desc = 'Horizontal split (below)' })
keymap('n', '<leader><Left>', ':vsplit<CR>', { desc = 'Vertical split (left)' })
keymap('n', '<leader><Right>', ':vsplit<CR>', { desc = 'Vertical split (right)' })

-- Tab operations
keymap('n', '<leader>tt', ':tabnew<CR>', { desc = '[T]ab new' })
keymap('n', '<leader>tn', ':tabnew<CR>', { desc = '[T]ab [n]ew' })
keymap('n', '<leader>ta', ':tabnew<CR>', { desc = '[T]ab [a]dd' })
keymap('n', '<leader>tf', ':tabf **<Left>', { desc = '[T]ab [f]ind' })
keymap('n', '<leader>to', ':tabprev<CR>', { desc = '[T]ab previous' })
keymap('n', '<leader>tp', ':tabprev<CR>', { desc = '[T]ab [p]revious' })
keymap('n', '<leader>t<Left>', ':tabprev<CR>', { desc = '[T]ab left' })
keymap('n', '<leader>tu', ':tabnext<CR>', { desc = '[T]ab next' })
keymap('n', '<leader>tn', ':tabnext<CR>', { desc = '[T]ab [n]ext' })
keymap('n', '<leader>t<Right>', ':tabnext<CR>', { desc = '[T]ab right' })
keymap('n', '<leader>tm', ':tabmove ', { desc = '[T]ab [m]ove' })
keymap('n', '<leader>tc', ':tabclose<CR>', { desc = '[T]ab [c]lose' })
keymap('n', '<leader>tx', ':tabclose<CR>', { desc = '[T]ab E[x]it' })
keymap('n', '<leader>tq', ':tabclose<CR>', { desc = '[T]ab [Q]uit' })
keymap('n', '<leader>td', ':tabdo ', { desc = '[T]ab [d]o' })
keymap('n', '<leader>ts', ':tabdo %s///g<Left><Left><Left>', { desc = '[T]ab [s]ubstitution' })

-- Delete without yanking
keymap({ 'n', 'v' }, '<leader>d', '"_d', { noremap = true })
keymap({ 'n', 'v' }, '<leader>D', '"_D', { noremap = true })
keymap({ 'n', 'v' }, '<leader>x', '"_x', { noremap = true })
keymap({ 'n', 'v' }, '<leader>X', '"_X', { noremap = true })

-- Change without yanking
keymap('n', '<leader>c', '"_c', { noremap = true })
keymap('v', '<leader>c', '"_c', { noremap = true })

-- Replace currently selected text with default register without yanking it
keymap('v', '<leader>p', '"_dP', { noremap = true })
keymap('v', 'p', '"_dP', { noremap = true })

-- Join lines
keymap('n', '<leader>j', 'J', { noremap = true })

-- Search and replace word under cursor
keymap('n', '<leader>rw', ':%s/\\<<C-r><C-w>\\>//g<left><left>', { desc = '[R]eplace [W]ord under cursor' })

-- Visual mode: replace highlighted text with entered value
keymap('x', '<leader>rh', "y:%s/\\V<C-r>=escape(@\", '/\\')<CR>//g<Left><Left>", { desc = '[R]eplace [H]ighlighted text' })

-- Visual mode: replace highlighted text with highlighted value + entered value
keymap(
  'x',
  '<leader>ra',
  "y:%s/\\V<C-r>=escape(@\", '/\\')<CR>/<C-r>=escape(@\", '/\\&~')<CR>/g<Left><Left>",
  { desc = '[R]eplace highlighted text with highlight and [A]ppend to it' }
)

-- Quickfix: Use Telescope search, then load it into quickfix for navigation with <C-q>
keymap('n', '<leader>q', function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and 'cclose' or 'copen'
  vim.cmd('botright ' .. action)
end, { desc = 'Toggle [Q]uickfix list', silent = true })
keymap('n', 'cP', ':colder<CR>')
keymap('n', 'cn', ':cnext<CR>')
keymap('n', 'cp', ':cprev<CR>')
keymap('n', 'cN', ':cnewer<CR>')

keymap('n', '<leader>l', function()
  local win = vim.api.nvim_get_current_win()
  local qf_winid = vim.fn.getloclist(win, { winid = 0 }).winid
  local action = qf_winid > 0 and 'lclose' or 'lopen'
  vim.cmd(action)
end, { desc = 'Toggle [L]ocations list', silent = true })
