-- There are issues with Zellij integration, so disable it completely
vim.g.smart_splits_multiplexer_integration = false
return {
  'mrjones2014/smart-splits.nvim',
  keys = {
    {
      '<S-Left>',
      function()
        require('smart-splits').resize_left()
      end,
      desc = 'Resize left',
    },
    {
      '<S-Down>',
      function()
        require('smart-splits').resize_down()
      end,
      desc = 'Resize down',
    },
    {
      '<S-Up>',
      function()
        require('smart-splits').resize_up()
      end,
      desc = 'Resize up',
    },
    {
      '<S-Right>',
      function()
        require('smart-splits').resize_right()
      end,
      desc = 'Resize right',
    },
    {
      '<C-Left>',
      function()
        require('smart-splits').move_cursor_left()
      end,
      desc = 'Activate left',
    },
    {
      '<C-Down>',
      function()
        require('smart-splits').move_cursor_down()
      end,
      desc = 'Activate down',
    },
    {
      '<C-Up>',
      function()
        require('smart-splits').move_cursor_up()
      end,
      desc = 'Activate up',
    },
    {
      '<C-Right>',
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
