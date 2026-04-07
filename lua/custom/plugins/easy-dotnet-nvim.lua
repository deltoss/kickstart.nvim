return {
  'GustavEikaas/easy-dotnet.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap', 'folke/snacks.nvim' },
  opts = {
    -- Integration with Snacks has a bug:
    --   Unhandled async error:
    --   ...ata/lazy/easy-dotnet.nvim/lua/easy-dotnet/rpc/server.lua:79: E5560: Vimscript function "jobstart" must not be called in a fast event context
    -- picker = 'snacks',
    picker = 'telescope',
    diagnostics = {
      default_severity = 'warning', -- "error" or "warning"
      setqflist = true,
    },
  },
  keys = {
    { '<leader><leader>nn', '<cmd>Dotnet<cr>', desc = 'List Dot[N]et Commands' },
    { '<leader><leader>nbb', '<cmd>Dotnet build quickfix<cr>', desc = '[B]uild' },
    { '<leader><leader>nbB', '<cmd>Dotnet build solution quickfix<cr>', desc = '[B]uild Solution' },
    { '<leader><leader>nbr', '<cmd>Dotnet clean<cr><cmd>Dotnet build quickfix<cr>', desc = '[R]ebuild' },
    { '<leader><leader>nbR', '<cmd>Dotnet restore<cr>', desc = '[R]estore' },
    { '<leader><leader>nrr', '<cmd>Dotnet run profile<cr>', desc = '[R]un' },
    { '<leader><leader>nrd', '<cmd>Dotnet debug profile<cr>', desc = '[D]ebug' },
  },
}
