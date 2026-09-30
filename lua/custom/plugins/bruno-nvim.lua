return {
  'deltoss/bruno.nvim',
  main = 'bruno',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'folke/snacks.nvim',
  },
  cmd = {
    'BrunoRun',
    'BrunoEnv',
    'BrunoSearch',
    'BrunoToggleFormat',
  },
  keys = {
    { '<localleader>s', '<cmd>update<cr><cmd>BrunoRun<cr>', ft = { 'bruno' }, desc = 'Send request' },
    { '<localleader>e', '<cmd>BrunoEnv<cr>', ft = { 'bruno' }, desc = 'Select environment' },
    { '<localleader>f', '<cmd>BrunoSearch<cr>', ft = { 'bruno' }, desc = 'Search requests' },
    { '<localleader>S', '<cmd>BrunoToggleFormat<cr>', ft = { 'bruno' }, desc = 'Toggle response formatting' },
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('BrunoKeymaps', { clear = true }),
      pattern = { 'markdown', 'json' },
      callback = function(event)
        local name = vim.api.nvim_buf_get_name(event.buf)
        if vim.bo[event.buf].buftype == 'nofile' and vim.fn.fnamemodify(name, ':t') == 'Bruno Output' then
          vim.keymap.set('n', '<localleader>S', '<cmd>BrunoToggleFormat<cr>', {
            buffer = event.buf,
            desc = 'Toggle response formatting',
          })
        end
      end,
    })
  end,
  opts = {
    picker = 'snacks',
  },
}
