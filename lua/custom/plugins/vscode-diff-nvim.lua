-- Based on: https://www.reddit.com/r/neovim/comments/1prctpf/integrating_snackspicker_with_vscodediffnvim_a/
local function walk_in_codediff(picker, item)
  Snacks = require 'snacks'
  picker:close()
  if item.commit then
    local target = nil
    if item.branch then
      target = item.branch
    else
      target = item.commit
    end

    vim.fn.setreg('+', target)
    vim.notify('Copied: ' .. target)
    -- get parent / previous commit
    local parent_commit = vim.trim(vim.fn.system('git rev-parse --short ' .. target .. '^'))
    parent_commit = parent_commit:match '[a-f0-9]+'
    -- Check if command failed (e.g., Initial commit has no parent)
    if vim.v.shell_error ~= 0 then
      vim.notify('Cannot find parent (Root commit?)', vim.log.levels.WARN)
      parent_commit = ''
    end
    local cmd = string.format('CodeDiff %s %s', parent_commit, target)
    vim.notify('Diffing: ' .. parent_commit .. ' -> ' .. target)
    vim.cmd(cmd)
  end
end

local function execute_git_pickaxe(query, is_global, current_file)
  if not query or query == '' then
    return
  end

  local title_scope = is_global and 'Global' or vim.fn.fnamemodify(current_file, ':t')

  -- set keyword highlight within Snacks.picker
  vim.fn.setreg('/', query)
  local old_hl = vim.opt.hlsearch
  vim.opt.hlsearch = true

  local args = {
    'log',
    '-G' .. query,
    '-i',
    '--pretty=format:%C(yellow)%h%Creset %s %C(green)(%cr)%Creset %C(blue)<%an>%Creset',
    '--abbrev-commit',
    '--date=short',
  }

  if not is_global then
    table.insert(args, '--')
    table.insert(args, current_file)
  end

  Snacks.picker {
    title = 'Git Log: "' .. query .. '" (' .. title_scope .. ')',
    finder = 'proc',
    cmd = 'git',
    args = args,

    transform = function(item)
      local clean_text = item.text:gsub('\27%[[0-9;]*m', '')
      local hash = clean_text:match '^%S+'
      if hash then
        item.commit = hash
        if not is_global then
          item.file = current_file
        end
      end
      return item
    end,

    preview = 'git_show',
    confirm = walk_in_codediff,
    format = 'text',

    on_close = function()
      -- remove keyword highlight
      vim.opt.hlsearch = old_hl
      vim.cmd 'noh'
    end,
  }
end

local function git_pickaxe(opts)
  opts = opts or {}
  local is_global = opts.global or false
  local current_file = vim.api.nvim_buf_get_name(0)

  -- Force global if current buffer is invalid
  if not is_global and (current_file == '' or current_file == nil) then
    vim.notify('Buffer is not a file, switching to global search', vim.log.levels.WARN)
    is_global = true
  end

  -- If query provided, execute directly
  if opts.query then
    execute_git_pickaxe(opts.query, is_global, current_file)
  else
    -- Otherwise prompt for query
    local title_scope = is_global and 'Global' or vim.fn.fnamemodify(current_file, ':t')
    vim.ui.input({ prompt = 'Git Search (-G) in ' .. title_scope .. ': ' }, function(query)
      execute_git_pickaxe(query, is_global, current_file)
    end)
  end
end

return {
  'esmuellert/vscode-diff.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'folke/snacks.nvim',
  },
  cmd = 'CodeDiff',
  keys = {
    {
      '<leader>gdf',
      function()
        Snacks.picker.git_log_file {
          confirm = walk_in_codediff,
        }
      end,
      desc = '[F]ile',
    },
    {
      '<leader>gdl',
      function()
        Snacks.picker.git_log_line {
          confirm = walk_in_codediff,
        }
      end,
      desc = '[L]ine',
    },
    {
      '<leader>gdc',
      function()
        Snacks.picker.pick {
          multi = { 'git_branches', 'git_log' },
          format = 'git_branch',
          preview = 'git_show',
          confirm = walk_in_codediff,
        }
      end,
      desc = '[C]ommits',
    },
    {
      '<leader>gds',
      function()
        local query = ''
        local mode = vim.fn.mode()
        if mode == 'v' or mode == 'V' or mode == '\22' then
          vim.cmd 'normal! y'
          query = vim.fn.getreg '"'
        end
        git_pickaxe { global = false, query = query }
      end,
      mode = { 'n', 'x' },
      desc = '[S]earch (Buffer)',
    },
    {
      '<leader>gdS',
      function()
        local query = ''
        local mode = vim.fn.mode()
        if mode == 'v' or mode == 'V' or mode == '\22' then
          vim.cmd 'normal! y'
          query = vim.fn.getreg '"'
        end
        git_pickaxe { global = true, query = query }
      end,
      mode = { 'n', 'x' },
      desc = '[S]earch (Global)',
    },
  },
}
