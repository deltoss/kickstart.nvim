local navigation = require 'custom.modules.markdown-navigation'

return {
  'obsidian-nvim/obsidian.nvim',
  lazy = true,
  ft = { 'markdown', 'codecompanion' },
  opts = {
    footer = { -- Disable backlinks in footer as it's causing lag issues
      enabled = false,
    },
    legacy_commands = false,
    open = { func = navigation.open_obsidian_uri },
    workspaces = {
      {
        name = 'Zettelkasten',
        path = '~/Documents/Note Taking',
        overrides = {
          attachments = {
            folder = 'Zettelkasten/Assets',
          },
          daily_notes = {
            folder = 'Work-Zettelkasten/Dailies',
            template = nil,
            date_format = 'YYYY-MM-DD-dddd',
          },
          templates = {
            folder = '.obsidian-nvim/templates',
            customizations = {
              -- Override settings for work templates
              Work_Project = {
                notes_subdir = 'Work-Zettelkasten/Notes',
              },
              Work_Concept = {
                notes_subdir = 'Work-Zettelkasten/Notes',
              },
              Work_Pattern = {
                notes_subdir = 'Work-Zettelkasten/Notes',
              },
            },
          },
          link = {
            style = 'wiki',
            format = 'shortest',
          },
        },
      },
    },
    frontmatter = {
      enabled = false,
    },
    note_id_func = function(title)
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like 'my-new-note', and therefore the file name 'my-new-note.md'
      -- Otherwise, it'd be in timestamp format with random uppercase letter suffix
      if title ~= nil then
        -- If title is given, transform it into valid file name in kebab-case format.
        return title:lower():gsub('[%s_]+', '-'):gsub('[^%w%-]', ''):gsub('[\r\n]+', ' ')
      end

      local suffix = ''
      -- If title is nil, just add 4 random uppercase letters to the suffix.
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
      return tostring(os.time()) .. '-' .. suffix
    end,
  },
  keys = {
    {
      'gf',
      function()
        navigation.follow 'gf'
      end,
      ft = 'markdown',
      desc = 'Follow obsidian link or go to file',
    },
    {
      'gF',
      function()
        navigation.follow 'gF'
      end,
      ft = 'markdown',
      desc = 'Follow local file link or go to file:line',
    },
    {
      'gt',
      function()
        navigation.follow 'gt'
      end,
      ft = 'markdown',
      desc = 'Open local file link in new tab',
    },
    {
      'gT',
      function()
        navigation.follow 'gT'
      end,
      ft = 'markdown',
      desc = 'Open local file link or file:line in new tab',
    },
    {
      'gS',
      function()
        navigation.follow 'gS'
      end,
      ft = 'markdown',
      desc = 'Follow obsidian link or go to file in split',
    },
    { '<leader>ntn', '<cmd>Obsidian new_from_template<cr>', desc = '[N]ew Note' },
    { '<leader>nti', '<cmd>Obsidian template<cr>', desc = '[I]nsert to Current Note' },

    -- Don't use below. Prefer to use templates, which controls where the note gets placed
    -- { '<leader>nn', '<cmd>Obsidian new<cr>', desc = '[N]ew Note' },
    { '<leader>nn', '<cmd>Obsidian new_from_template<cr>', desc = '[N]ew Note' },
    { '<leader>nc', '<cmd>Obsidian toc<cr>', desc = 'Show Table of [C]ontents' },

    { '<leader>ns', '<cmd>Obsidian quick_switch<cr>', desc = '[S]earch Notes' },
    { '<leader>ng', '<cmd>Obsidian search<cr>', desc = '[G]rep Notes' },
    { '<leader>nd', '<cmd>Obsidian today<cr>', desc = '[D]aily Note' },
    { '<C-/>', '<cmd>Obsidian today<cr>', desc = '[D]aily Note' },

    -- HACK: To insert a link in normal mode, when ':Obsidian link'
    -- command was only designed for visual mode
    {
      '<leader>nl',
      function()
        local query = vim.fn.input 'Search query (empty for all): '
        vim.cmd [[normal! a ]] -- Adds a space to insert the link into
        vim.cmd 'normal! v'
        vim.cmd('Obsidian link ' .. query)
      end,
      desc = '[L]ink to Existing Note',
    },

    { '<leader>np', '<cmd>Obsidian links<cr>', desc = '[P]review Links' },
    { '<leader>nb', '<cmd>Obsidian backlinks<cr>', desc = 'Show [B]acklinks' },
    { '<leader>n<Right>', '<cmd>Obsidian follow_link vsplit<cr>', desc = 'Open Link [Right]' },
    { '<leader>n<Down>', '<cmd>Obsidian follow_link hsplit<cr>', desc = 'Open Link [Down]' },

    { '<leader>nw', '<cmd>Obsidian workspace<cr>', desc = 'Switch [W]orkspace' },

    { '<leader>no', '<cmd>Obsidian open<cr>', desc = 'Open in [O]bsidian App' },
    { '<leader>nr', '<cmd>Obsidian rename<cr>', desc = '[R]ename Note' },
    { '<leader>ni', '<cmd>Obsidian paste_img<cr>', desc = 'Paste [I]mage' },

    {
      '<leader>ne',
      ':Obsidian extract_note<cr>',
      desc = '[E]xtract Selection to New Note',
      mode = 'x',
    },
    {
      '<leader>nl',
      ':Obsidian link<cr>',
      desc = '[L]ink Selection to Existing Note',
      mode = 'x',
    },
    {
      '<leader>nn',
      ':Obsidian link_new<cr>',
      desc = 'Link Selection to [N]ew Note',
      mode = 'x',
    },
  },
}
