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
      '<leader>pa',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'har[p]oon [a]dd file',
    },
    {
      '<leader>pq',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = 'har[p]oon [q]uick menu',
    },
    {
      '<leader>pp',
      function()
        require('harpoon'):list():prev()
      end,
      desc = 'har[p]oon to [p]revious buffer in harpoon list',
    },
    {
      '<leader>pn',
      function()
        require('harpoon'):list():next()
      end,
      desc = 'har[p]oon to [n]next buffer in harpoon list',
    },
    {
      '<leader>p1',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = 'har[p]oon to file [1]',
    },
    {
      '<leader>p2',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = 'har[p]oon to file [2]',
    },
    {
      '<leader>p3',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = 'har[p]oon to file [3]',
    },
    {
      '<leader>p4',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = 'har[p]oon to file [4]',
    },
    {
      '<leader>p5',
      function()
        require('harpoon'):list():select(5)
      end,
      desc = 'har[p]oon to file [5]',
    },
  },
}
