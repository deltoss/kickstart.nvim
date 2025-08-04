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
      desc = '[M]ark [A]dd File',
    },
    {
      '<leader>mm',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = '[M]ark Quick Menu',
    },
    {
      '<leader>mq',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = '[M]ark [Q]uick Menu',
    },
    {
      '<leader>m,',
      function()
        require('harpoon'):list():prev()
      end,
      desc = '[M]ark go to Previous Marked File',
    },
    {
      '<leader>m.',
      function()
        require('harpoon'):list():next()
      end,
      desc = '[M]ark go to Next File',
    },
    {
      '<leader>m1',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = '[M]ark go to File [1]',
    },
    {
      '<leader>m2',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = '[M]ark go to File [2]',
    },
    {
      '<leader>m3',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = '[M]ark go to File [3]',
    },
    {
      '<leader>m4',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = '[M]ark go to File [4]',
    },
    {
      '<leader>m5',
      function()
        require('harpoon'):list():select(5)
      end,
      desc = '[M]ark go to File [5]',
    },
  },
}
