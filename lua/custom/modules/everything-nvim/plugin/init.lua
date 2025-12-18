vim.api.nvim_create_user_command('EverythingGitRepo', function()
  require('everything').gitRepo()
end, {})
