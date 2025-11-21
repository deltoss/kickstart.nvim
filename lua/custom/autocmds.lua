vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    -- Get the directory of the current file
    local file_dir = vim.fn.expand '%:p:h'

    local cmd = string.format('cd %s && git rev-parse --show-toplevel', vim.fn.shellescape(file_dir))
    local root = vim.fn.system(cmd):gsub('\n', '')

    if vim.v.shell_error == 0 then
      vim.cmd('cd ' .. root)
    end
  end,
})
