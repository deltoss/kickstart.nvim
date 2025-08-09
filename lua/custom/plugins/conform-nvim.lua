return {
  'stevearc/conform.nvim',
  opts = {
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      -- For list of filetypes, type :echo getcompletion('<BlankOrSearchTerm>', 'filetype')
      csh = { 'csharpier' },
      css = { 'css_beautify' },
      json = { 'jq' },
      yaml = { 'yq' },
      xml = { 'yq' },
      toml = { 'taplo' },
      template = { 'templ' },
      lua = { 'stylua' },
      -- Conform will run multiple formatters sequentially
      python = { 'isort', 'black' },
      -- You can customize some of the format options for the filetype (:help conform.format)
      rust = { 'rustfmt', lsp_format = 'fallback' },
      -- Conform will run the first available formatter
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}
