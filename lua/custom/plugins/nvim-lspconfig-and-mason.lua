return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    -- Mason must be loaded before its dependents so we need to set it up here.
    -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
    {
      'mason-org/mason.nvim',
      ---@module 'mason.settings'
      ---@type MasonSettings
      ---@diagnostic disable-next-line: missing-fields
      opts = {},
    },
    -- Maps LSP server names between nvim-lspconfig and Mason package names.
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },

    -- Autocompletions for popular json configs
    'b0o/schemastore.nvim',
  },
  config = function()
    vim.keymap.set('n', '<leader>o', function()
      require('aerial').toggle()
    end, { desc = '[O]utline' })

    -- Brief aside: **What is LSP?**
    --
    -- LSP is an initialism you've probably heard, but might not understand what it is.
    --
    -- LSP stands for Language Server Protocol. It's a protocol that helps editors
    -- and language tooling communicate in a standardized fashion.
    --
    -- In general, you have a "server" which is some tool built to understand a particular
    -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
    -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
    -- processes that communicate with some "client" - in this case, Neovim!
    --
    -- LSP provides Neovim with features like:
    --  - Go to definition
    --  - Find references
    --  - Autocompletion
    --  - Symbol Search
    --  - and more!
    --
    -- Thus, Language Servers are external tools that must be installed separately from
    -- Neovim. This is where `mason` and related plugins come into play.
    --
    -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
    -- and elegantly composed help section, `:help lsp-vs-treesitter`

    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('<leader>rr', vim.lsp.buf.rename, '[R]ename')
        map('k', vim.lsp.buf.hover, 'Pee[k] Documentation')
        map('ga', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
        map('gr', function() Snacks.picker.lsp_references() end, '[G]oto [R]eferences')
        map('gI', function() Snacks.picker.lsp_incoming_calls() end, '[G]oto [I]ncoming')
        map('gO', function() Snacks.picker.lsp_outgoing_calls() end, '[G]oto [O]utgoing')

        map(']d', function() vim.diagnostic.jump { count = 1, float = true } end, 'Diagnostic')
        map('[d', function() vim.diagnostic.jump { count = -1, float = true } end, 'Diagnostic')
        map(']e', function() vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR, float = true } end, 'Error')
        map('[e', function() vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR, float = true } end, 'Error')

        map('gi', function() Snacks.picker.lsp_implementations() end, '[G]oto [I]mplementation')
        map('gd', function() Snacks.picker.lsp_definitions() end, '[G]oto [D]efinition')
        map('gD', function() Snacks.picker.lsp_type_definitions() end, '[G]oto [T]ype [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>ss', function()
          Snacks.picker.lsp_symbols()
        end, 'Document [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map('<leader>sS', function()
          Snacks.picker.lsp_workspace_symbols()
        end, 'Workspace [S]ymbols')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('gT', function()
          Snacks.picker.lsp_type_definitions()
        end, '[G]oto [T]ype Definition')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/documentHighlight', event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client:supports_method('textDocument/inlayHint', event.buf) then
          map('<leader><leader>oh', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[O]ption Toggle Inlay [H]ints')
        end
      end,
    })

    -- Diagnostic Config
    -- See :help vim.diagnostic.Opts
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    }

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --  See `:help lsp-config` for information about keys and how to configure
    ---@type table<string, vim.lsp.Config>
    local servers = {
      clangd = {},
      -- gopls = {},
      -- pyright = {},
      -- rust_analyzer = {},

      stylua = {}, -- Used to format Lua code
      yamlls = {
        settings = {
          yaml = {
            -- Disable yamlls built-in schema store; use SchemaStore.nvim instead.
            schemaStore = {
              enable = false,
              url = '',
            },
            schemas = require('schemastore').yaml.schemas(),
          },
        },
      },
      powershell_es = {},
      templ = {},
      taplo = {},

      jsonls = {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      },

      -- Special Lua Config, as recommended by neovim help docs
      lua_ls = {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT',
              path = { 'lua/?.lua', 'lua/?/init.lua' },
            },
            workspace = {
              checkThirdParty = false,
              -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
              --  See https://github.com/neovim/nvim-lspconfig/issues/3189
              library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                '${3rd}/luv/library',
                '${3rd}/busted/library',
              }),
            },
          })
        end,
        settings = {
          Lua = {},
        },
      },
    }

    -- Ensure the servers and tools above are installed
    --
    -- To check the current status of installed tools and/or manually install
    -- other tools, you can run
    --    :Mason
    --
    -- You can press `g?` for help in this menu.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      -- Add only formatters, debuggers, or CLI tools
      -- For LSPs, add it to servers above, which needs special handling with Neovim's LSP
      'isort',
      'jq',
      'js-debug-adapter',
      'stylua',
      'xmlformatter',
      'yamlfmt',
      'yq',
      'biome', -- Linter/prettier for Javascript/Typescript
    })
    -- Only include if dotnet is installed
    if vim.fn.executable 'dotnet' == 1 then
      vim.list_extend(ensure_installed, {
        'csharpier',
        'netcoredbg',
      })
    end
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
}
