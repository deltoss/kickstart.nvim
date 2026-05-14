return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function() vim.fn["mkdp#util#install"]() end,
  ft = { "markdown" },
  keys = {
    { '<leader>Mp', '<cmd>MarkdownPreviewToggle<cr>', desc = '[P]review Toggle' },
  },
}
