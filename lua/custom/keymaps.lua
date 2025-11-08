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

vim.keymap.set('n', '<leader>n', function()
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  local menu_items = {
    { name = 'Build', cmd = 'dotnet build', desc = 'Build the project' },
    { name = 'Build (Release)', cmd = 'dotnet build -c Release', desc = 'Build in Release mode' },
    { name = 'Rebuild', cmd = 'dotnet clean && dotnet build', desc = 'Clean and build' },
    { name = 'Clean', cmd = 'dotnet clean', desc = 'Clean build outputs' },
    { name = 'Restore', cmd = 'dotnet restore', desc = 'Restore dependencies' },
    { name = 'Run', cmd = 'dotnet run', desc = 'Run the project' },
    { name = 'Run (Release)', cmd = 'dotnet run -c Release', desc = 'Run in Release mode' },
    { name = 'Test', cmd = 'dotnet test', desc = 'Run tests' },
    { name = 'Watch Run', cmd = 'dotnet watch run', desc = 'Run with file watcher' },
    { name = 'Watch Test', cmd = 'dotnet watch test', desc = 'Test with file watcher' },
  }

  pickers
    .new({}, {
      prompt_title = '🚀 DotNet Commands',
      finder = finders.new_table {
        results = menu_items,
        entry_maker = function(entry)
          return {
            value = entry,
            display = string.format('%-20s %s', entry.name, entry.desc),
            ordinal = entry.name,
          }
        end,
      },
      sorter = conf.generic_sorter {},
      previewer = false,
      layout_config = {
        width = 0.6,
        height = 0.5,
      },
      attach_mappings = function(prompt_bufnr, map)
        local run_command = function(close_on_run)
          local selection = action_state.get_selected_entry()
          if selection then
            if close_on_run then
              actions.close(prompt_bufnr)
            end
            local cmd = selection.value.cmd
            vim.cmd('split | resize 15 | terminal ' .. cmd)
          end
        end

        -- Enter runs Telescope
        actions.select_default:replace(function()
          run_command(false)
        end)

        -- Enters runs and closes Telescope
        map('i', '<C-x>', function()
          run_command(true)
        end)

        return true
      end,
    })
    :find()
end, { desc = 'Dot[N]et CLI Commands' })
