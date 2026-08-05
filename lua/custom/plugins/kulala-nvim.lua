return {
  'mistweaverco/kulala.nvim',
  keys = {
    { '<localleader>s', desc = 'Send request' },
    { '<localleader>a', desc = 'Send all requests' },
    { '<localleader>S', desc = 'Open scratchpad' },
  },
  ft = { 'http', 'rest' },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = '<localleader>',
    kulala_keymaps_prefix = '',
  },
}
