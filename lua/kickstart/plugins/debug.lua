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
      desc = 'Start/Continue',
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
      '<leader>ba',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Toggle Breakpoint',
    },
    {
      '<leader>bA',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Set Conditional Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<leader>bh',
      function()
        require('dapui').toggle()
      end,
      desc = 'See last session result.',
    },
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'See last session result.',
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
            { id = 'scopes', size = 0.25 },
            'breakpoints',
            'stacks',
            'watches',
          },
          size = 40, -- 40 columns
          position = 'left',
        },
        {
          elements = {
            'repl',
            'console',
          },
          size = 0.25, -- 25% of total lines
          position = 'bottom',
        },
      },
      controls = {
        enabled = true,
        element = 'repl',
        icons = {
          pause = '',
          play = '',
          step_into = '',
          step_over = '',
          step_out = '',
          step_back = '',
          run_last = '↻',
          terminate = '□',
        },
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = 'single', -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
      },
    }

    -- Change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- https://git.ramboe.io/YouTube/neovim-c-the-sane-debugging-setup-nvim-dap-ui
    -- https://emojipedia.org/en/stickers/search?q=circle
    vim.fn.sign_define('DapBreakpoint', {
      text = '🔴',
      texthl = 'DapBreakpointSymbol',
      linehl = 'DapBreakpoint',
      numhl = 'DapBreakpoint',
    })

    vim.fn.sign_define('DapStopped', {
      text = '🟥',
      texthl = 'yellow',
      linehl = 'DapBreakpoint',
      numhl = 'DapBreakpoint',
    })
    vim.fn.sign_define('DapBreakpointRejected', {
      text = '⭕',
      texthl = 'DapStoppedSymbol',
      linehl = 'DapBreakpoint',
      numhl = 'DapBreakpoint',
    })

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
        cwd = function()
          return vim.fn.input('Workspace folder: ', vim.fn.getcwd() .. '/', 'file')
        end,
      },
    }
  end,
}
