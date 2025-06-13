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

opt.relativenumber = true

-- Automatically change vim's cwd when opening a buffer.
opt.autochdir = true
