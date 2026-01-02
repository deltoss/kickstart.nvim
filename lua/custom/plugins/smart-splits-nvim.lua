return {
  'mrjones2014/smart-splits.nvim',
  keys = {
    {
      '<C-A-Left>',
      function()
        require('smart-splits').resize_left()
      end,
      desc = 'Resize left',
    },
    {
      '<C-A-Down>',
      function()
        require('smart-splits').resize_down()
      end,
      desc = 'Resize down',
    },
    {
      '<C-A-Up>',
      function()
        require('smart-splits').resize_up()
      end,
      desc = 'Resize up',
    },
    {
      '<C-A-Right>',
      function()
        require('smart-splits').resize_right()
      end,
      desc = 'Resize right',
    },
    {
      '<A-Left>',
      function()
        require('smart-splits').move_cursor_left()
      end,
      desc = 'Activate left',
    },
    {
      '<A-Down>',
      function()
        require('smart-splits').move_cursor_down()
      end,
      desc = 'Activate down',
    },
    {
      '<A-Up>',
      function()
        require('smart-splits').move_cursor_up()
      end,
      desc = 'Activate up',
    },
    {
      '<A-Right>',
      function()
        require('smart-splits').move_cursor_right()
      end,
      desc = 'Activate right',
    },
    {
      '<leader><leader><Left>',
      function()
        require('smart-splits').swap_buf_left()
      end,
      desc = 'Swap left buffer',
    },
    {
      '<leader><leader><Down>',
      function()
        require('smart-splits').swap_buf_down()
      end,
      desc = 'Swap down buffer',
    },
    {
      '<leader><leader><Up>',
      function()
        require('smart-splits').swap_buf_up()
      end,
      desc = 'Swap up buffer',
    },
    {
      '<leader><leader><Right>',
      function()
        require('smart-splits').swap_buf_right()
      end,
      desc = 'Swap right buffer',
    },
  },
}
