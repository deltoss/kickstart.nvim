return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = function()
    vim.opt.showmode = false -- Hide the "-- INSERT --" text
    vim.opt.ruler = false -- Hide the line:col in the corner
    vim.opt.cmdheight = 0 -- Reclaims the last row entirely. Only show when needed
  end,
  opts = function()
    -- Deferred until lualine actually loads, so this doesn't force noice.nvim
    -- and easy-dotnet.nvim to load early, ahead of their own lazy triggers.
    local job_indicator = { require('easy-dotnet.ui-modules.jobs').lualine }

    return {
      options = {
        theme = 'ayu_light',
      },
      sections = {
        lualine_a = { 'mode', job_indicator },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          'filename',
          {
            function()
              return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
            end,
            icon = '',
          },
        },
        lualine_x = {
          { require('noice').api.status.command.get, cond = require('noice').api.status.command.has },
          { require('noice').api.status.mode.get, cond = require('noice').api.status.mode.has },
          { require('noice').api.status.search.get, cond = require('noice').api.status.search.has },
        },
        lualine_y = {
          'bo:buftype',
          'encoding',
          { 'filetype', colored = true },
          { 'fileformat', symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR' } },
        },
        lualine_z = { 'progress', 'location' },
      },
    }
  end,
}
