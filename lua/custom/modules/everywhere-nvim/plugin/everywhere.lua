if vim.g.loaded_everywhere then
  return
end
vim.g.loaded_everywhere = true

vim.api.nvim_create_user_command("Everywhere", function()
  require("everywhere").pick()
end, { desc = "Open the everywhere.nvim file search picker" })

vim.api.nvim_create_user_command("EverywhereGitRepos", function()
  require("everywhere").git_repos()
end, { desc = "Search for git repositories with everywhere.nvim" })
