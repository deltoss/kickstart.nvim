vim.filetype.add {
  extension = {
    tmpl = 'templ',
    sln = 'solution',
    slnx = 'solution',
    slnf = 'slnfilter',
    csproj = 'csproj',
    http = 'http', -- See https://neovim.getkulala.net/docs/getting-started/requirements
    systemd = 'ini', -- systemd syntax uses ini syntax under the hood
    container = 'ini', -- Podman quadlets uses systemd, and thus ini
    network = 'ini',
  },
  -- Patterns take priority over the `tmpl = 'templ'` extension above,
  -- so these double-extension templates resolve to their inner language.
  pattern = {
    ['.*%.nu%.tmpl'] = 'nu',
    ['.*%.sh%.tmpl'] = 'bash',
    ['.*%.ps1%.tmpl'] = 'ps1',
    ['.*%.container%.tmpl'] = 'ini',
    ['.*%.network%.tmpl'] = 'ini',
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
