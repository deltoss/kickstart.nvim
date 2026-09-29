-- Opens `target` (optionally wrapped in `<...>`) relative to the current buffer's directory.
local function open_relative_file(target, open_cmd)
  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == '' then
    return false
  end
  local file = target:match('^<(.+)>$') or target
  local path = vim.fs.normalize(vim.fs.dirname(current_file) .. '/' .. file)
  local stat = vim.uv.fs_stat(path)
  if stat and stat.type == 'file' then
    vim.cmd(open_cmd .. ' ' .. vim.fn.fnameescape(path))
    return true
  end
  return false
end

-- Inline links: `[text](target)` or `[text](<target with spaces>)`.
local function open_local_file_link(open_cmd)
  local text = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local pos = 1

  while true do
    local start_col, end_col, target = text:find('%[[^%]]+%]%((.-)%)', pos)
    if not start_col then
      return false
    end
    if start_col <= col and col <= end_col then
      return open_relative_file(target, open_cmd)
    end
    pos = end_col + 1
  end
end

local function open_obsidian_uri(uri)
  local vault = uri:match('[?&]vault=([^&]+)')
  local file = uri:match('[?&]file=([^&]+)')
  if uri:match('^obsidian://open%?') and vault and file then
    if vim.fn.executable 'notesmd-cli' == 0 then
      vim.notify('notesmd-cli not found in PATH', vim.log.levels.ERROR)
      return
    end
    local path = vim.uri_decode(file):gsub('\\', '/')
    vim.system({ 'notesmd-cli', 'open', path, '--vault', vim.uri_decode(vault) }, { text = true }, function(result)
      if result.code ~= 0 then
        vim.schedule(function()
          local message = result.stderr or ''
          if message == '' then
            message = result.stdout or ''
          end
          vim.notify(message ~= '' and message or 'notesmd-cli failed to open note', vim.log.levels.ERROR)
        end)
      end
    end)
    return
  end

  local job, err = vim.ui.open(uri)
  if not job then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

-- Open an external Obsidian URI instead of treating it as a file path.
local function open_obsidian_uri_link()
  local text = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local pos = 1

  while true do
    local start_col, end_col, target = text:find('%[[^%]]+%]%((obsidian://.-)%)', pos)
    if not start_col then
      return false
    end
    if start_col <= col and col <= end_col then
      open_obsidian_uri(target)
      return true
    end
    pos = end_col + 1
  end
end

-- Parses a link reference definition: `[label]: <target>` or `[label]: target`.
local function parse_reference_definition(line)
  local label, target = line:match('^%s*%[([^%]]+)%]:%s*(<[^>]+>)')
  if not label then
    label, target = line:match('^%s*%[([^%]]+)%]:%s*(%S+)')
  end
  return label, target
end

-- Labels are case-insensitive per CommonMark.
local function find_reference_target(label)
  local wanted = label:lower()
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    local def_label, target = parse_reference_definition(line)
    if def_label and def_label:lower() == wanted then
      return target
    end
  end
end

-- Reference-style links: `[text][label]`, collapsed `[label][]`, or the cursor
-- on a `[label]: <target>` definition line.
local function open_reference_link(open_cmd)
  local text = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1

  local _, def_target = parse_reference_definition(text)
  if def_target then
    return open_relative_file(def_target, open_cmd)
  end

  local pos = 1
  while true do
    local start_col, end_col, link_text, label = text:find('%[([^%]]+)%]%[([^%]]*)%]', pos)
    if not start_col then
      return false
    end
    if start_col <= col and col <= end_col then
      local target = find_reference_target(label ~= '' and label or link_text)
      return target ~= nil and open_relative_file(target, open_cmd)
    end
    pos = end_col + 1
  end
end

local function follow_file(key)
  local in_tab = key == 'gt' or key == 'gT'
  local open_cmd = key == 'gS' and 'vsplit' or (in_tab and 'tabedit' or 'edit')
  if (key == 'gf' or key == 'gF') and open_obsidian_uri_link() then
    return
  end
  if open_local_file_link(open_cmd) or open_reference_link(open_cmd) then
    return
  end

  if key == 'gf' or key == 'gS' then
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2] + 1
    -- crude check: is there a [[...]] or [...](...) near the cursor?
    local before = line:sub(1, col)
    local after = line:sub(col)
    local on_link = (before:match '%[%[[^%]]*$' and after:match '^[^%[]*%]%]') or (before:match '%[[^%]]*$' and after:match '^[^%]]*%]%(')
    if on_link then
      vim.cmd(key == 'gS' and 'Obsidian follow_link vsplit' or 'Obsidian follow_link')
      return
    end
  end

  if key == 'gS' then
    vim.cmd 'vertical wincmd F'
    return
  end

  local file_key = (key == 'gF' or key == 'gT') and 'gF' or 'gf'
  vim.cmd((in_tab and 'wincmd ' or 'normal! ') .. file_key)
end

return {
  'obsidian-nvim/obsidian.nvim',
  lazy = true,
  ft = { 'markdown', 'codecompanion' },
  opts = {
    footer = { -- Disable backlinks in footer as it's causing lag issues
      enabled = false,
    },
    legacy_commands = false,
    open = { func = open_obsidian_uri },
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
    {
      'gf',
      function()
        follow_file 'gf'
      end,
      ft = 'markdown',
      desc = 'Follow obsidian link or go to file',
    },
    {
      'gF',
      function()
        follow_file 'gF'
      end,
      ft = 'markdown',
      desc = 'Follow local file link or go to file:line',
    },
    {
      'gt',
      function()
        follow_file 'gt'
      end,
      ft = 'markdown',
      desc = 'Open local file link in new tab',
    },
    {
      'gT',
      function()
        follow_file 'gT'
      end,
      ft = 'markdown',
      desc = 'Open local file link or file:line in new tab',
    },
    {
      'gS',
      function()
        follow_file 'gS'
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
