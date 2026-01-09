return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    -- labels = "abcdefghijklmnopqrstuvwxyz",
    labels = '0123456789',
    search = {
      ---@type Flash.Pattern.Mode
      -- Each mode will take ignorecase and smartcase into account.
      -- * exact: exact match
      -- * search: regular search
      -- * fuzzy: fuzzy search
      -- * fun(str): custom function that returns a pattern
      --   For example, to only match at the beginning of a word:
      --   mode = function(str)
      --     return "\\<" .. str
      --   end,
      mode = 'fuzzy',
      exclude = {
        'notify',
        'cmp_menu',
        'noice',
        'flash_prompt',
        'blink-cmp-menu',
        function(win)
          return not vim.api.nvim_win_get_config(win).focusable
        end,
      },
    },
    label = {
      -- allow uppercase labels
      uppercase = false,
    },
    -- You can override the default options for a specific mode.
    -- Use it with `require("flash").jump({mode = "forward"})`
    ---@type table<string, Flash.Config>
    modes = {
      -- options used when flash is activated through
      -- a regular search with `/` or `?`
      search = {
        -- when `true`, flash will be activated during regular search by default.
        -- You can always toggle when searching with `require("flash").toggle()`
        enabled = true,
        highlight = { backdrop = true },
        jump = { history = true, register = true, nohlsearch = true },
      },
      -- options used for treesitter selections
      -- `require("flash").treesitter()`
      treesitter = {
        labels = '0123456789',
      },
    },
  },
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter Search',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
}
