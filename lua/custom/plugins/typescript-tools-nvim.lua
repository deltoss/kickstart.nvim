return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  ft = { 'typescript', 'typescriptreact' },
  opts = {
    settings = {
      -- CodeLens
      -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
      -- possible values: ("off"|"all"|"implementations_only"|"references_only")
      code_lens = 'all',
    },
  },
  keys = {
    {
      '<localleader>d',
      '<cmd>DapNew<cr>',
      desc = '[D]ebug',
      ft = { 'typescript', 'typescriptreact' },
    },
    {
      '<localleader><down>',
      '<cmd>DapContinue<cr>',
      desc = 'Continue',
      ft = { 'typescript', 'typescriptreact' },
    },

    {
      '<localleader>s',
      '<cmd>TSToolsGoToSourceDefinition<cr>',
      desc = 'Go To [S]ource Definition',
      ft = { 'typescript', 'typescriptreact' },
    },

    {
      '<localleader>r',
      '<cmd>TSToolsRenameFile<cr>',
      desc = '[R]ename File', -- Allow to rename current file and apply changes to connected files
      ft = { 'typescript', 'typescriptreact' },
    },
    {
      '<localleader>R',
      '<cmd>TSToolsFileReferences<cr>',
      desc = 'Find [R]eferences to File', -- Find files that reference the current file
      ft = { 'typescript', 'typescriptreact' },
    },

    {
      '<localleader>o',
      '<cmd>TSToolsOrganizeImports<cr>',
      desc = '[O]rganize Imports', -- Sort and removed unused imports
      ft = { 'typescript', 'typescriptreact' },
    },
    {
      '<localleader>u',
      '<cmd>TSToolsRemoveUnused<cr>',
      desc = 'Remove [U]nused Statements',
      ft = { 'typescript', 'typescriptreact' },
    },
    {
      '<localleader>m',
      '<cmd>TSToolsAddMissingImports<cr>', -- Adds imports for all statements that lack one and can be imported
      desc = 'Add [M]issing Imports',
      ft = { 'typescript', 'typescriptreact' },
    },
    {
      '<localleader>f',
      '<cmd>TSToolsFixAll<cr>', -- Fixes all fixable errors
      desc = '[F]ix All',
      ft = { 'typescript', 'typescriptreact' },
    },
  },
}
