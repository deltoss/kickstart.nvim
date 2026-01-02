local opt = vim.opt

-- Required for plugins to work (e.g. bufferline.nvim)
opt.termguicolors = true

-- Display
opt.showmatch = true -- Show matching brackets/parentheses
opt.spell = true -- Enable spell checking (not enabled by default)
opt.spelllang = 'en' -- Set spell checking language

-- Tab and Indentation settings
opt.expandtab = true -- Expand tab to spaces
opt.shiftwidth = 2 -- Length to use when shifting text (eg. <<, >> and == commands)
opt.tabstop = 2 -- Length of an actual \t character
opt.softtabstop = 2 -- Makes backspace treat 2 spaces as a tab
opt.shiftwidth = 2

opt.relativenumber = true

opt.conceallevel = 2

-- Wrap lines at the end of a word (not in the middle)
opt.linebreak = true

-- Set how many lines Ctrl-U and Ctrl-D scroll
opt.scroll = 8

opt.listchars:append {
  eol = '↲',
  tab = '→ ',
  trail = '·',
  extends = '›',
  precedes = '‹',
}

-- Diff options
opt.diffopt = {
  'vertical', -- Use vertical splits for diffs
  'iwhiteall', -- Ignore all whitespace
  'indent-heuristic', -- Better diff alignment
  'algorithm:histogram', -- Good diff algorithm
  'linematch:120', -- Increased for better word/character-level diffs
  'closeoff', -- Close diff when one window closes
  'internal', -- Use internal diff library
  'context:10', -- Show more context lines
  'followwrap', -- Follow wrapped lines
  'hiddenoff', -- Turn off diff mode when buffer becomes hidden
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'yaml', 'json', 'xml', 'toml' },
  callback = function()
    vim.opt_local.foldmethod = 'indent'
  end,
})
