---@type LazySpec
return {
  'mikavilpas/yazi.nvim',
  version = '*', -- use the latest stable version
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
  },
  keys = {
    {
      '-',
      mode = { 'n', 'v' },
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
    },
    {
      '<leader>-',
      '<cmd>Yazi toggle<cr>',
      desc = 'Resume the last yazi session',
    },
  },
  ---@type YaziConfig | {}
  opts = {
    open_for_directories = true,
    change_neovim_cwd_on_close = false,
    keymaps = {
      show_help = '<f2>',
      open_file_in_vertical_split = '<c-Right>',
      open_file_in_horizontal_split = '<c-Down>',
      open_file_in_tab = '<c-t>',
      grep_in_directory = '<leader>sg',
      replace_in_directory = '<c-g>',
      cycle_open_buffers = '<tab>',
      copy_relative_path_to_selected_files = '<c-y>',
      send_to_quickfix_list = '<c-q>',
      change_working_directory = '~',
      open_and_pick_window = '<c-o>',
    },
    -- completely override the keymappings for yazi. This function will be
    -- called in the context of the yazi terminal buffer.
    set_keymappings_function = function(buffer_id, config, context)
      vim.keymap.set({ 't' }, 'A', function()
        local entry = context.ya_process.hovered_url
        if entry == nil then
          vim.notify('No fd entry in yazi.nvim', vim.log.levels.WARN)
          return
        end
        local stat = vim.uv.fs_stat(entry)
        local path = stat.type == 'directory' and entry or vim.fs.dirname(entry)
        require('easy-dotnet').create_new_item(path, function(item_path)
          vim.cmd.edit(item_path)
        end)
      end, { buffer = buffer_id })
    end,
  },
  init = function()
    -- mark netrw as loaded so it's not loaded at all.
    --
    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    vim.g.loaded_netrwPlugin = 1
  end,
}
