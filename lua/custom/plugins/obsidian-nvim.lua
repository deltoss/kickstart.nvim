return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'Zettelkasten',
        path = '~/Documents/Note Taking/Zettelkasten/Notes/',
      },
    },
  },
  keys = {
    { '<leader>on', '<cmd>ObsidianNew<cr>', desc = '[N]ew Note' },
    { '<leader>ot', '<cmd>ObsidianTemplate<cr>', desc = 'Insert [T]emplate' },

    { '<leader>of', '<cmd>ObsidianQuickSwitch<cr>', desc = '[F]ind Note' },
    { '<leader>os', '<cmd>ObsidianSearch<cr>', desc = '[S]earch Notes' },
    { '<leader>od', '<cmd>ObsidianToday<cr>', desc = '[D]aily Note' },

    { '<leader>ol', '<cmd>ObsidianLinks<cr>', desc = 'Show [L]inks' },
    { '<leader>ob', '<cmd>ObsidianBacklinks<cr>', desc = 'Show [B]acklinks' },
    { '<leader>og', '<cmd>ObsidianFollowLink<cr>', desc = '[G]o to Link' },

    { '<leader>oo', '<cmd>ObsidianOpen<cr>', desc = 'Open in [O]bsidian app' },
    { '<leader>or', '<cmd>ObsidianRename<cr>', desc = '[R]ename note' },
    { '<leader>op', '<cmd>ObsidianPasteImg<cr>', desc = '[P]aste image' },
  },
}
