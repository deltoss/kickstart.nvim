return {
  'mrjones2014/smart-splits.nvim',
  opts = {
    -- Desired behavior when your cursor is at an edge and you
    -- are moving towards that same edge:
    -- 'wrap' => Wrap to opposite side
    -- 'split' => Create a new split in the desired direction
    -- 'stop' => Do nothing
    -- function => You handle the behavior yourself
    -- NOTE: If using a function, the function will be called with
    -- a context object with the following fields:
    -- {
    --    mux = {
    --      type:'tmux'|'wezterm'|'kitty'|'zellij'
    --      current_pane_id():number,
    --      is_in_session(): boolean
    --      current_pane_is_zoomed():boolean,
    --      -- following methods return a boolean to indicate success or failure
    --      current_pane_at_edge(direction:'left'|'right'|'up'|'down'):boolean
    --      next_pane(direction:'left'|'right'|'up'|'down'):boolean
    --      resize_pane(direction:'left'|'right'|'up'|'down'):boolean
    --      split_pane(direction:'left'|'right'|'up'|'down',size:number|nil):boolean
    --    },
    --    direction = 'left'|'right'|'up'|'down',
    --    split(), -- utility function to split current Neovim pane in the current direction
    --    wrap(), -- utility function to wrap to opposite Neovim pane
    -- }
    -- NOTE: `at_edge = 'wrap'` is not supported on Kitty terminal
    -- multiplexer, as there is no way to determine layout via the CLI
    at_edge = function(context)
      vim.cmd 'silent !zellij action switch-mode normal'
    end,
  },
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
