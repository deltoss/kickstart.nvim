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
    }

    ts.setup {}

    -- NOTE: If languages fail to install or compilation hangs,
    -- ensure 'tree-sitter-cli' is installed (e.g., :MasonInstall tree-sitter-cli).
    -- If the issue persists, run :checkhealth nvim-treesitter to diagnose.

    -- Use :TSInstall for manual install languages
    ts.install(languages)
  end,
}
