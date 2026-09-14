-- Disable auto formatting on save by default
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '*' },
  callback = function()
    vim.b.disable_autoformat = true
  end,
})

-- Enable auto formatting on save for certain file types
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'ps1', 'dosbatch', 'winbatch', 'nu', 'javascript' },
  callback = function()
    vim.b.disable_autoformat = false
  end,
})

vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})
vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})

local deno_roots = { 'deno.json', 'deno.jsonc', 'deno.lock' }

local function web_formatters(bufnr)
  if vim.fs.root(bufnr, deno_roots) then
    return { 'deno_fmt' }
  end
  return { 'biome' }
end

local function format()
  local conform = require 'conform'
  local mode = vim.fn.mode()
  -- These tools format complete documents. Send only selected lines so their
  -- diff cannot include adjacent changes outside the selection.
  if (mode == 'v' or mode == 'V') and vim.tbl_contains({ 'json', 'yaml', 'xml' }, vim.bo.filetype) then
    local bufnr = vim.api.nvim_get_current_buf()
    local first, last = vim.fn.line 'v', vim.fn.line '.'
    first, last = math.min(first, last), math.max(first, last)
    local lines = vim.api.nvim_buf_get_lines(bufnr, first - 1, last, false)
    local err, formatted = conform.format_lines(conform.list_formatters_for_buffer(bufnr), lines, {
      bufnr = bufnr,
      stop_after_first = true,
    })
    if err then
      vim.notify(err.message, vim.log.levels.ERROR)
    elseif formatted and #formatted > 0 and not vim.deep_equal(lines, formatted) then
      vim.api.nvim_buf_set_lines(bufnr, first - 1, last, false, formatted)
    end
  else
    conform.format { async = true, lsp_format = 'fallback' }
  end
end

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      format,
      mode = { 'n', 'x' },
      desc = '[F]ormat buffer or selection',
    },
    {
      '<leader><leader>ofd',
      ':FormatDisable!<CR>',
      mode = '',
      desc = '[D]isable for buffer',
    },
    {
      '<leader><leader>ofD',
      ':FormatDisable<CR>',
      mode = '',
      desc = '[D]isable',
    },
    {
      '<leader><leader>ofe',
      ':FormatEnable<CR>',
      mode = '',
      desc = '[E]nable',
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      -- For list of filetypes, type :echo getcompletion('<BlankOrSearchTerm>', 'filetype')
      cs = { 'csharpier' },
      css = { 'css_beautify' },
      json = { 'jq' },
      jsonc = web_formatters,
      yaml = { 'yamlfmt', 'yq', stop_after_first = true },
      xml = { 'xmlformatter', 'yq_xml', stop_after_first = true },
      toml = { 'taplo' },
      templ = { 'templ' },
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      javascript = web_formatters,
      javascriptreact = web_formatters,
      typescript = web_formatters,
      typescriptreact = web_formatters,
    },
    formatters = {
      deno_fmt = {
        cwd = function(_, ctx)
          return vim.fs.root(ctx.dirname, deno_roots)
        end,
      },
      yq_xml = {
        inherit = 'yq',
        args = { '-p', 'xml', '-o', 'xml', '-P', '-' },
      },
    },
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

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
