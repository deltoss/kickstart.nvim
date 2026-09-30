return {
  'deltoss/bruno.nvim',
  main = 'bruno',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'folke/snacks.nvim',
  },
  cmd = {
    'BrunoRun',
    'BrunoEnv',
    'BrunoSearch',
    'BrunoToggleFormat',
  },
  opts = {
    picker = 'snacks',
  },
}
