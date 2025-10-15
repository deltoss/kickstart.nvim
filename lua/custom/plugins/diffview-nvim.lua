local function toggle_diffview(cmd)
  if next(require('diffview.lib').views) == nil then
    vim.cmd(cmd)
  else
    vim.cmd 'DiffviewClose'
  end
end

return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewRefresh' },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = { layout = 'diff2_horizontal' },
      merge_tool = { layout = 'diff3_mixed' },
    },
  },
  keys = {
    {
      '<leader>gd',
      function()
        toggle_diffview 'DiffviewOpen'
      end,
      desc = '[D]iff Index',
    },
    {
      '<leader>gD',
      function()
        toggle_diffview 'DiffviewOpen master..HEAD'
      end,
      desc = '[D]iff master',
    },
    {
      '<leader>gh',
      function()
        toggle_diffview 'DiffviewFileHistory %'
      end,
      desc = '[H]istory for current file',
    },
  },
}
