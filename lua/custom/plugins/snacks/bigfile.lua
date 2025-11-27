return {
  'snacks.nvim', -- only the name of the plugin needs to be specified since it already exists
  ---@type snacks.Config
  opts = {
    bigfile = {
      enabled = true,
      -- Average line length (useful for minified files)
      -- increased from default to handle large json, xml, yaml or toml files
      line_length = 250000,
    },
  },
}
