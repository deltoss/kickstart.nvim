-- Everything (es) adapter -- Windows. https://www.voidtools.com/
local M = {}

M.defaults = { cmd = "es", sort = false, offset = 0 }
M.hint = "install Everything (voidtools.com)"

function M.file_args(opts, conf, query)
  local args = {}
  if opts.case_sensitive then args[#args + 1] = "-case" end
  if opts.whole_word then args[#args + 1] = "-whole-word" end
  if opts.match_path then args[#args + 1] = "-match-path" end
  if conf.sort then args[#args + 1] = "-s" end
  if (conf.offset or 0) > 0 then
    vim.list_extend(args, { "-offset", tostring(conf.offset) })
  end
  if opts.max_results then
    vim.list_extend(args, { "-max-results", tostring(opts.max_results) })
  end
  if opts.regex then args[#args + 1] = "-regex" end -- must come after every other flag
  vim.list_extend(args, query)
  return args
end

-- `child:^\.git$` matches folders whose direct child is `.git`, so es lists
-- the repo roots directly. (-r enables regex and must stay last.)
function M.git_args()
  return { "-p", "-r", "child:^\\.git$" }
end

function M.git_root(path)
  return path
end

return M
