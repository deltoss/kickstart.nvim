local opt = vim.opt

-- Display
opt.showmatch = true      -- Show matching brackets/parentheses
opt.smoothscroll = true   -- Scroll by screen lines instead of jumping by text lines
opt.scroll = 8            -- Set how many lines Ctrl-U and Ctrl-D scroll
opt.spell = true          -- Enable spell checking (not enabled by default)
opt.spelllang = 'en'      -- Set spell checking language
opt.relativenumber = true -- Displays relative numbers at the gutter
opt.conceallevel = 2
opt.linebreak = true      -- Wrap lines at the end of a word (not in the middle)
opt.colorcolumn = '120'   -- Visual vertical guide at specified column
opt.textwidth = 120       -- Hard-wrap text at specified columns


-- Tab and Indentation settings
opt.expandtab = true -- Expand tab to spaces
opt.shiftwidth = 2   -- Length to use when shifting text (eg. <<, >> and == commands)
opt.tabstop = 2      -- Length of an actual \t character
opt.softtabstop = 2  -- Makes backspace treat 2 spaces as a tab


opt.termguicolors = true                                -- Required for plugins to work (e.g. bufferline.nvim)
opt.swapfile = false                                    -- Disable .swp file creation
opt.completeopt = 'menu,menuone,fuzzy,noinsert'         -- Popup menu with fuzzy match, no auto-insert
opt.wildoptions:append { 'fuzzy' }                      -- Fuzzy matching in command-line completion
opt.path:append { '**' }                                -- Recursive subdirectory search for :find, gf, etc.
opt.grepprg = 'rg --vimgrep --no-messages --smart-case' -- Use ripgrep for :grep


opt.listchars:append {
  eol = '↲',
  tab = '→ ',
  trail = '·',
  extends = '›',
  precedes = '‹',
}

opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  eob = ' ', -- Don't show ~ at end of buffer
  diff = '╱', -- Nicer delete lines in DiffView
}


-- Diff options
opt.diffopt = {
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
  pattern = { 'yaml', 'json', 'xml', 'toml' },
  callback = function()
    vim.opt_local.foldmethod = 'indent'
  end,
})
