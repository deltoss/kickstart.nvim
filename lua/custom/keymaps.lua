local keymap = vim.keymap.set

-- Remove default s mapping in normal and visual mode
-- This is used for mini-surround, and other plugins.
keymap({ 'n', 'v' }, 's', '<Nop>')

-- Disable defaults gr* mappings (defaults with Neovim nightly)
-- We use the more popular g* mappings
pcall(vim.keymap.del, 'n', 'gra')
pcall(vim.keymap.del, 'n', 'gri')
pcall(vim.keymap.del, 'n', 'grn')
pcall(vim.keymap.del, 'n', 'grr')
pcall(vim.keymap.del, 'n', 'grt')

-- Close mappings
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

-- Newline mappings
keymap('n', '<leader>O', 'o<Esc>', { desc = 'Insert newline after cursor' })

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

-- Paste mappings
keymap('i', '<C-r><C-r>', '<C-r>*', { noremap = true })
keymap('i', '<C-r>r', '<C-r>*', { noremap = true })
keymap('c', '<C-r><C-r>', '<C-r>*', { noremap = true })

-- Better Navigation - Note this interferes with neoscroll plugin
-- keymap({ 'n', 'v' }, '<C-u>', '<C-u>zz')
-- keymap({ 'n', 'v' }, '<C-d>', '<C-d>zz')
-- keymap({ 'n', 'v' }, '<C-e>', '<C-d>zz')
-- keymap({ 'n', 'v' }, 'n', 'nzz')
-- keymap({ 'n', 'v' }, 'N', 'Nzz')

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

-- Insert mode deletion bindings
-- Matches terminal behavior
keymap('i', '<C-BS>', '<C-w>', { noremap = true, desc = 'Delete the previous word' })
keymap('i', '<C-H>', '<C-w>', { noremap = true, desc = 'Delete the previous word' })
keymap('i', '<C-Del>', '<C-o>dw', { noremap = true, desc = 'Delete the next word' })
keymap('i', '<C-d>', '<C-o>dw', { noremap = true, desc = 'Delete the next word' })
keymap('i', '<C-k>', '<C-o>D', { noremap = true, desc = 'Delete to end of line' })

-- Buffer operations
keymap('n', '+', ':bn<CR>', { noremap = true, silent = true })
keymap('n', '_', ':bp<CR>', { noremap = true, silent = true })

-- Window operations
keymap('n', '<leader><Up>', ':split<CR>', { desc = 'Horizontal split (above)' })
keymap('n', '<leader><Down>', ':split<CR>', { desc = 'Horizontal split (below)' })
keymap('n', '<leader><Left>', ':vsplit<CR>', { desc = 'Vertical split (left)' })
keymap('n', '<leader><Right>', ':vsplit<CR>', { desc = 'Vertical split (right)' })

-- Tab operations
keymap('n', '<leader>tt', ':tabnew<CR>', { desc = 'New' })
keymap('n', '<leader>tn', ':tabnew<CR>', { desc = '[N]ew' })
keymap('n', '<leader>ta', ':tabnew<CR>', { desc = '[A]dd' })
keymap('n', '<leader>tf', ':tabf **<Left>', { desc = '[F]ind' })
keymap('n', '<leader>to', ':tabprev<CR>', { desc = 'Previous' })
keymap('n', '<leader>tp', ':tabprev<CR>', { desc = '[P]revious' })
keymap('n', '<leader>t<Left>', ':tabprev<CR>', { desc = 'Left' })
keymap('n', '<leader>tu', ':tabnext<CR>', { desc = 'Next' })
keymap('n', '<leader>tn', ':tabnext<CR>', { desc = '[N]ext' })
keymap('n', '<leader>t<Right>', ':tabnext<CR>', { desc = 'Right' })
keymap('n', '<leader>tm', ':tabmove ', { desc = '[M]ove' })
keymap('n', '<leader>tc', ':tabclose<CR>', { desc = '[C]lose' })
keymap('n', '<leader>tx', ':tabclose<CR>', { desc = 'E[x]it' })
keymap('n', '<leader>tq', ':tabclose<CR>', { desc = '[Q]uit' })
keymap('n', '<leader>td', ':tabdo ', { desc = '[D]o' })
keymap('n', '<leader>ts', ':tabdo %s///g<Left><Left><Left>', { desc = '[S]ubstitution' })

-- Delete without yanking
keymap({ 'n', 'v' }, '<leader>d', '"_d', { noremap = true })
keymap({ 'n', 'v' }, '<leader>D', '"_D', { noremap = true })
keymap({ 'n', 'v' }, '<leader>x', '"_x', { noremap = true })
keymap({ 'n', 'v' }, '<leader>X', '"_X', { noremap = true })

-- Change without yanking
keymap('n', '<leader>c', '"_c', { noremap = true })
keymap('v', '<leader>c', '"_c', { noremap = true })

vim.keymap.set('n', '<leader>~', ':cd %:p:h<CR>', { noremap = true, silent = true, desc = 'Change CWD to Current' })

-- Copying paths to clipboards
local function copyFileName()
  local path = vim.fn.expand '%:t'
  vim.fn.setreg('+', path) -- write to clipboard
end
vim.keymap.set('n', '<leader>pf', copyFileName, { noremap = true, silent = true, desc = 'Copy [F]ile Name' })

local function copyFullPath()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path) -- write to clipboard
end
vim.keymap.set('n', '<leader>pa', copyFullPath, { noremap = true, silent = true, desc = 'Copy [A]bsolute Path' })

local function copyRelativePath()
  local path = vim.fn.expand '%'
  vim.fn.setreg('+', path) -- write to clipboard
end
vim.keymap.set('n', '<leader>pr', copyRelativePath, { noremap = true, silent = true, desc = 'Copy [R]elative Path' })

local function copyDirectoryPath()
  local path = vim.fn.expand '%:h'
  vim.fn.setreg('+', path) -- write to clipboard
end
vim.keymap.set('n', '<leader>pd', copyDirectoryPath, { noremap = true, silent = true, desc = 'Copy [D]irectory Path' })

local function copyLineNumber()
  local lineNumber = vim.fn.expand '%' .. ':' .. vim.fn.line '.'
  vim.fn.setreg('+', lineNumber) -- write to clipboard
end
vim.keymap.set('n', '<leader>pl', copyLineNumber, { noremap = true, silent = true, desc = 'Copy [L]ine Number' })

local function copyVSLaunchCommand()
  local path = vim.fn.expand '%:p'
  local lineNumber = vim.fn.line '.'
  local command = 'devenv /edit "' .. path .. '" /command "edit.goto ' .. lineNumber .. '"'
  vim.fn.setreg('+', command) -- write to clipboard
end
vim.keymap.set('n', '<leader>pv', copyVSLaunchCommand, { noremap = true, silent = true, desc = 'Copy [V]isual Studio Launch Command' })

-- Help
keymap('n', 'k', vim.lsp.buf.hover, { noremap = true })
keymap('n', 'K', function()
  vim.lsp.buf.signature_help() -- First calls shows the window
  vim.lsp.buf.signature_help() -- Second call brings focus to the floating window
end, { noremap = true })
keymap('i', '<C-k>', function()
  vim.lsp.buf.signature_help()
end, { noremap = true }) -- Note this is overwritten by blink.cmp by default

-- Code actions
vim.keymap.set({ 'n', 'v' }, '<leader>.', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set({ 'n', 'v' }, '<C-.>', vim.lsp.buf.code_action, { desc = 'Code actions' })

-- Replace currently selected text with default register without yanking it
keymap('v', '<leader>p', '"_dP', { noremap = true })
keymap('v', 'p', '"_dP', { noremap = true })

-- Join lines
keymap('n', '<leader>j', 'J', { noremap = true })

-- Search and replace word under cursor
keymap('n', '<leader>rw', ':%s/\\<<C-r><C-w>\\>//g<left><left>', { desc = '[W]ord under cursor' })

-- Visual mode: replace highlighted text with entered value
keymap('x', '<leader>rh', "y:%s/\\V<C-r>=escape(@\", '/\\')<CR>//g<Left><Left>", { desc = '[H]ighlighted text' })

-- Visual mode: replace highlighted text with highlighted value + entered value
keymap('x', '<leader>ra', "y:%s/\\V<C-r>=escape(@\", '/\\')<CR>/<C-r>=escape(@\", '/\\&~')<CR>/g<Left><Left>", { desc = '[A]ppend to highlighted text' })
