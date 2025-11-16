return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- For various utilities to debug with dotnet
    -- E.g. Finds the dll for dotnet debugging automatically
    'ramboe/ramboe-dotnet-utils',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Restores breakpoints on load
    {
      'Weissle/persistent-breakpoints.nvim',
      config = function()
        require('persistent-breakpoints').setup {
          save_dir = vim.fn.stdpath 'data' .. '/breakpoints',
          load_breakpoints_event = { 'BufReadPost' },
        }
      end,
    },
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<C-A-Up>',
      function()
        require('dap').continue()
      end,
      desc = 'Start/Continue',
    },
    {
      '<leader>bs',
      function()
        require('dap').continue()
      end,
      desc = '[S]tart/Continue',
    },
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Start/Continue',
    },
    {
      '<C-A-Right>',
      function()
        require('dap').step_into()
      end,
      desc = 'Step Into',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Step Into',
    },
    {
      '<leader>bq',
      function()
        require('dap').terminate()
      end,
      desc = '[Q]uit',
    },
    {
      '<C-A-Down>',
      function()
        require('dap').step_over()
      end,
      desc = 'Step Over',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Step Over',
    },
    {
      '<C-A-Left>',
      function()
        require('dap').step_out()
      end,
      desc = 'Step Out',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Step Out',
    },
    {
      '<leader>bf',
      function()
        require('dapui').float_element()
      end,
      desc = 'Show [F]loating DAP Element',
    },
    {
      '<leader>bb',
      function()
        require('dapui').float_element('breakpoints', { enter = true })
      end,
      desc = 'Show [B]reakpoints',
    },
    {
      '<leader>bc',
      function()
        require('dapui').float_element('stacks', { enter = true })
      end,
      desc = 'Show [C]all Hierarchy',
    },
    -- Commented out the below so persistent-breakpoints.nvim can handle these keymaps
    -- {
    --   '<leader>ba',
    --   function()
    --     require('dap').toggle_breakpoint()
    --   end,
    --   desc = '[A]dd/Toggle Breakpoint',
    -- },
    -- {
    --   '<leader>bA',
    --   function()
    --     require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    --   end,
    --   desc = '[A]dd Conditional Breakpoint',
    -- },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<leader>bl',
      function()
        require('dapui').toggle()
      end,
      desc = 'See [L]ast Session Result',
    },
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'See Last Session Result',
    },
    {
      '<leader>bk',
      function()
        require('dapui').eval(nil, { enter = true })
      end,
      mode = { 'n', 'v' },
      desc = 'Quic[k]watch',
    },
    {
      '<leader>K',
      function()
        require('dapui').eval(nil, { enter = true })
      end,
      mode = { 'n', 'v' },
      desc = 'Quic[k]watch',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- See:
        --   https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
        'js',
        'coreclr',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    -- Based on:
    --   https://aaronbos.dev/posts/debugging-csharp-neovim-nvim-dap
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
      },
      -- Expand lines larger than the window
      -- Requires >= 0.7
      expand_lines = vim.fn.has 'nvim-0.7' == 1,
      controls = { enabled = false }, -- no extra play/step buttons
      -- Layouts define sections of the screen to place windows.
      -- The position can be "left", "right", "top" or "bottom".
      -- The size specifies the height/width depending on position. It can be an Int
      -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
      -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
      -- Elements are the elements shown in the layout (in order).
      -- Layouts are opened in order so that earlier layouts take priority in window sizing.
      layouts = {
        {
          elements = {
            -- Elements can be strings or table with id and size keys.
            'repl',
            'watches',
          },
          size = 0.35, -- % of height
          position = 'bottom',
        },
        {
          elements = {
            'scopes',
          },
          size = 45, -- Number of columns
          position = 'right',
        },
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = 'rounded', -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = 60, -- Can be integer or nil.
        max_value_lines = 200, -- Can be integer or nil.
      },
    }
    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '🔴', BreakpointCondition = '⭕', BreakpointRejected = '⚪', LogPoint = '🔶', Stopped = '🟥' }
      or { Breakpoint = '🔴', BreakpointCondition = '⭕', BreakpointRejected = '⚪', LogPoint = '🔶', Stopped = '🟥' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    local mason_path = vim.fn.stdpath 'data' .. '/mason/packages/netcoredbg/netcoredbg/netcoredbg'

    local netcoredbg_adapter = {
      type = 'executable',
      command = mason_path,
      args = { '--interpreter=vscode' },
    }

    dap.adapters.netcoredbg = netcoredbg_adapter -- needed for normal debugging
    dap.adapters.coreclr = netcoredbg_adapter -- needed for unit test debugging

    dap.configurations.cs = {
      {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = function()
          return require('dap-dll-autopicker').build_dll_path()
        end,
        justMyCode = false,
        stopAtEntry = false,
        env = {
          ASPNETCORE_ENVIRONMENT = function()
            return vim.fn.input('ASPNETCORE_ENVIRONMENT: ', 'Development')
          end,
          ASPNETCORE_URLS = function()
            return vim.fn.input('ASPNETCORE_URLS: ', 'http://localhost:5050')
          end,
        },
      },
    }
  end,
}
