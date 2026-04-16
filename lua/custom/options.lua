-- See `:help vim.o`

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.updatetime     = 250 -- Decrease update time
vim.o.timeoutlen     = 300 -- Decrease mapped sequence wait time
vim.o.mouse          = 'a' -- Enable mouse mode, can be useful for resizing splits for example!

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase     = true
vim.o.smartcase      = true

-- Display
vim.g.have_nerd_font = true    -- Set to true if you have a Nerd Font installed and selected in the terminal
vim.o.cursorline     = true    -- Show which line your cursor is on
vim.o.showmode       = false   -- Don't show the mode, since it's already in the status line
vim.o.showmatch      = true    -- Show matching brackets/parentheses
vim.o.smoothscroll   = true    -- Scroll by screen lines instead of jumping by text lines
vim.o.scroll         = 8       -- Set how many lines Ctrl-U and Ctrl-D scroll
vim.o.spell          = true    -- Enable spell checking
vim.o.spelllang      = 'en'    -- Set spell checking language
vim.o.relativenumber = true    -- Displays relative numbers at the gutter
vim.o.conceallevel   = 2
vim.o.linebreak      = true    -- Wrap lines at the end of a word (not in the middle)
vim.o.colorcolumn    = '120'   -- Visual vertical guide at specified column
vim.o.textwidth      = 120     -- Hard-wrap text at specified columns
vim.o.inccommand     = 'split' -- Preview substitutions live, as you type!
vim.o.splitright     = true    -- Open vertical splits to the right
vim.o.splitbelow     = true    -- Open horizontal splits below
vim.o.breakindent    = true    -- Enable break indent
vim.o.signcolumn     = 'yes'   -- Keep signcolumn on by default
vim.o.scrolloff      = 13      -- Minimal number of screen lines to keep above and below the cursor
-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s).
-- See `:help 'confirm'`
vim.o.confirm        = true


-- Tab and indentation settings
vim.o.expandtab   = true -- Expand tab to spaces
vim.o.shiftwidth  = 2    -- Length to use when shifting text (e.g. <<, >> and == commands)
vim.o.tabstop     = 2    -- Length of an actual \t character
vim.o.softtabstop = 2    -- Makes backspace treat 2 spaces as a tab


vim.o.termguicolors = true                                      -- Required for plugins to work (e.g. bufferline.nvim)
vim.o.undofile      = true                                      -- Save undo history
vim.o.swapfile      = false                                     -- Disable .swp file creation
vim.o.completeopt   = 'menu,menuone,fuzzy,noinsert'             -- Popup menu with fuzzy match, no auto-insert
vim.o.grepprg       = 'rg --vimgrep --no-messages --smart-case' -- Use ripgrep for :grep

-- Append to options that have meaningful defaults we want to preserve
vim.opt.wildoptions:append { 'fuzzy' } -- Fuzzy matching in command-line completion
vim.opt.path:append { '**' }           -- Recursive subdirectory search for :find, gf, etc.


-- Sets how Neovim will display certain whitespace characters in the editor.
-- See `:help 'list'` and `:help 'listchars'`
vim.o.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
  eol = '↲',
  extends = '›',
  precedes = '‹',
}
vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  eob = ' ', -- Don't show ~ at end of buffer
  diff = '╱', -- Nicer delete lines in DiffView
}


-- Diff options
vim.opt.diffopt = {
  'vertical',            -- Use vertical splits for diffs
  'iwhiteall',           -- Ignore all whitespace
  'indent-heuristic',    -- Better diff alignment
  'algorithm:histogram', -- Good diff algorithm
  'closeoff',            -- Close diff when one window closes
  'internal',            -- Use internal diff library
  'context:10',          -- Show more context lines
  'followwrap',          -- Follow wrapped lines
  'hiddenoff',           -- Turn off diff mode when buffer becomes hidden
}


vim.api.nvim_create_autocmd('FileType', {
  pattern  = { 'yaml', 'json', 'xml', 'toml' },
  callback = function()
    vim.opt_local.foldmethod = 'indent'
  end,
})
