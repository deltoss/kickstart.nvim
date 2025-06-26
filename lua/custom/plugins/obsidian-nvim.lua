return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
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
            img_folder = 'Zettelkasten/Assets',
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
    disable_frontmatter = true,
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
    { '<leader>otn', '<cmd>Obsidian new_from_template<cr>', desc = '[N]ew Note' },
    { '<leader>oti', '<cmd>Obsidian template<cr>', desc = '[I]nsert to Current Note' },

    { '<leader>on', '<cmd>Obsidian new<cr>', desc = '[N]ew Note' },
    { '<leader>oc', '<cmd>Obsidian toc<cr>', desc = 'Show Table of [C]ontents' },

    { '<leader>os', '<cmd>Obsidian quick_switch<cr>', desc = '[S]earch Notes' },
    { '<leader>of', '<cmd>Obsidian search<cr>', desc = '[F]ind Notes' },
    { '<leader>od', '<cmd>Obsidian today<cr>', desc = '[D]aily Note' },

    -- HACK: To insert a link in normal mode, when ':Obsidian link'
    -- command was only designed for visual mode
    {
      '<leader>ol',
      function()
        local query = vim.fn.input 'Search query (empty for all): '
        vim.cmd [[normal! a ]] -- Adds a space to insert the link into
        vim.cmd 'normal! v'
        vim.cmd('Obsidian link ' .. query)
      end,
      desc = '[L]ink to Existing Note',
    },

    { '<leader>op', '<cmd>Obsidian links<cr>', desc = '[P]review Links' },
    { '<leader>ob', '<cmd>Obsidian backlinks<cr>', desc = 'Show [B]acklinks' },
    { '<leader>og', '<cmd>Obsidian follow_link<cr>', desc = '[G]o to Link' },
    { '<leader>o<Right>', '<cmd>Obsidian follow_link vsplit<cr>', desc = 'Open Link [Right]' },
    { '<leader>o<Down>', '<cmd>Obsidian follow_link hsplit<cr>', desc = 'Open Link [Down]' },

    { '<leader>oo', '<cmd>Obsidian workspace<cr>', desc = 'Switch [W]orkspace' },

    { '<leader>oo', '<cmd>Obsidian open<cr>', desc = 'Open in [O]bsidian App' },
    { '<leader>or', '<cmd>Obsidian rename<cr>', desc = '[R]ename Note' },
    { '<leader>oi', '<cmd>Obsidian paste_img<cr>', desc = 'Paste [I]mage' },

    {
      '<leader>oe',
      ':Obsidian extract_note<cr>',
      desc = '[E]xtract Selection to New Note',
      mode = 'x',
    },
    {
      '<leader>ol',
      function()
        local query = vim.fn.input 'Search query (empty for all): '
        vim.cmd 'normal! gv'
        vim.cmd('Obsidian link ' .. query)
      end,
      desc = '[L]ink Selection to Existing Note',
      mode = 'x',
    },
    {
      '<leader>on',
      ':Obsidian link_new<cr>',
      desc = 'Link Selection to [N]ew Note',
      mode = 'x',
    },
  },
}
