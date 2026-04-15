vim.filetype.add {
  extension = {
    tmpl = 'templ',
    sln = 'solution',
    slnx = 'solution',
    slnf = 'slnfilter',
    csproj = 'csproj',
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'tmpl' },
  callback = function()
    vim.treesitter.start(0, 'templ')
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'csproj', 'solution', 'slnfilter' },
  callback = function()
    vim.treesitter.start(0, 'xml')
  end,
})
