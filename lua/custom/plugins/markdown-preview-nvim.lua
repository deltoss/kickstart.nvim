return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function() vim.fn["mkdp#util#install"]() end,
  keys = {
    { '<leader>Mp', '<cmd>MarkdownPreviewToggle<cr>', desc = '[P]review Toggle' },
  },
}
