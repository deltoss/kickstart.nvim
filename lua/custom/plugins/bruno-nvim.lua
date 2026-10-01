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
    { '<leader>sB', '<cmd>BrunoSearch<cr>', mode = 'n', desc = 'Search Bruno requests' },
    { '<localleader>s', '<cmd>update<cr><cmd>BrunoRun<cr>', ft = { 'bruno' }, desc = 'Send request' },
    { '<localleader>e', '<cmd>BrunoEnv<cr>', ft = { 'bruno' }, desc = 'Select environment' },
    { '<localleader>f', '<cmd>BrunoSearch<cr>', ft = { 'bruno' }, desc = 'Search requests' },
    { '<localleader>S', '<cmd>BrunoToggleFormat<cr>', ft = { 'bruno' }, desc = 'Toggle response formatting' },
  },
  init = function(plugin)
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('BrunoKeymaps', { clear = true }),
      pattern = { 'markdown', 'json', 'yaml' },
      callback = function(event)
        local name = vim.fs.normalize(vim.api.nvim_buf_get_name(event.buf))
        if vim.bo[event.buf].buftype == 'nofile' and vim.fn.fnamemodify(name, ':t') == 'Bruno Output' then
          vim.keymap.set('n', '<localleader>S', '<cmd>BrunoToggleFormat<cr>', {
            buffer = event.buf,
            desc = 'Toggle response formatting',
          })
        elseif event.match == 'yaml' then
          local filename = vim.fn.fnamemodify(name, ':t')
          if not name:match('%.yml$') or filename == 'folder.yml' or filename == 'opencollection.yml' then
            return
          end
          local root = vim.fs.root(event.buf, 'opencollection.yml')
          if not root or name:find(root:gsub('/+$', '') .. '/environments/', 1, true) == 1 then
            return
          end
          for _, key in ipairs(plugin.keys) do
            if key.ft then
              vim.keymap.set('n', key[1], key[2], { buffer = event.buf, desc = key.desc })
            end
          end
        end
      end,
    })
  end,
  opts = {
    collection_paths = {
      { name = 'Main', path = vim.fn.expand '~/HTTP/Bruno/' },
      { name = 'Legacy', path = vim.fn.expand '~/.bruno/Collections/' },
    },
    picker = 'snacks',
    show_formatted_output = true,
    suppress_formatting_errors = false,
  },
}
