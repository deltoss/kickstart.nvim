vim.keymap.set('n', '<leader>n', function()
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  local menu_items = {
    { name = 'Build', cmd = 'dotnet build', desc = 'Build the project' },
    { name = 'Build (Release)', cmd = 'dotnet build -c Release', desc = 'Build in Release mode' },
    { name = 'Rebuild', cmd = 'dotnet clean && dotnet build', desc = 'Clean and build' },
    { name = 'Clean', cmd = 'dotnet clean', desc = 'Clean build outputs' },
    { name = 'Restore', cmd = 'dotnet restore', desc = 'Restore dependencies' },
    { name = 'Run', cmd = 'dotnet run', desc = 'Run the project' },
    { name = 'Run (Release)', cmd = 'dotnet run -c Release', desc = 'Run in Release mode' },
    { name = 'Test', cmd = 'dotnet test', desc = 'Run tests' },
    { name = 'Watch Run', cmd = 'dotnet watch run', desc = 'Run with file watcher' },
    { name = 'Watch Test', cmd = 'dotnet watch test', desc = 'Test with file watcher' },
  }

  pickers
    .new({}, {
      prompt_title = '🚀 DotNet Commands',
      finder = finders.new_table {
        results = menu_items,
        entry_maker = function(entry)
          return {
            value = entry,
            display = string.format('%-20s %s', entry.name, entry.desc),
            ordinal = entry.name,
          }
        end,
      },
      sorter = conf.generic_sorter {},
      previewer = false,
      layout_config = {
        width = 0.6,
        height = 0.5,
      },
      attach_mappings = function(prompt_bufnr, map)
        local run_command = function(close_on_run)
          local selection = action_state.get_selected_entry()
          if selection then
            if close_on_run then
              actions.close(prompt_bufnr)
            end

            -- Check if it's a callback function
            if selection.value.callback then
              selection.value.callback()
            else
              local cmd = selection.value.cmd
              vim.cmd('split | resize 15 | terminal ' .. cmd)
            end
          end
        end

        -- Enter runs Telescope
        actions.select_default:replace(function()
          run_command(false)
        end)

        -- Enters runs and closes Telescope
        map('i', '<C-x>', function()
          run_command(true)
        end)

        return true
      end,
    })
    :find()
end, { desc = 'Dot[N]et CLI Commands' })
