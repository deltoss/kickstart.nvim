return {
  'obsidian-nvim/obsidian.nvim',
  lazy = true,
  ft = { 'markdown', 'codecompanion' },
  opts = {
    footer = { -- backlinks in footer as causing issues
      enabled = false,
    },
    legacy_commands = false,
    workspaces = {
      {
        name = 'Zettelkasten',
        path = '~/Documents/Note Taking',
        overrides = {
          notes_subdir = 'Zettelkasten/Notes',
          new_notes_location = 'notes_subdir',
          daily_notes = {
            folder = 'Zettelkasten/Fleeting Notes',
            template = nil,
          },
          attachments = {
            folder = 'Zettelkasten/Assets',
          },
          templates = {
            folder = '.obsidian-nvim/templates',
          },

          -- Modification based on inbuilt wiki link function. Adds checks for:
          -- * Empty string label when deciding to prepend a label.
          -- * Label consisting only of whitespace. This is a hack for my personal use case of inserting a link to an existing note in normal mode.
          wiki_link_func = function(opts)
            local anchor = ''
            local header = ''
            if opts.anchor then
              anchor = opts.anchor.anchor
              header = require('obsidian.util').format_anchor_label(opts.anchor)
            elseif opts.block then
              anchor = '#' .. opts.block.id
              header = '#' .. opts.block.id
            end

            if opts.id == nil then
              return string.format('[[%s%s]]', opts.label, anchor)
            elseif opts.label ~= '' and not opts.label:match '^%s*$' and opts.label ~= opts.id then
              return string.format('[[%s%s|%s%s]]', opts.id, anchor, opts.label, header)
            else
              return string.format('[[%s%s]]', opts.id, anchor)
            end
          end,
        },
      },
    },
    frontmatter = {
      enabled = false,
    },
    completion = {
      -- Enables completion using nvim_cmp
      nvim_cmp = false,
      -- Enables completion using blink.cmp
      blink = true,
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
    { '<leader>ntn', '<cmd>Obsidian new_from_template<cr>', desc = '[N]ew Note' },
    { '<leader>nti', '<cmd>Obsidian template<cr>', desc = '[I]nsert to Current Note' },

    { '<leader>nn', '<cmd>Obsidian new<cr>', desc = '[N]ew Note' },
    { '<leader>nc', '<cmd>Obsidian toc<cr>', desc = 'Show Table of [C]ontents' },

    { '<leader>ns', '<cmd>Obsidian quick_switch<cr>', desc = '[S]earch Notes' },
    { '<leader>nf', '<cmd>Obsidian search<cr>', desc = '[F]ind Notes' },
    { '<leader>nd', '<cmd>Obsidian today<cr>', desc = '[D]aily Note' },

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
    { 'gf', '<cmd>Obsidian follow_link<cr>', desc = '[G]o to Link' },
    { '<leader>ng', '<cmd>Obsidian follow_link<cr>', desc = '[G]o to Link' },
    { '<leader>n<Right>', '<cmd>Obsidian follow_link vsplit<cr>', desc = 'Open Link [Right]' },
    { '<leader>n<Down>', '<cmd>Obsidian follow_link hsplit<cr>', desc = 'Open Link [Down]' },

    { '<leader>no', '<cmd>Obsidian workspace<cr>', desc = 'Switch [W]orkspace' },

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
      function()
        local query = vim.fn.input 'Search query (empty for all): '
        vim.cmd 'normal! gv'
        vim.cmd('Obsidian link ' .. query)
      end,
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
