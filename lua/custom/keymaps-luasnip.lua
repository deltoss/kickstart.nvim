local ls = require 'luasnip'

local keymap = vim.keymap.set

keymap({ 'i', 's' }, '<C-u>', function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)
keymap({ 'i', 's' }, '<C-e>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
