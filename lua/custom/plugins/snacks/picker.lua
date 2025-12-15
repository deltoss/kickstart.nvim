return {
  'snacks.nvim', -- only the name of the plugin needs to be specified since it already exists
  ---@type snacks.Config
  opts = {
    picker = { enabled = true },
  },
  keys = {
    {
      '<leader>sf',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart [F]ind Files',
    },
    {
      '<leader>,',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Opened Buffers',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = '[H]elp Pages',
    },
    {
      '<leader>sH',
      function()
        Snacks.picker.highlights()
      end,
      desc = '[H]ighlights',
    },
    {
      '<leader>sN',
      function()
        Snacks.picker.notifications()
      end,
      desc = '[N]otifications',
    },
    {
      '<leader>en',
      function()
        Snacks.picker.notifications()
      end,
      desc = '[E]rror Notifications',
    },
    {
      '<leader>sC',
      function()
        Snacks.picker.commands()
      end,
      desc = 'Commands',
    },
    {
      '<leader>:',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = '[D]iagnostics',
    },
    {
      '<leader>sF',
      function()
        Snacks.picker.files()
      end,
      desc = '[F]iles',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.recent()
      end,
      desc = '[R]ecent Files',
    },
    {
      '<leader>sp',
      function()
        Snacks.picker.projects {
          patterns = { '*.sln', 'readme.md', '.git', '_darcs', '.hg', '.bzr', '.svn', 'package.json', 'Makefile' },
        }
      end,
      desc = '[P]rojects',
    },
    {
      '<leader>sD',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = 'Buffer [D]iagnostics',
    },
    -- Grep
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = '[G]rep',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Selection or [W]ord',
      mode = { 'n', 'x' },
    },
    {
      '<leader>sb',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = 'Grep Open [B]uffers',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = '[K]eymaps',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>s.',
      function()
        Snacks.picker.resume()
      end,
      desc = '[R]esume',
    },
    {
      '<leader>si',
      function()
        Snacks.picker.icons()
      end,
      desc = '[I]cons',
    },
    {
      '<leader>sn',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = '[N]eovim Files',
    },
    {
      '<leader>so',
      function()
        Snacks.picker.files { cwd = vim.fn.expand '~/Documents/Note Taking/Zettelkasten/' }
      end,
      desc = '[O]bsidian Files',
    },
    {
      '<leader>sT',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = '[T]hemes',
    },
    {
      '<leader>sG',
      function()
        Snacks.picker.git_files()
      end,
      desc = '[G]it Files',
    },
    -- git
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Git [S]tatus',
    },
    {
      '<leader>gd',
      function()
        Snacks.picker.git_diff()
      end,
      desc = 'Git [D]iff (Hunks)',
    },
    {
      '<leader>gl',
      function()
        Snacks.picker.git_log()
      end,
      desc = 'Git [L]og',
    },
    {
      '<leader>gL',
      function()
        Snacks.picker.git_log_line()
      end,
      desc = 'Git [L]og Line',
    },
    {
      '<leader>gf',
      function()
        Snacks.picker.git_files()
      end,
      desc = 'Git [F]iles',
    },
    {
      '<leader>gF',
      function()
        Snacks.picker.git_log_file()
      end,
      desc = 'Git Log [F]ile',
    },
    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches()
      end,
      desc = 'Git [B]ranches',
    },
    -- gh
    {
      '<leader>gHi',
      function()
        Snacks.picker.gh_issue()
      end,
      desc = 'GitHub [I]ssues (open)',
    },
    {
      '<leader>gHI',
      function()
        Snacks.picker.gh_issue { state = 'all' }
      end,
      desc = 'GitHub [I]ssues (all)',
    },
    {
      '<leader>gHp',
      function()
        Snacks.picker.gh_pr()
      end,
      desc = 'GitHub [P]ull Requests (open)',
    },
    {
      '<leader>gHP',
      function()
        Snacks.picker.gh_pr { state = 'all' }
      end,
      desc = 'GitHub [P]ull Requests (all)',
    },
    {
      '<leader>E',
      function()
        Snacks.explorer()
      end,
      desc = 'File [E]xplorer',
    },
  },
}
