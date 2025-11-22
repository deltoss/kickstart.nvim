vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    -- Get the directory of the current file
    local file_dir = vim.fn.expand '%:p:h'

    local cmd = string.format('cd %s && git rev-parse --show-toplevel', vim.fn.shellescape(file_dir))
    local git_root = vim.fn.system(cmd):gsub('\n', '')

    if vim.v.shell_error == 0 then
      vim.cmd('cd ' .. vim.fn.fnameescape(git_root))
    else
      vim.cmd('cd ' .. vim.fn.fnameescape(file_dir))
    end
  end,
})

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
