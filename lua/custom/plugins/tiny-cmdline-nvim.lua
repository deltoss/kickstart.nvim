return {
  "rachartier/tiny-cmdline.nvim",
  init = function()
    vim.o.cmdheight = 0
  end,
  config = function()
    require("tiny-cmdline").setup({
      on_reposition = require("tiny-cmdline").adapters.blink,
    })
  end,
}
