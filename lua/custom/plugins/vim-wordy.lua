return {
  'preservim/vim-wordy',
  cmd = { 'Wordy', 'NextWordy', 'PrevWordy' },
  ft = { 'markdown', 'text', 'tex' },
  keys = {
    {
      '<F8>',
      ':<C-u>NextWordy<cr>',
      desc = 'Next Wordy',
      mode = { 'n', 'x' },
    },
    {
      '<F8>',
      '<C-o>:NextWordy<cr>',
      desc = 'Next Wordy',
      mode = { 'i' },
    },
    {
      '<F7>',
      ':<C-u>PrevWordy<cr>',
      desc = 'Previous Wordy',
      mode = { 'n', 'x' },
    },
    {
      '<F7>',
      '<C-o>:PrevWordy<cr>',
      desc = 'Previous Wordy',
      mode = { 'i' },
    },
  },
}
