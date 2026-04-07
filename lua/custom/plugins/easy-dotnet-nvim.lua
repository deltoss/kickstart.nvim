return {
  'GustavEikaas/easy-dotnet.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap', 'folke/snacks.nvim' },
  opts = {
    -- Integration with Snacks has a bug:
    --   Unhandled async error:
    --   ...ata/lazy/easy-dotnet.nvim/lua/easy-dotnet/rpc/server.lua:79: E5560: Vimscript function "jobstart" must not be called in a fast event context
    -- picker = 'snacks',
    picker = 'telescope',
  },
}
