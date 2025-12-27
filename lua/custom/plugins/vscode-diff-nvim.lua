return {
  'esmuellert/vscode-diff.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'folke/snacks.nvim',
  },
  cmd = 'CodeDiff',
  keys = {
    {
      '<leader>gdb',
      function()
        Snacks.picker.pick {
          source = 'git_log_file',
          format = 'git_branch',
          preview = 'git_show',
          confirm = function(picker, item)
            local target = item.commit
            vim.cmd('CodeDiff file ' .. target)
          end,
        }
      end,
      desc = '[F]ile',
    },
    {
      '<leader>gdl',
      function()
        Snacks.picker.pick {
          source = 'git_log_line',
          format = 'git_branch',
          preview = 'git_show',
          confirm = function(picker, item)
            local target = item.commit
            vim.cmd('CodeDiff file ' .. target)
          end,
        }
      end,
      desc = '[L]ine',
    },
    {
      '<leader>gdi',
      function()
        Snacks.picker.pick {
          multi = { 'git_branches', 'git_log' },
          format = 'git_branch',
          preview = 'git_show',
          confirm = function(picker, item)
            local target = nil
            if item.branch then
              target = item.branch
            else
              target = item.commit
            end
            vim.cmd('CodeDiff ' .. target)
          end,
        }
      end,
      desc = '[I]ndex',
    },
  },
}
