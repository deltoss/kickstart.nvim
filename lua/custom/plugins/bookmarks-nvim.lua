return {
  'LintaoAmons/bookmarks.nvim',
  -- pin the plugin at specific version for stability
  -- backup your bookmark sqlite db when there are breaking changes (major version change)
  tag = '3.2.0',
  dependencies = {
    { 'kkharji/sqlite.lua' },
    { 'nvim-telescope/telescope.nvim' }, -- currently has only telescopes supported, but PRs for other pickers are welcome
    { 'stevearc/dressing.nvim' }, -- optional: better UI
  },
  config = function()
    local opts = {} -- check the "./lua/bookmarks/default-config.lua" file for all the options
    require('bookmarks').setup(opts) -- you must call setup to init sqlite db
  end,
  init = function()
    -- I have to point this thing to the SQLite3 DLL manually on Windows.
    -- Downloads here: https://www.sqlite.org/download.html
    -- Choose the "Precompiled Binaries for Windows" option.
    if vim.loop.os_uname().sysname == 'Windows_NT' then
      local arch = vim.loop.os_uname().machine
      if arch == 'x86_64' then
        vim.g.sqlite_clib_path = vim.fs.normalize(vim.fn.stdpath 'config' .. '/data/sqlite/x64/sqlite3.dll')
      elseif arch == 'aarch64' or arch == 'arm64' then
        vim.g.sqlite_clib_path = vim.fs.normalize(vim.fn.stdpath 'config' .. '/data/sqlite/arm64/sqlite3.dll')
      elseif arch == 'i686' then
        vim.g.sqlite_clib_path = vim.fs.normalize(vim.fn.stdpath 'config' .. '/data/sqlite/x86/sqlite3.dll')
      end
    end
  end,
  keys = {
    {
      '<leader>mc',
      ':BookmarksCommands<CR>',
      desc = '[C]ommands',
    },
    {
      '<leader>mm',
      ':BookmarksTree<CR>',
      desc = '[M]arks',
    },
    {
      '<leader>ma',
      ':BookmarksMark<CR>',
      desc = '[A]dd',
    },
    {
      '<leader>mA',
      ':BookmarksDesc<CR>',
      desc = '[A]dd Description',
    },
    {
      '<leader>ms',
      ':BookmarksGoto<CR>',
      desc = '[S]earch',
    },
    {
      '<leader>ml',
      ':BookmarksLists<CR>',
      desc = 'Pick [L]ists',
    },
    {
      ']m',
      ':BookmarksGotoNextInList<CR>',
      desc = 'Next [M]ark in List',
    },
    {
      '[m',
      ':BookmarksGotoPrevInList<CR>',
      desc = 'Previous [M]ark in List',
    },
  },
}
