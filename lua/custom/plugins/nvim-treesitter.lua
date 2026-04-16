return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  branch = 'main',
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  config = function()
    local ts = require 'nvim-treesitter'
    local languages = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'c_sharp',
      'powershell',
      'nu',
      'regex',
      'typescript',
      'sql',
      'javascript',
      'http',
      'dockerfile',
      'templ',
      'gitcommit',
      'git_rebase',
      'gitignore',
      'xml',
    }

    -- NOTE: If languages fail to install or compilation hangs,
    -- ensure 'tree-sitter-cli' is installed (e.g., :MasonInstall tree-sitter-cli).
    -- If the issue persists, run :checkhealth nvim-treesitter to diagnose.

    -- Use :TSInstall for manual install languages
    ts.install(languages)

    -- group so it only fires once at startup
    local group = vim.api.nvim_create_augroup('ConfigureTreesitterFeatures', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      pattern = languages,
      callback = function(args)
        -- Enable highlighting for the buffer
        vim.treesitter.start(args.buf)

        -- Enable smarter indentation for the buffer
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        -- Use treesitter to determine fold ranges
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- Tell Neovim to fold using the foldexpr above
        vim.wo[0][0].foldmethod = 'expr'
        -- Neovim defaults to closing all folds, set fold level to 99 to avoid this
        vim.wo[0][0].foldlevel = 99
      end,
    })
  end,
}
