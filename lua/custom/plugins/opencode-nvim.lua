return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for default `toggle()` implementation.
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    local port = tonumber(os.getenv 'OPENCODE_PORT')
    local pane_id = nil

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
      port = port,
      ---@type opencode.Provider
      provider = {
        toggle = function(self)
          print(pane_id)
          local port = vim.g.opencode_opts.port

          -- Check if pane exists and is still alive
          if pane_id then
            vim.fn.system 'wezterm cli activate-pane-direction Right'
            return
          end

          -- Create new pane
          local output = vim.fn.system('wezterm cli split-pane --right --percent 40 -- opencode --port ' .. port)
          pane_id = tonumber(output:match '%d+')
        end,

        start = function(self)
          local port = vim.g.opencode_opts.port
          local output = vim.fn.system('wezterm cli split-pane --right --percent 40 -- opencode --port ' .. port)
          pane_id = tonumber(output:match '%d+')
        end,

        show = function(self)
          vim.fn.system 'wezterm cli activate-pane-direction Down'
        end,
      },
    }

    -- Required for `opts.auto_reload`.
    vim.o.autoread = true

    -- Recommended/example keymaps.
    vim.keymap.set({ 'n', 'x' }, '<leader>aoq', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'Ask Opencode a [Q]uestion' })
    vim.keymap.set({ 'n', 'x' }, '<leader>aox', function()
      require('opencode').select()
    end, { desc = 'E[x]ecute Opencode Action…' })
    vim.keymap.set({ 'n', 'x' }, '<leader>aoa', function()
      require('opencode').prompt '@this'
    end, { desc = '[A]dd to Opencode' })
    vim.keymap.set({ 'n', 't' }, '<leader>aot', function()
      require('opencode').toggle()
    end, { desc = '[T]oggle Opencode' })
    vim.keymap.set('n', '<S-C-u>', function()
      require('opencode').command 'session.half.page.up'
    end, { desc = 'Opencode Half Page Up' })
    vim.keymap.set('n', '<S-C-d>', function()
      require('opencode').command 'session.half.page.down'
    end, { desc = 'Opencode Half Page Down' })
  end,
}
