return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {}
  end,
  keys = {
    {
      '<leader>ma',
      function()
        require('harpoon'):list():add()
      end,
      desc = '[A]dd Mark',
    },
    {
      '<leader>mm',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = 'Quick [M]enu',
    },
    {
      '<leader>mq',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = '[Q]uick Menu',
    },
    {
      '<leader>m,',
      function()
        require('harpoon'):list():prev()
      end,
      desc = 'Go to Previous Marked File',
    },
    {
      '<leader>m.',
      function()
        require('harpoon'):list():next()
      end,
      desc = 'Go to Next File',
    },
    {
      '<leader>m1',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = 'Go to File [1]',
    },
    {
      '<leader>m2',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = 'Go to File [2]',
    },
    {
      '<leader>m3',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = 'Go to File [3]',
    },
    {
      '<leader>m4',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = 'Go to File [4]',
    },
    {
      '<leader>m5',
      function()
        require('harpoon'):list():select(5)
      end,
      desc = 'Go to File [5]',
    },
  },
}
