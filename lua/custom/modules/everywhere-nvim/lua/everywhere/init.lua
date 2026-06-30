local backends = require("everywhere.backends")

local M = {}

local defaults = {
  backend = "auto",
  case_sensitive = false,
  whole_word = false,
  match_path = false,
  regex = true,
  max_results = 100,
  backends = backends.defaults(),
}

M.config = vim.deepcopy(defaults)
M.backends = backends.order

-- Split a query into terms, keeping "quoted phrases" together.
local function split_search(search)
  local parts, remaining = {}, search
  for quoted in search:gmatch('"[^"]*"') do
    parts[#parts + 1] = quoted:sub(2, -2)
    remaining = remaining:gsub('"[^"]*"', "", 1)
  end
  for word in remaining:gmatch("%S+") do
    parts[#parts + 1] = word
  end
  return parts
end

local function no_backend()
  vim.notify("everywhere.nvim: no backend found (install Everything or plocate)", vim.log.levels.WARN)
  return function() end
end

-- Builds a snacks transform that maps each output line to a file item.
local function to_item(map)
  return function(item)
    local path = vim.trim(item.text)
    if path == "" then return false end
    item.file = map and map(path) or path
    item.text = item.file
  end
end

-- build(adapter, conf) returns the command args and an optional path mapper.
local function run(opts, ctx, build)
  local name = backends.resolve(opts)
  if not name then return no_backend() end
  local conf = opts.backends[name]
  local args, map = build(backends.adapters[name], conf)
  return require("snacks.picker.source.proc").proc(ctx:opts({
    cmd = conf.cmd,
    args = args,
    transform = to_item(map),
  }), ctx)
end

local function file_finder(opts, ctx)
  local search = ctx.filter.search or ""
  if search == "" then return function() end end
  local query = split_search(search)
  return run(opts, ctx, function(adapter, conf)
    return adapter.file_args(opts, conf, query)
  end)
end

local function git_finder(opts, ctx)
  return run(opts, ctx, function(adapter, conf)
    return adapter.git_args(opts, conf), adapter.git_root
  end)
end

local file_picker = {
  live = true,
  supports_live = true,
  need_search = true,
  format = "file",
  preview = "file",
  finder = file_finder,
}

local git_picker = {
  format = "file",
  preview = "file",
  confirm = "jump",
  finder = git_finder,
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", defaults, opts or {})
  local ok, picker = pcall(require, "snacks.picker")
  if not ok then return end
  picker.sources = picker.sources or {}
  picker.sources.everywhere = vim.tbl_extend("force", file_picker, M.config, { title = "File Search" })
end

function M.pick(opts)
  local cfg = vim.tbl_deep_extend("force", M.config, opts or {})
  cfg.backend = backends.resolve(cfg)
  local titles = { everything = "Everything", plocate = "plocate" }
  Snacks.picker.pick(vim.tbl_extend("force", file_picker, cfg, {
    title = titles[cfg.backend] or "File Search",
  }))
end

function M.git_repos(opts)
  local cfg = vim.tbl_deep_extend("force", M.config, opts or {})
  cfg.backend = backends.resolve(cfg)
  Snacks.picker.pick(vim.tbl_extend("force", git_picker, cfg, { title = "Git Repositories" }))
end

return M
