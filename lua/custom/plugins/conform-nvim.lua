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

-- Helper to run external formatter tools
local function run_formatter(cmd, tool)
  if vim.fn.executable(tool) == 0 then
    vim.notify(tool .. ' is not installed or not in PATH', vim.log.levels.ERROR)
    return
  end

  if mode == 'v' or mode == 'V' then
    vim.cmd("'<,'>!" .. cmd)
  else
    vim.cmd('%!' .. cmd)
  end
end

local function format()
  local ft = vim.bo.filetype
  local filename = vim.fn.expand '%:t'
  local mode = vim.fn.mode()

  local is_xml = ft == 'xml' or filename:match '%.xml$'
  local is_json = ft == 'json' or filename:match '%.json$'
  local is_yaml = ft == 'yaml' or ft == 'yml' or filename:match '%.ya?ml$'

  if is_xml then
    run_formatter('yq -p xml -o xml', 'yq')
  elseif is_json then
    run_formatter('jq .', 'jq')
  elseif is_yaml then
    run_formatter('yq -p yaml -o yaml', 'yq')
  else
    require('conform').format { async = true, lsp_format = 'fallback' }
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
      mode = '',
      desc = '[F]ormat buffer',
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
