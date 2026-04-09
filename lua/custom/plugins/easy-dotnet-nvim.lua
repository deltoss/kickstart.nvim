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
    server = {
      ---@type nil | "Off" | "Critical" | "Error" | "Warning" | "Information" | "Verbose" | "All"
      -- To see logs, run:
      --   :Dotnet _server logdump
      log_level = 'Verbose',
    },
  },
  init = function()
    vim.filetype.add {
      extension = {
        sln = 'solution',
        slnx = 'solution',
        slnf = 'slnfilter',
        csproj = 'csproj',
      },
    }
  end,
  keys = {
    { '<localleader><localleader>', '<cmd>Dotnet<cr>', desc = 'List Dotnet Commands', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>b', '<cmd>Dotnet build quickfix<cr>', desc = '[B]uild', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>B', '<cmd>Dotnet build solution quickfix<cr>', desc = '[B]uild Solution', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>r', '<cmd>Dotnet clean<cr><cmd>Dotnet build quickfix<cr>', desc = '[R]ebuild', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>R', '<cmd>Dotnet restore<cr>', desc = '[R]estore', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>D', '<cmd>Dotnet run profile<cr>', desc = 'Run without [D]ebugging', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>d', '<cmd>Dotnet debug profile<cr>', desc = '[D]ebug', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
  },
}
