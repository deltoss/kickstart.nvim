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
        -- This uses rest.nvim's parser, which doesn't follow .http standard by JetBrains.
        -- Instead, use Kulala.nvim's parser, which comes with the plugin. See
        --   https://github.com/mistweaverco/kulala.nvim/issues/888#issuecomment-4560915377
        -- 'http',
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
