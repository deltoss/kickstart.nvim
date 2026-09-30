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
    { '<leader>hh', '<cmd>BrunoSearch<cr>', mode = 'n', desc = 'Search Bruno requests' },
    { '<leader>hs', '<cmd>BrunoSearch<cr>', mode = 'n', desc = 'Search Bruno requests' },
    { '<leader>sB', '<cmd>BrunoSearch<cr>', mode = 'n', desc = 'Search Bruno requests' },
    { '<leader>hr', '<cmd>BrunoRun<cr>', mode = 'n', desc = 'Run Bruno request' },
    { '<leader>hf', '<cmd>BrunoToggleFormat<cr>', mode = 'n', desc = 'Toggle Bruno response formatting' },
    { '<leader>he', '<cmd>BrunoEnv<cr>', mode = 'n', desc = 'Select Bruno environment' },
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
    collection_paths = {
      { name = 'Main', path = vim.fn.expand '~/.bruno/Collections/' },
    },
    picker = 'snacks',
    show_formatted_output = true,
    suppress_formatting_errors = false,
  },
}
