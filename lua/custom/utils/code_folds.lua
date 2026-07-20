local M = {}

local fold_ranges = {} -- { [bufnr] = { { start_line = <1 based>, end_line = <1 based> }, }, }
local fold_ranges_map = {} -- { [bufnr] = { [start_line] = { start_line = <1 based>, end_line = <1 based> }, }, }
local current_fold = {} -- { [winid] = { start_line = <1 based>, end_line = <1 based> } }

-- Fold ranges are keyed by window, since each window showing a buffer has its
-- own cursor position. Recomputes for every window currently showing bufnr,
-- so ranges that shift from an edit (without the cursor row changing) don't
-- leave current_fold pointing at a stale range.
local function refresh_current_fold(bufnr)
  for _, winid in ipairs(vim.fn.win_findbuf(bufnr)) do
    if vim.api.nvim_win_is_valid(winid) then
      local row = vim.api.nvim_win_get_cursor(winid)[1]
      M.update_current_fold(row, bufnr, winid)
    end
  end
end

function M.update_ranges(bufnr)
  local client = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/foldingRange" })[1]
  if not client then return end

  local params = { textDocument = { uri = vim.uri_from_bufnr(bufnr) } }
  local tick = vim.b[bufnr].changedtick

  client:request("textDocument/foldingRange", params, function(err, ranges)
    if err
      or not ranges
      or not vim.api.nvim_buf_is_valid(bufnr)
      or tick ~= vim.b[bufnr].changedtick
    then
      return
    end

    -- Rebuild fold ranges as a map for O(1) in statuscol
    local ranges_map = {}
    for i, range in ipairs(ranges) do
      ranges[i] = {
        start_line = range.startLine + 1,
        end_line = range.endLine + 1
      }
      ranges_map[range.startLine + 1] = ranges[i]
    end

    -- Sort fold ranges for goto prev fold search
    table.sort(ranges, function(a, b)
      return a.start_line < b.start_line
    end)

    fold_ranges_map[bufnr] = ranges_map
    fold_ranges[bufnr] = ranges

    refresh_current_fold(bufnr)
  end)
end

function M.update_current_fold(row, bufnr, winid)
  local ranges = fold_ranges[bufnr]
  if not ranges then return nil end

  local best_range = nil

  for i = 1, #ranges do
    local range = ranges[i]
    if range.start_line > row then break end

    if row <= range.end_line then
      best_range = range
    end
  end

  current_fold[winid] = best_range
end

function M.clear(bufnr)
  fold_ranges[bufnr] = nil
  fold_ranges_map[bufnr] = nil
end

function M.clear_win(winid)
  current_fold[winid] = nil
end

function M.goto_previous_fold()
  local bufnr = vim.api.nvim_get_current_buf()
  local ranges = fold_ranges[bufnr]
  if not ranges or #ranges == 0 then return end

  local row = vim.api.nvim_win_get_cursor(0)[1]

  for i = #ranges, 1, -1 do
    local start_line = ranges[i].start_line

    if start_line < row then
      return vim.api.nvim_win_set_cursor(0, { start_line, 0 })
    end
  end
end

function M.statuscol()
  local winid = vim.g.statusline_winid
  local bufnr = vim.api.nvim_win_get_buf(winid)
  local lnum = vim.v.lnum

  local fold_map = fold_ranges_map[bufnr]
  if not fold_map then return "%s%l   " end

  local this_range = fold_map[lnum]
  if not this_range then return "%s%l   " end

  local closed = (vim.fn.foldclosed(lnum) == lnum)
  local icon   = closed and "" or ""

  local hl = "FoldColumn"
  local cursor_fold = current_fold[winid]
  if cursor_fold and this_range.start_line == cursor_fold.start_line then
    hl = "CursorLineNr"
  end

  return "%s%l " .. "%#"..hl.."#" .. icon .. "%* "
end

return M
