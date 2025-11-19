return {
  'snacks.nvim', -- only the name of the plugin needs to be specified since it already exists
  ---@type snacks.Config
  opts = {
    gitbrowse = {
      enabled = true,
      url_patterns = {
        ['bitbucket%.org'] = {
          branch = '/src/{branch}',
          file = '/src/{branch}/{file}#lines-{line_start}:{line_end}',
          permalink = '/src/{commit}/{file}#lines-{line_start}:{line_end}',
          commit = '/commits/{commit}',
        },
      },
    },
  },
  keys = {
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
      mode = { 'n', 'v' },
    },
  },
}
