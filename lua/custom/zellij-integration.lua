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

if vim.env.ZELLIJ then
  -- Pane title via OSC 2. A CLI-set pane name overrides it, so clear any.
  vim.fn.jobstart({ 'zellij', 'action', 'undo-rename-pane' }, { detach = true })
  vim.o.title = true
  vim.o.titlestring = [[👾 %{bufname() == '' ? 'nvim' : 'nvim ' .. expand('%:p:~')}]]

  local last_tail = nil

  -- Tab rename has no OSC equivalent, needs the CLI
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufFilePost' }, {
    group = vim.api.nvim_create_augroup('ZellijTabName', { clear = true }),
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      if vim.bo[buf].buftype ~= '' then
        return
      end

      local file = vim.api.nvim_buf_get_name(buf)
      local tail = file == '' and 'nvim' or vim.fn.fnamemodify(file, ':t')
      if tail == last_tail then
        return
      end
      last_tail = tail

      vim.fn.jobstart({ 'zellij', 'action', 'rename-tab', '👾 ' .. tail }, { detach = true })
    end,
  })
end
