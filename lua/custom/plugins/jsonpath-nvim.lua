return {
  'phelipetls/jsonpath.nvim',
  ft = 'json',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    -- show json path in the winbar
    if vim.fn.exists '+winbar' == 1 then
      vim.opt_local.winbar = "%{%v:lua.require'jsonpath'.get()%}"
    end
  end,
}
