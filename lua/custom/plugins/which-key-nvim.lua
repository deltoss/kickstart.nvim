return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 0,
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },

    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch' },
      { '<leader>o', group = '[O]bsidian' },
      { '<leader>ot', group = '+[T]emplates' },
      { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
      { '<leader>gH', group = '+[H]unks', mode = { 'n', 'v' } },
      { '<leader>h', group = '[H]TTP (Bruno)' },
      { '<leader>he', group = '+[E]nv' },
      { '<leader>m', group = '[M]ark' },
      { '<leader>M', group = '[M]arkdown' },
      { '<leader>t', group = '[T]abs' },
      { '<leader>w', group = '[W]ezterm' },
      { '<leader>r', group = '[R]eplace' },
      { '<leader>k', group = 'Pee[k]' },
      { '<leader>p', group = '[P]aths' },
      { '<leader>P', group = '[P]aste' },
      { '<leader><leader>', group = 'Extended Commands' },
      { '<leader><leader>o', group = '[O]ptions' },
      { '<leader><leader>of', group = '+[F]ormatter (Conform)' },
      { '<leader>b', group = 'De[b]ug' },
      { '<leader>e', group = '[E]rror' },
      { '<leader>S', group = '[S]wap' },
    },
  },
}
