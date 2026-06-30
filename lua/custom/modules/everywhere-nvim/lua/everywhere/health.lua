local backends = require("everywhere.backends")

local M = {}

local function report(name, cmd, missing, hint)
  if vim.fn.executable(cmd) == 1 then
    vim.health.ok(("%s (%s) found on path"):format(name, cmd))
    return true
  end
  vim.health[missing](("%s (%s) not found -- %s"):format(name, cmd, hint))
  return false
end

M.check = function()
  local cfg = require("everywhere").config
  local backend = cfg.backend

  vim.health.start("everywhere.nvim: search backend")
  if backend == "auto" then
    local found = false
    local hints = {}
    for _, name in ipairs(backends.order) do
      local adapter = backends.adapters[name]
      found = report(name, cfg.backends[name].cmd, "warn", adapter.hint) or found
      hints[#hints + 1] = adapter.hint
    end
    if not found then
      vim.health.error("no backend found -- " .. table.concat(hints, " / "))
    end
  elseif not cfg.backends[backend] then
    vim.health.error("unknown backend: " .. tostring(backend))
  else
    report(backend, cfg.backends[backend].cmd, "error", backends.adapters[backend].hint)
  end

  vim.health.start("everywhere.nvim: snacks.nvim dependency")
  if pcall(require, "snacks") then
    vim.health.ok("snacks.nvim is installed")
  else
    vim.health.error("snacks.nvim is not installed")
  end
end

return M
