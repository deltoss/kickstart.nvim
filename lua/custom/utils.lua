local M = {}

function M.read_json_file(filepath)
  local ok, result = pcall(function()
    local file = io.open(filepath, 'r')
    if not file then
      return nil
    end
    local content = file:read '*all'
    file:close()
    return vim.json.decode(content)
  end)

  if ok then
    return result
  end
  return nil
end

return M
