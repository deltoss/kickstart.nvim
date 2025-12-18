local M = {}

M.check = function()
  vim.health.start 'Everything search (es) report'
  if vim.fn.executable 'es' == 0 then
    vim.health.error 'Everything search (es) not found on path'
    return
  end
  vim.health.ok 'Everything search (es) found on path'

  vim.health.start 'snacks.nvim dependency check'
  local ok, snacks = pcall(require, 'snacks')
  if not ok then
    vim.health.error 'snacks.nvim is not installed'
    return
  end
  vim.health.ok 'snacks.nvim is installed'
end

return M
