return {
  'mistweaverco/kulala.nvim',
  keys = {
    { '<leaderleader>s', desc = 'Send request' },
    { '<leaderleader>a', desc = 'Send all requests' },
    { '<leaderleader>S', desc = 'Open scratchpad' },
  },
  ft = { 'http', 'rest' },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = '<localleader>',
    kulala_keymaps_prefix = '',
  },
}
