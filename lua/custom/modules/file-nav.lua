local M = {}

local function resolve_file_at_cursor()
  local line_text = vim.fn.getline '.'
  local col = vim.fn.col '.'

  local file, line

  local pos = 1
  while pos <= #line_text do
    local s, e, f, l = line_text:find('([%w%.%/%_%-]+):(%d+)', pos)
    if not s then
      break
    end
    if s <= col and col <= e then
      file = f
      line = l
      break
    end
    pos = e + 1
  end

  if not file then
    file = vim.fn.expand '<cfile>'
  end

  if not file or file == '' then
    return
  end

  local stat = vim.uv.fs_stat(vim.fs.normalize(file))
  if not stat or stat.type ~= 'file' then
    return
  end

  return file, line
end

function M.open_in_prev_win()
  local file, line = resolve_file_at_cursor()
  if not file then
    return
  end
  vim.cmd 'wincmd p'
  vim.cmd(line and ('edit +' .. line .. ' ' .. vim.fn.fnameescape(file)) or ('edit ' .. vim.fn.fnameescape(file)))
end

function M.open_in_current_win()
  local file, line = resolve_file_at_cursor()
  if not file then
    return
  end
  vim.cmd(line and ('edit +' .. line .. ' ' .. vim.fn.fnameescape(file)) or ('edit ' .. vim.fn.fnameescape(file)))
end

return M
