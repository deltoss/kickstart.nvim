return {
  'snacks.nvim', -- only the name of the plugin needs to be specified since it already exists
  ---@type snacks.Config
  opts = {
    indent = {
      enabled = true,
      indent = {
        enabled = true, -- enable indent guides
        char = '▎',
        hl = {
          'SnacksIndent1',
          'SnacksIndent2',
          'SnacksIndent3',
          'SnacksIndent4',
          'SnacksIndent5',
          'SnacksIndent6',
          'SnacksIndent7',
          'SnacksIndent8',
        },
      },
      scope = {
        char = '▎',
        only_current = true,
      },
    },
  },
}
