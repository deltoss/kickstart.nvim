local filetypes = { 'typescript', 'typescriptreact' }

return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  ft = filetypes,
  opts = {
    root_dir = function(bufnr, on_dir)
      if vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc', 'deno.lock' }) then
        return
      end

      on_dir(vim.fs.root(bufnr, { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' }) or vim.fn.getcwd())
    end,
  },
  keys = {
    {
      '<localleader>d',
      '<cmd>DapNew<cr>',
      desc = '[D]ebug',
      ft = filetypes,
    },
    {
      '<localleader><down>',
      '<cmd>DapContinue<cr>',
      desc = 'Continue',
      ft = filetypes,
    },

    {
      '<localleader>s',
      '<cmd>TSToolsGoToSourceDefinition<cr>',
      desc = 'Go To [S]ource Definition',
      ft = filetypes,
    },

    {
      '<localleader>r',
      '<cmd>TSToolsRenameFile<cr>',
      desc = '[R]ename File', -- Allow to rename current file and apply changes to connected files
      ft = filetypes,
    },
    {
      '<localleader>R',
      '<cmd>TSToolsFileReferences<cr>',
      desc = 'Find [R]eferences to File', -- Find files that reference the current file
      ft = filetypes,
    },

    {
      '<localleader>o',
      '<cmd>TSToolsOrganizeImports<cr>',
      desc = '[O]rganize Imports', -- Sort and removed unused imports
      ft = filetypes,
    },
    {
      '<localleader>u',
      '<cmd>TSToolsRemoveUnused<cr>',
      desc = 'Remove [U]nused Statements',
      ft = filetypes,
    },
    {
      '<localleader>m',
      '<cmd>TSToolsAddMissingImports<cr>', -- Adds imports for all statements that lack one and can be imported
      desc = 'Add [M]issing Imports',
      ft = filetypes,
    },
    {
      '<localleader>f',
      '<cmd>TSToolsFixAll<cr>', -- Fixes all fixable errors
      desc = '[F]ix All',
      ft = filetypes,
    },
  },
}
