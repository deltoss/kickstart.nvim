local function open_in_prev_win()
  local line_text = vim.fn.getline '.'
  local col = vim.fn.col '.' -- 1-indexed

  local file, line

  -- Search the current line for file:line patterns, check if cursor overlaps
  local pos = 1
  while pos <= #line_text do
    local s, e, f, l = line_text:find('([%w%.%/%_%-]+):(%d+)', pos)
    if not s then
      break
    end
    if s <= col and col <= e then
      file = f
      line = l
      break
    end
    pos = e + 1
  end

  -- Fallback: no line number, just use the file under cursor
  if not file then
    file = vim.fn.expand '<cfile>'
  end

  if not file or file == '' then
    return
  end
  local stat = vim.uv.fs_stat(vim.fs.normalize(file))
  if not stat or stat.type ~= 'file' then
    return
  end

  vim.cmd 'wincmd p'
  if line then
    vim.cmd('edit +' .. line .. ' ' .. vim.fn.fnameescape(file))
  else
    vim.cmd('edit ' .. vim.fn.fnameescape(file))
  end
end

return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'CodeCompanionChatCreated',
      callback = function(args)
        local chat = require('codecompanion').buf_get_chat(args.data.bufnr)
        if chat then
          chat:add_buf_message {
            role = 'user',
            content = '#{buffer} ',
          }
        end
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'codecompanion',
      callback = function()
        vim.keymap.set('n', 'gf', open_in_prev_win, { buffer = true })
        vim.keymap.set('n', 'gF', open_in_prev_win, { buffer = true })
      end,
    })

    local homeDir = os.getenv 'HOME'
    homeDir = homeDir or os.getenv 'USERPROFIlE'
    local keys = require('custom.utils').read_json_file(homeDir .. '/.config/codecompanion.nvim/api_keys.json')

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd [[cab cc CodeCompanion]]

    require('codecompanion').setup {
      interactions = {
        chat = {
          adapter = {
            name = 'opencode',
          },
          keymaps = {
            fold_code = {
              modes = { n = 'zS' }, -- Default is gf, which conflicts with following a link
            },
            debug = {
              modes = { n = 'gA' }, -- Default is gd, which is going into definitions
              description = 'Show debug messages for the chat',
            },
          },
        },
      },
      adapters = {
        http = {
          anthropic = function()
            local key = keys and keys.anthropic or nil
            return require('codecompanion.adapters').extend('anthropic', {
              env = {
                api_key = key,
              },
            })
          end,
        },
      },
    }
  end,
  keys = {
    {
      '<leader>ac',
      '<cmd>CodeCompanionChat Toggle<cr>',
      desc = '[C]hat',
      mode = { 'n', 'v' },
    },
    {
      '<leader>aa',
      '<cmd>CodeCompanionChat Add<cr>',
      desc = '[A]dd',
      mode = { 'v' },
    },
    {
      '<leader>am',
      function()
        require('codecompanion').prompt 'commit'
      end,
      desc = 'Commit [M]essage',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ae',
      function()
        require('codecompanion').prompt 'explain'
      end,
      desc = '[E]xplain',
      mode = { 'n', 'v' },
    },
    {
      '<leader>af',
      function()
        require('codecompanion').prompt 'fix'
      end,
      desc = '[F]ix',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ad',
      function()
        require('codecompanion').prompt 'lsp'
      end,
      desc = 'Explain LSP [D]iagnostics',
      mode = { 'n', 'v' },
    },
    {
      '<leader>at',
      function()
        require('codecompanion').prompt 'test'
      end,
      desc = 'Generate [T]ests',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ap',
      '<cmd>CodeCompanionActions<cr>',
      desc = '[P]alette',
      mode = { 'n', 'v' },
    },
    {
      '<leader>aC',
      ':CodeCompanionCmd ',
      desc = 'Neovim [C]ommands',
    },
    {
      '<leader>aP',
      ':CodeCompanion /',
      desc = '[P]rompts',
    },
  },
}
