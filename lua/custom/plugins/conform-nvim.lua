return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      -- For list of filetypes, type :echo getcompletion('<BlankOrSearchTerm>', 'filetype')
      csh = { 'csharpier' },
      css = { 'css_beautify' },
      json = { 'jq' },
      yaml = { 'yamlfmt', 'yq', stop_after_first = true },
      xml = { 'xmlformatter', 'yq', stop_after_first = true },
      toml = { 'taplo' },
      template = { 'templ' },
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
  },
}
