local M = {}

local actions = {
  gf = { open = 'edit', fallback = 'normal! gf' },
  gF = { open = 'edit', fallback = 'normal! gF' },
  gt = { open = 'tabedit', fallback = 'wincmd gf' },
  gT = { open = 'tabedit', fallback = 'wincmd gF' },
  gS = { open = 'vsplit', fallback = 'vertical wincmd F' },
}

-- Return captures from the link containing the 1-based cursor column.
local function find_link_at_cursor(line, col, pattern)
  local pos = 1
  while true do
    local first, last, target, label = line:find(pattern, pos)
    if not first then
      return
    end
    if first <= col and col <= last then
      return target, label
    end
    pos = last + 1
  end
end

-- Reference definitions: `[label]: <target>` or `[label]: target`.
local function parse_reference_definition(line)
  local label, target = line:match '^%s*%[([^%]]+)%]:%s*(<[^>]+>)'
  if not label then
    label, target = line:match '^%s*%[([^%]]+)%]:%s*(%S+)'
  end
  return label, target
end

local function find_reference_target(label)
  local wanted = label:lower()
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    local definition_label, target = parse_reference_definition(line)
    if definition_label and definition_label:lower() == wanted then
      return target
    end
  end
end

local function reference_target_at_cursor(line, col)
  local _, target = parse_reference_definition(line)
  if target then
    return target
  end

  local text, label = find_link_at_cursor(line, col, '%[([^%]]+)%]%[([^%]]*)%]')
  if text then
    return find_reference_target(label ~= '' and label or text)
  end
end

local function jump_to_heading(anchor, open_cmd)
  anchor = vim.uri_decode(anchor)
  -- shortcut: simple ATX headings only; use a Markdown parser if broader support is needed.
  for row, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    local heading = line:match '^#+%s+(.+)'
    local slug = heading and heading:lower():gsub('[^%w%s_-]', ''):gsub('%s+', '-')
    if slug == anchor then
      vim.cmd "normal! m'"
      if open_cmd == 'tabedit' then
        vim.cmd 'tab split'
      elseif open_cmd == 'vsplit' then
        vim.cmd 'vsplit'
      end
      vim.api.nvim_win_set_cursor(0, { row, 0 })
      vim.cmd 'normal! zv'
      return
    end
  end
  vim.notify('Heading not found: #' .. anchor, vim.log.levels.WARN)
end

-- Return true when handled, including a missing heading that already showed a warning.
local function open_local_target(target, open_cmd)
  local file = target:match '^<(.+)>$' or target
  local anchor = file:match '^#(.+)$'
  if anchor then
    jump_to_heading(anchor, open_cmd)
    return true
  end

  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == '' then
    return false
  end
  local path = vim.fs.normalize(vim.fs.dirname(current_file) .. '/' .. file)
  local stat = vim.uv.fs_stat(path)
  if not stat or stat.type ~= 'file' then
    return false
  end
  vim.cmd(open_cmd .. ' ' .. vim.fn.fnameescape(path))
  return true
end

--- Open an Obsidian note via notesmd-cli, or another Obsidian URI via the OS opener.
---@param uri string
function M.open_obsidian_uri(uri)
  local vault = uri:match '[?&]vault=([^&]+)'
  local file = uri:match '[?&]file=([^&]+)'
  if uri:match '^obsidian://open%?' and vault and file then
    if vim.fn.executable 'notesmd-cli' == 0 then
      vim.notify('notesmd-cli not found in PATH', vim.log.levels.ERROR)
      return
    end
    local path = vim.uri_decode(file):gsub('\\', '/')
    vim.system({ 'notesmd-cli', 'open', path, '--vault', vim.uri_decode(vault) }, { text = true }, function(result)
      if result.code == 0 then
        return
      end
      local message = result.stderr
      if not message or message == '' then
        message = result.stdout
      end
      if not message or message == '' then
        message = 'notesmd-cli failed to open note'
      end
      vim.schedule(function()
        vim.notify(message, vim.log.levels.ERROR)
      end)
    end)
    return
  end

  local job, err = vim.ui.open(uri)
  if not job then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

--- Follow a Markdown link, then try Obsidian or native file navigation.
---@param key 'gf'|'gF'|'gt'|'gT'|'gS'
function M.follow(key)
  local action = actions[key] or actions.gf
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local target = find_link_at_cursor(line, col, '%[[^%]]+%]%((.-)%)')

  if target and target:match '^obsidian://' and (key == 'gf' or key == 'gF') then
    M.open_obsidian_uri(target)
    return
  end
  if target and open_local_target(target, action.open) then
    return
  end

  local reference_target = reference_target_at_cursor(line, col)
  if reference_target and open_local_target(reference_target, action.open) then
    return
  end

  if key == 'gf' or key == 'gS' then
    local before, after = line:sub(1, col), line:sub(col)
    local on_wiki_link = before:match '%[%[[^%]]*$' and after:match '^[^%[]*%]%]'
    local on_inline_label = before:match '%[[^%]]*$' and after:match '^[^%]]*%]%('
    if on_wiki_link or on_inline_label then
      vim.cmd(key == 'gS' and 'Obsidian follow_link vsplit' or 'Obsidian follow_link')
      return
    end
  end

  vim.cmd(action.fallback)
end

return M
