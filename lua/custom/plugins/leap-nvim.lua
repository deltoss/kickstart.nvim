return {
  {
    'ggandor/leap.nvim',
    dependencies = { 'tpope/vim-repeat' }, -- Optional but recommended
    config = function()
      local leap = require 'leap'

      vim.keymap.set('n', 'L', '<Plug>(leap-from-window)')
      vim.keymap.set('n', 'l', '<Plug>(leap-anywhere)')
      vim.keymap.set({ 'x', 'o' }, 'l', '<Plug>(leap)')

      leap.opts.preview_filter = function(ch0, ch1, ch2)
        return not (ch1:match '%s' or ch0:match '%a' and ch1:match '%a' and ch2:match '%a')
      end

      leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }

      require('leap.user').set_repeat_keys('<enter>', '<backspace>')
    end,
  },
}
