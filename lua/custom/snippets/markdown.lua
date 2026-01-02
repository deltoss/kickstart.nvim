---@diagnostic disable: undefined-global
return {
  s(
    'Callout (GitHub)',
    fmt(
      [[
> [!{}] {}
> {}
]],
      {
        c(1, { t 'NOTE', t 'WARNING', t 'TIP', t 'IMPORTANT', t 'CAUTION' }),
        i(2, 'Title'),
        i(3, 'Content'),
      }
    )
  ),

  s(
    'Callout (Custom)',
    fmt(
      [[
---

> {}
> 
> {}

---
]],
      {
        c(1, { t '💡 Tip', t '⚠️ Warning', t '⚠️ Important', t '📚 External Resources' }),
        i(2, 'Content'),
      }
    )
  ),

  s('💡 Tip', {
    t { '---', '', '' },
    t { '> 💡 Tip', '' },
    t { '> ', '' },
    t '> ',
    i(1, 'Tip Body'),
    t { '', '', '---', '', '' },
    i(0), -- Last Placeholder, exit Point of the snippet.
  }),

  s('📚 External Resources', {
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

  s(
    'Mermaid Flowchart 🪄',
    fmt(
      [[
```mermaid
flowchart {}
    {}["{}"] --> {}["{}"]
```
]],
      {
        c(1, { t 'TD', t 'LR', t 'TB', t 'RL' }), -- Direction choices
        i(2, 'A'),
        i(3, '🚀 Description'),
        i(4, 'B'),
        i(5, "🔗 <a href='http://google.com'>Link</a>"),
      }
    )
  ),

  s(
    'Mermaid Sequence 🪜',
    fmt(
      [[
```mermaid
sequenceDiagram
    participant {1} as {2}
    participant {3} as {4}
    {5}->>{6}: {7}
    {8}-->>{9}: {10}
```
]],
      {
        i(1, 'Usr'),
        i(2, '👤 User'),
        i(3, 'Sys'),
        i(4, '🤖 System'),
        rep(1),
        rep(3),
        i(5, 'Request'),
        rep(3),
        rep(1),
        i(6, 'Response'),
      }
    )
  ),

  s(
    'Mermaid Flowchart Hyperlink 🔗',
    fmt(
      [[
    {}["🔗 <a href='{}'>{}</a>"]
]],
      {
        i(1, 'B'),
        i(2, 'Url'),
        i(3, 'Description'),
      },
      { dedent = false }
    )
  ),

  s(
    'Mermaid Flowchart Decision 🧩',
    fmt(
      [[
    DecA{{"{}?"}} -->|Yes| DecResA["{}"]
    DecA -->|No| DecResB["{}"]
]],
      {
        i(1, '🧩 Decision'),
        i(2, '🚀 Action A'),
        i(3, '💥 Action B'),
      },
      { dedent = false }
    )
  ),

  s(
    'Mermaid Mindmap ☁️',
    fmt(
      [[
```mermaid
mindmap
  root){}(
    {}
      {}
    {}
      {}
```
]],
      {
        i(1, '🚀 Central Topic'),
        i(2, '🌿 Branch 1'),
        i(3, 'Sub-item'),
        i(4, '🧩 Branch 2'),
        i(5, '["`Sub-item - **Bold**, *Italics*, multiline works too!`"]'),
      }
    )
  ),
}
