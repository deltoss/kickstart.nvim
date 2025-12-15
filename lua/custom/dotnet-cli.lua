local function build()
  vim.g.dotnet_errors_only = true
  vim.g.dotnet_show_project_file = false

  vim.cmd 'compiler dotnet'
  vim.cmd 'make!' -- ! to skip saving the buffer
  vim.cmd 'cwindow'
end

vim.keymap.set('n', '<leader>N', function()
  Snacks.picker.pick {
    title = '🚀 DotNet Commands',
    layout = {
      preset = 'default',
      preview = false,
    },
    items = {
      {
        text = 'Build',
        callback = build,
        desc = 'Build the project',
      },
      { text = 'Build (Release)', cmd = 'dotnet build -c Release', desc = 'Build in Release mode' },
      {
        text = 'Rebuild',
        callback = function()
          vim.cmd 'split | resize 15 | terminal dotnet clean'
          build()
        end,
        desc = 'Clean and build',
      },
      { text = 'Clean', cmd = 'dotnet clean', desc = 'Clean build outputs' },
      { text = 'Restore', cmd = 'dotnet restore', desc = 'Restore dependencies' },
      { text = 'Run', cmd = 'dotnet run', desc = 'Run the project' },
      { text = 'Run (Release)', cmd = 'dotnet run -c Release', desc = 'Run in Release mode' },
      { text = 'Test', cmd = 'dotnet test', desc = 'Run tests' },
      { text = 'Watch Run', cmd = 'dotnet watch run', desc = 'Run with file watcher' },
      { text = 'Watch Test', cmd = 'dotnet watch test', desc = 'Test with file watcher' },
    },
    format = function(item, picker)
      return {
        { item.text, 'Bold' }, -- Searchable field
        -- Display-only metadata
        { '  ' .. item.desc .. '', 'Comment', virtual = true },
      }
    end,
    confirm = function(picker, item)
      -- Check if it's a callback function
      if item.callback then
        item.callback()
      else
        local cmd = item.cmd
        vim.cmd('split | resize 15 | terminal ' .. cmd)
      end
    end,
  }
end, { desc = 'Dot[N]et CLI Commands' })
