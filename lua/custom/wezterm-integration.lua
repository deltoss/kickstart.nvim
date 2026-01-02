local keymap = vim.keymap.set

keymap('n', '<leader>w<Up>', function()
  local cwd = vim.fn.getcwd()
  vim.fn.jobstart({ 'wezterm', 'cli', 'split-pane', '--top', '--percent', '30', '--cwd', cwd }, { detach = true })
end, { desc = 'Split Pane Top' })

keymap('n', '<leader>w<Right>', function()
  local cwd = vim.fn.getcwd()
  vim.fn.jobstart({ 'wezterm', 'cli', 'split-pane', '--right', '--percent', '30', '--cwd', cwd }, { detach = true })
end, { desc = 'Split Pane Right' })

keymap('n', '<leader>w<Down>', function()
  local cwd = vim.fn.getcwd()
  vim.fn.jobstart({ 'wezterm', 'cli', 'split-pane', '--bottom', '--percent', '30', '--cwd', cwd }, { detach = true })
end, { desc = 'Split Pane Down' })

keymap('n', '<leader>w<Left>', function()
  local cwd = vim.fn.getcwd()
  vim.fn.jobstart({ 'wezterm', 'cli', 'split-pane', '--left', '--percent', '30', '--cwd', cwd }, { detach = true })
end, { desc = 'Split Pane Left' })

vim.api.nvim_create_autocmd({ 'BufEnter', 'winenter', 'dirchanged' }, {
  callback = function(event)
    local title = '🚀 nvim'
    if event.file ~= '' then
      local file_path = event.file

      -- Check if path ends with a dot (indicating a directory)
      if string.sub(file_path, -1) == '/' then
        -- Extract parent directory name
        local parent_path = string.sub(file_path, 1, -2) -- Remove "/"
        title = string.format(title .. ' → %s', vim.fs.basename(parent_path))
      else
        title = string.format(title .. ' → %s', vim.fs.basename(file_path))
      end
    end
    vim.fn.system { 'wezterm', 'cli', 'set-tab-title', title }
  end,
})

vim.api.nvim_create_autocmd({ 'VimLeave' }, {
  callback = function()
    -- Setting title to empty string causes wezterm to revert to its
    -- default behavior of setting the tab title automatically
    vim.fn.system { 'wezterm', 'cli', 'set-tab-title', '' }
  end,
})
