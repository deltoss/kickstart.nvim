return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  dependencies = {
    {
      'folke/which-key.nvim',
      opts = function(_, opts)
        opts.spec = opts.spec or {}
        table.insert(opts.spec, { '<leader><leader>s', group = '[S]urround' })
        return opts
      end,
    },
  },
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

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

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
