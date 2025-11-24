local M = {}

M.commands = {
  {
    name = 'Copilot: Actions',
    action = '<leader>ca',
  },
  {
    name = 'Dim: Toggle',
    action = function()
      local snacks_dim = require('snacks').dim
      if snacks_dim.enabled then
        snacks_dim.disable()
      else
        snacks_dim.enable()
      end
    end,
  },
  {
    name = 'Tab: Close',
    action = ':tabclose',
  },
  {
    name = 'Tab: New',
    action = ':tabnew',
  },
  {
    name = 'Todo Comments: Quickfix List',
    action = ':TodoQuickFix',
  },
  {
    name = 'Todo Comments: Location List',
    action = ':TodoLocList',
  },
}

function M.show_commands()
  local items = {}

  for idx, command in ipairs(M.commands) do
    local item = {
      idx = idx,
      name = command.name,
      text = command.name,
      action = command.action,
    }
    table.insert(items, item)
  end

  Snacks.picker {
    title = 'Command Palette',
    layout = {
      preset = 'default',
      preview = false,
    },
    items = items,
    format = function(item, _)
      return {
        { item.text, item.text_hl },
      }
    end,
    confirm = function(picker, item)
      if type(item.action) == 'string' then
        if item.action:find '^:' then
          picker:close()
          return picker:norm(function()
            picker:close()
            vim.cmd(item.action:sub(2))
          end)
        else
          return picker:norm(function()
            picker:close()
            local keys = vim.api.nvim_replace_termcodes(item.action, true, true, true)
            vim.api.nvim_input(keys)
          end)
        end
      end

      return picker:norm(function()
        picker:close()
        item.action()
      end)
    end,
  }
end

return M
