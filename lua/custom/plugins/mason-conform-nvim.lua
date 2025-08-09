return {
  'zapling/mason-conform.nvim',
  dependencies = {
    'williamboman/mason.nvim',
    'stevearc/conform.nvim',
  },
  config = function()
    require('mason-conform').setup {
      ensure_installed = {
        'taplo',
        'csharpier',
        'css_beautify',
        'jq',
        'yq',
        'yq',
        'taplo',
        'templ',
        'stylua',
        'isort',
        'black',
        'rustfmt',
        'prettierd',
        'prettier',
      },
    }
  end,
}
