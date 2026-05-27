return {
  'phelipetls/jsonpath.nvim',
  ft = 'json',
  dependencies = { 'romus204/tree-sitter-manager.nvim' },
  config = function()
    -- show json path in the winbar
    if vim.fn.exists '+winbar' == 1 then
      vim.opt_local.winbar = "%{%v:lua.require'jsonpath'.get()%}"
    end
  end,
}
