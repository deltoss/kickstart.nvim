local M = {}

-- Auto-detection order.
M.order = { "everything", "plocate" }

M.adapters = {
  everything = require("everywhere.backends.everything"),
  plocate = require("everywhere.backends.plocate"),
}

function M.defaults()
  local t = {}
  for name, adapter in pairs(M.adapters) do
    t[name] = vim.deepcopy(adapter.defaults)
  end
  return t
end

-- Returns the backend name to use, or nil if none is available.
function M.resolve(config)
  if config.backend ~= "auto" then
    return config.backend
  end
  for _, name in ipairs(M.order) do
    if vim.fn.executable(config.backends[name].cmd) == 1 then
      return name
    end
  end
end

return M
