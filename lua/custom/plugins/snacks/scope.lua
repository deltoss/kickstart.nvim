return {
  'snacks.nvim', -- only the name of the plugin needs to be specified since it already exists
  ---@type snacks.Config
  opts = {
    scope = {
      enabled = true,
      treesitter = {
        ---@type string[]|{enabled?:boolean}
        blocks = {
          enabled = true,
        },
      },
    },
  },
}
