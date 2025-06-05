return {
  'ahmedkhalf/project.nvim',
  event = 'VeryLazy',
  config = function()
    require('project_nvim').setup {
      -- Optional settings:
      detection_methods = { 'lsp', 'pattern' },
      patterns = { '.git', 'Makefile', '.svn', '*.sln', 'package.json' },
    }

    -- Load Telescope extension for switching
    require('telescope').load_extension 'projects'
  end,
  keys = {
    {
      '<leader>sp',
      function()
        require('telescope').extensions.projects.projects()
      end,
      desc = '[S]earch [P]roject',
    },
  },
}
