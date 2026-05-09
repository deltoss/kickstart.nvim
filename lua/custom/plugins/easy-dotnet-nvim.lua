local function pick_sln_file(callback)
  Snacks.picker.files {
    prompt = 'Select solution file',
    cmd = 'fd',
    args = { '--extension', 'sln', '--extension', 'slnx' },
    confirm = function(picker, item)
      picker:close()
      if item then
        callback(item.file)
      end
    end,
  }
end

return {
  'GustavEikaas/easy-dotnet.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap', 'folke/snacks.nvim' },
  config = function()
    local dotnet = require 'easy-dotnet'
    dotnet.setup {
      picker = 'snacks',
      lsp = {
        preload_roslyn = false, -- Don't start loading roslyn until a relevant buffer is opened
      },
      diagnostics = {
        default_severity = 'warning', -- "error" or "warning"
        setqflist = true,
      },
      server = {
        -- Saves logs to /logs directory of your project
        --   log_level = 'Verbose',
        -- To see other logs, try:
        --   :Dotnet _server logdump
        -- For .NET Framework support. See https://github.com/GustavEikaas/easy-dotnet.nvim?tab=readme-ov-file#net-framework
        -- You'll also need to run:
        --   choco install nuget.commandline
        -- Only enable below if you use .NET Framework
        -- This breaks debugging capabilities for modern
        -- .NET projects
        --   use_visual_studio = true,
      },
    }
  end,
  keys = {
    { '<localleader><localleader>', '<cmd>Dotnet<cr>', desc = 'List Dotnet Commands', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },

    { '<localleader>b', '<cmd>Dotnet build quickfix<cr>', desc = '[B]uild', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>B', '<cmd>Dotnet build solution quickfix<cr>', desc = '[B]uild Solution', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>c', '<cmd>Dotnet clean<cr>', desc = '[C]lean', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>r', '<cmd>Dotnet restore<cr>', desc = '[R]estore', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },

    { '<localleader>p', '<cmd>Dotnet project view<cr>', desc = '[P]roject View', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>Pa', '<cmd>Dotnet add package<cr>', desc = '[A]dd', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>PA', '<cmd>Dotnet add package prerelease<cr>', desc = '[A]dd Prerelease', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>Pd', '<cmd>Dotnet add remove<cr>', desc = '[D]elete', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },

    { '<localleader>D', '<cmd>Dotnet run profile<cr>', desc = 'Run without [D]ebugging', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>d', '<cmd>Dotnet debug profile<cr>', desc = '[D]ebug', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader><down>', '<cmd>DapContinue<cr>', desc = 'Continue', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>o', '<cmd>Dotnet terminal toggle<cr>', desc = '[O]utput', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>O', '<cmd>Dotnet outdated<cr>', desc = '[O]utdated', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },

    { '<localleader>n', '<cmd>Dotnet createfile<cr>', desc = '[N]ew File', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>N', '<cmd>Dotnet new<cr>', desc = '[N]ew Project', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },

    { '<localleader>w', '<cmd>Dotnet watch<cr>', desc = '[W]atch', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },

    {
      '<localleader>ss',
      function()
        pick_sln_file(function(path)
          require('easy-dotnet').solution_select(path)
        end)
      end,
      desc = '[A]dd',
      ft = { 'cs', 'solution', 'slnfilter', 'csproj' },
    },
    { '<localleader>sa', '<cmd>Dotnet solution add<cr>', desc = '[A]dd', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>sd', '<cmd>Dotnet solution remove<cr>', desc = '[D]elete/Remove', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>S', '<cmd>Dotnet secrets<cr>', desc = 'User [S]ecrets', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },

    { '<localleader>ii', '<cmd>Dotnet diagnostic<cr>', desc = '[I]nformation', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    { '<localleader>ie', '<cmd>Dotnet diagnostic errors<cr>', desc = '[I]nformation [E]rrors', ft = { 'cs', 'solution', 'slnfilter', 'csproj' } },
    {
      '<localleader>iw',
      '<cmd>Dotnet diagnostic warnings<cr>',
      desc = '[I]nformation [W]arnings',
      ft = { 'cs', 'solution', 'slnfilter', 'csproj' },
    },
  },
}
