vim.keymap.set('n', '<leader>q', function()
  require('quicker').toggle()
end, {
  desc = 'Toggle [Q]uickfix',
})

vim.keymap.set('n', '<leader>l', function()
  require('quicker').toggle { loclist = true }
end, {
  desc = 'Toggle [L]oclist', -- Basically, quickfix for local window only
})

-- Quickfix: Use Snacks picker or telescope search, then load it into quickfix for navigation with <C-q>
return {
  'stevearc/quicker.nvim',
  ft = 'qf',
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {
    keys = {
      -- <C-Enter>  Go to quickfix location
      {
        '>',
        function()
          require('quicker').expand { before = 2, after = 2, add_to_existing = true }
        end,
        desc = 'Expand quickfix context',
      },
      {
        '<',
        function()
          require('quicker').collapse()
        end,
        desc = 'Collapse quickfix context',
      },
    },
  },
}
