return {
  'sphamba/smear-cursor.nvim',
  opts = {
    -- WezTerm renders these glyphs; without it smear approximates with blocks
    -- and leaves stale background cells on layout changes (quickfix, splits).
    legacy_computing_symbols_support = true,
  },
}
