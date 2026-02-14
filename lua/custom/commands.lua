local current_git_root = nil

local function get_git_root(dir)
  local root = vim.fn.systemlist('git -C "' .. dir .. '" rev-parse --show-toplevel')[1]
  if vim.v.shell_error == 0 and root ~= '' then
    return root
  end
  return nil
end

local function set_cwd_to_git_root()
  -- Get the directory of the current file
  local file_dir = vim.fn.expand '%:p:h'
  local git_root = get_git_root(file_dir)

  if git_root then
    -- Only change directory if we're entering a different repo
    if git_root ~= current_git_root then
      current_git_root = git_root
      vim.cmd('cd ' .. vim.fn.fnameescape(git_root))
      print('cd → ' .. git_root)
    end
  else
    -- Not in a git repo
    current_git_root = nil
  end
end

vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(event)
    local win = vim.api.nvim_get_current_win()
    local config = vim.api.nvim_win_get_config(win)
    local buftype = vim.bo[event.buf].buftype

    -- Only for main buffers
    if config.relative == '' and buftype == '' and vim.bo[event.buf].buflisted then
      set_cwd_to_git_root()
    end
  end,
})

-- User command to manually set cwd to git root
vim.api.nvim_create_user_command('CDgit', function()
  local file_dir = vim.fn.expand '%:p:h'
  local git_root = get_git_root(file_dir)

  if git_root then
    current_git_root = git_root
    vim.cmd('cd ' .. vim.fn.fnameescape(git_root))
    print('cd → ' .. git_root)
  else
    print 'Not in a git repository'
  end
end, {})

vim.keymap.set('n', '<leader>cg', '<cmd>CDgit<CR>', { desc = '[G]it root' })

vim.api.nvim_create_user_command('CD', function()
  local path = vim.fn.expand '%:p:h'
  if path == '' then
    return
  end
  vim.cmd('silent cd ' .. vim.fn.fnameescape(path))
  vim.notify('cd → ' .. path)
end, {})

vim.keymap.set('n', '<leader>~', '<cmd>CD<CR>', { desc = 'Change CWD to Current' })
vim.keymap.set('n', '<leader>cd', '<cmd>CD<CR>', { desc = 'Current [D]irectory' })

vim.api.nvim_create_user_command('CDlsp', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }
  if #clients == 0 then
    vim.notify('No active LSP clients for this buffer', vim.log.levels.WARN)
    return
  end
  local root = clients[1].config.root_dir
  if root and root ~= '' then
    vim.cmd('silent cd ' .. root)
    vim.notify('cd → ' .. root)
  else
    vim.notify('LSP did not provide a root_dir', vim.log.levels.WARN)
  end
end, {})

vim.keymap.set('n', '<leader>cl', '<cmd>CDlsp<CR>', { desc = '[L]sp Root Directory' })

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function(event)
    local win = vim.api.nvim_get_current_win()
    local config = vim.api.nvim_win_get_config(win)
    local buftype = vim.bo[event.buf].buftype

    -- Check if it's a floating window AND a temporary/special buffer
    -- Otherwise, it'd also apply to split windows too, which we don't want
    if config.relative ~= '' and (buftype == 'nofile' or buftype == 'help' or buftype == 'quickfix') then
      vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
      vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    end
  end,
})

-- See https://github.com/neovim/neovim/issues/8587
vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
  group = vim.api.nvim_create_augroup('delete_shada_temp', { clear = true }),
  pattern = { '*' },
  callback = function()
    local status = 0
    for _, f in ipairs(vim.fn.globpath(vim.fn.stdpath 'data' .. '/shada', '*tmp*', false, true)) do
      if vim.tbl_isempty(vim.fn.readfile(f)) then
        status = status + vim.fn.delete(f)
      end
    end
    if status ~= 0 then
      vim.notify('Could not delete empty temporary ShaDa files.', vim.log.levels.ERROR)
      vim.fn.getchar()
    end
  end,
  desc = 'Delete empty temp ShaDa files',
})
