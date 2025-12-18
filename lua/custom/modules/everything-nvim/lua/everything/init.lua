local M = {}

local es_config = {
  es_path = 'es',
  max_results = 100,
}

local getCmdOpts = function(opts)
  local command_params = {}
  if opts.case_sensitive then
    table.insert(command_params, '-case')
  end
  if opts.whole_word then
    table.insert(command_params, '-whole-word')
  end
  if opts.match_path then
    table.insert(command_params, '-match-path')
  end
  if opts.sort then
    table.insert(command_params, '-s')
  end
  if opts.offset then
    table.insert(command_params, '-offset')
    table.insert(command_params, tostring(opts.offset))
  end
  if opts.max_results then
    table.insert(command_params, '-max-results')
    table.insert(command_params, tostring(opts.max_results))
  end

  return command_params
end

M.gitRepo = function(opts, ctx)
  opts = vim.tbl_deep_extend('force', es_config, opts or {})
  local cmdOpts = getCmdOpts(opts)
  local cmd = opts.es_path
  local cmdArgs = vim.iter({ command_params, '-p', '-r', 'child:^\\.git$' }):flatten():totable()

  Snacks.picker.pick {
    finder = function(opts, ctx)
      return require('snacks.picker.source.proc').proc(
        ctx:opts {
          cmd = cmd,
          args = cmdArgs,
          ---@param item snacks.picker.finder.Item
          transform = function(item)
            -- item.text contains command output line
            item.file = item.text
            item.cwd = opts.cwd
            -- return false to skip item
            -- return item to include modified item
          end,
        },
        ctx
      )
    end,
    format = 'text',
    preview = 'file',
    confirm = 'jump',
  }
end

M.setup = function() end

return M
