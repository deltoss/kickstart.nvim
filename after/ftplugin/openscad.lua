vim.keymap.set('n', '<localleader>p', function()
  if vim.fn.executable 'openscad' ~= 1 then
    vim.notify('OpenSCAD executable not found in PATH', vim.log.levels.ERROR)
    return
  end

  vim.cmd.update()

  local path = vim.api.nvim_buf_get_name(0)
  vim.system({ 'openscad', path }, { detach = true })
end, {
  buffer = true,
  desc = '[P]review in OpenSCAD',
  silent = true,
})
