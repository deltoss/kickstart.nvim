---@diagnostic disable: undefined-global
return {
  s('> 💡 Tip', {
    t { '---', '', '' },
    t { '> 💡 Tip', '' },
    t { '> ', '' },
    t '> ',
    i(1, 'Tip Body'),
    t { '', '', '---', '', '' },
    i(0), -- Last Placeholder, exit Point of the snippet.
  }),
  s('> 💡 External Resources', {
    t { '---', '', '' },
    t { '> 📚 External Resources', '' },
    t { '> ', '' },
    t '> - [',
    i(1, 'Resource Name'),
    t '](',
    i(2, 'Resource URL'),
    t ')',
    t { '', '', '---', '', '' },
    i(0), -- Last Placeholder, exit Point of the snippet.
  }),
}
