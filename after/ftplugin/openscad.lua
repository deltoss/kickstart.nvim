local export_formats = { '3mf', 'stl', 'amf', 'off', 'csg', 'dxf', 'svg', 'pdf', 'png' }

local function run_openscad(format)
  if vim.fn.executable 'openscad' ~= 1 then
    vim.notify('OpenSCAD executable not found in PATH', vim.log.levels.ERROR)
    return
  end

  vim.cmd.update()

  local path = vim.api.nvim_buf_get_name(0)
  local command = { 'openscad' }

  if format then
    command[#command + 1] = '-o'
    command[#command + 1] = vim.fn.fnamemodify(path, ':r') .. '.' .. format
  end

  command[#command + 1] = path
  vim.system(command, { detach = true })
end

vim.keymap.set('n', '<localleader>p', run_openscad, {
  buffer = true,
  desc = '[P]review in OpenSCAD',
  silent = true,
})

vim.keymap.set('n', '<localleader>r', function()
  vim.ui.select(export_formats, {
    prompt = 'OpenSCAD export format:',
  }, function(format)
    if format then
      run_openscad(format)
    end
  end)
end, {
  buffer = true,
  desc = '[R]ender with OpenSCAD',
  silent = true,
})
