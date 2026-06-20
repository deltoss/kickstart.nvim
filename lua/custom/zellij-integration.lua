local keymap = vim.keymap.set

keymap('n', '<leader>w<Up>', function()
  local cwd = vim.fn.getcwd()
  vim.fn.jobstart({ 'zellij', 'action', 'new-pane', '--direction', 'up', '--cwd', cwd }, { detach = true })
end, { desc = 'Split Pane Top' })

keymap('n', '<leader>w<Right>', function()
  local cwd = vim.fn.getcwd()
  vim.fn.jobstart({ 'zellij', 'action', 'new-pane', '--direction', 'right', '--cwd', cwd }, { detach = true })
end, { desc = 'Split Pane Right' })

keymap('n', '<leader>w<Down>', function()
  local cwd = vim.fn.getcwd()
  vim.fn.jobstart({ 'zellij', 'action', 'new-pane', '--direction', 'down', '--cwd', cwd }, { detach = true })
end, { desc = 'Split Pane Down' })

keymap('n', '<leader>w<Left>', function()
  local cwd = vim.fn.getcwd()
  vim.fn.jobstart({ 'zellij', 'action', 'new-pane', '--direction', 'left', '--cwd', cwd }, { detach = true })
end, { desc = 'Split Pane Left' })
