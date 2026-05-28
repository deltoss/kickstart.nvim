return {
  'romus204/tree-sitter-manager.nvim',
  dependencies = {}, -- tree-sitter CLI must be installed system-wide
  config = function()
    require('tree-sitter-manager').setup {
      -- list of parsers to install at the start of a neovim session. If set to "all", install all parsers.
      ensure_installed = {
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
      },
      auto_install = true, -- if enabled, install missing parsers when editing a new file
      highlight = true,    -- treesitter highlighting is enabled by default
    }
  end,
}
