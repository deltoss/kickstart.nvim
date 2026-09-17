return {
  "rachartier/tiny-cmdline.nvim",
  init = function()
    vim.o.cmdheight = 0
    require("vim._core.ui2").enable({})
  end,
  config = function()
    require("tiny-cmdline").setup({
      on_reposition = require("tiny-cmdline").adapters.blink,
    })
  end,
}
