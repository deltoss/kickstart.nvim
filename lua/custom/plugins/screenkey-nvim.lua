return {
  'NStefan002/screenkey.nvim',
  lazy = false,
  version = '*', -- or branch = "main", to use the latest commit
  config = function()
    require('screenkey').setup {}
    require('screenkey').toggle()
  end,
}
