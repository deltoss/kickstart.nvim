return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - <leader><leader>saiw) - [S]urround [A]dd [I]nner [W]ord [)]Parent
    -- - <leader><leader>sd'   - [S]urround [D]elete [']quotes
    -- - <leader><leader>sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup {
      mappings = {
        add = '<leader><leader>sy', -- Add surrounding in Normal and Visual modes
        delete = '<leader><leader>sd', -- Delete surrounding
        find = '<leader><leader>sf', -- Find surrounding (to the right)
        find_left = '<leader><leader>sF', -- Find surrounding (to the left)
        highlight = '<leader><leader>sh', -- Highlight surrounding
        replace = '<leader><leader>sr', -- Replace surrounding

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    }

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
