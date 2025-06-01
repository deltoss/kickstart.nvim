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
      desc = 'harpoon [m]ark [a]dd file',
    },
    {
      '<leader>mm',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = 'harpoon [m]ark quick [m]enu',
    },
    {
      '<leader>mq',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = 'harpoon [m]ark [q]uick menu',
    },
    {
      '<leader>mp',
      function()
        require('harpoon'):list():prev()
      end,
      desc = 'harpoon [m]ark go to [p]revious marked file',
    },
    {
      '<leader>mn',
      function()
        require('harpoon'):list():next()
      end,
      desc = 'harpoon [m]ark go to [n]ext marked file',
    },
    {
      '<leader>m1',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = 'harpoon go to [m]arked file [1]',
    },
    {
      '<leader>m2',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = 'harpoon go to [m]arked file [2]',
    },
    {
      '<leader>m3',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = 'harpoon go to [m]arked file [3]',
    },
    {
      '<leader>m4',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = 'harpoon go to [m]arked file [4]',
    },
    {
      '<leader>m5',
      function()
        require('harpoon'):list():select(5)
      end,
      desc = 'harpoon go to [m]arked file [5]',
    },
  },
}
