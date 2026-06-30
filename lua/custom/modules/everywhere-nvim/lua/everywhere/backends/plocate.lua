-- plocate adapter -- Linux. https://plocate.sesse.net/
local M = {}

M.defaults = { cmd = "plocate", database = nil }
M.hint = "install plocate, then run updatedb"

function M.file_args(opts, conf, query)
  local args = {}
  if not opts.case_sensitive then args[#args + 1] = "-i" end
  if opts.whole_word then args[#args + 1] = "-w" end
  if #query > 1 then args[#args + 1] = "-A" end -- AND the terms (plocate ORs by default)
  if opts.max_results then
    vim.list_extend(args, { "-l", tostring(opts.max_results) })
  end
  if conf.database then
    vim.list_extend(args, { "-d", conf.database })
  end
  if not opts.match_path then args[#args + 1] = "-b" end -- match the basename only
  if opts.regex then args[#args + 1] = "--regex" end
  vim.list_extend(args, query)
  return args
end

function M.git_args(opts, conf)
  local args = { "-i" }
  if conf.database then
    vim.list_extend(args, { "-d", conf.database })
  end
  vim.list_extend(args, { "--regex", "/\\.git$" })
  return args
end

-- plocate matches the `.git` entry itself; strip it to get the repo root.
function M.git_root(path)
  return (path:gsub("[/\\]%.git$", ""))
end

return M
