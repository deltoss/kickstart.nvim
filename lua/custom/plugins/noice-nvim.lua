return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
      progress = {
        enabled = false, -- Turn this off as it breaks roslyn compiler. See https://github.com/seblyng/roslyn.nvim/issues/236
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      long_message_to_split = true, -- long messages will be sent to a split
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
}
