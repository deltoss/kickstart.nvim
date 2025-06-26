return {
  'ahmedkhalf/project.nvim',
  lazy = false,
  config = function()
    require('project_nvim').setup {
      patterns = { '.git', 'Makefile', '.svn', '*.sln', 'package.json', 'readme.md' },
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
