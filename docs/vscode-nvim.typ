#import "@preview/touying:0.6.1": *
#import themes.simple: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5" as fletcher: edge, node
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

// Colorblind-friendly color scheme matching Neovim config
#let highlight-yellow = rgb("#ffff00")  // Yank highlight
#let highlight-blue = rgb("#0066cc")    // Search match / Primary
#let highlight-orange = rgb("#ff9900")  // Search current / Secondary
#let highlight-purple = rgb("#9900cc")  // Tertiary
#let highlight-brown = rgb("#663300")   // Earth tone
#let text-black = rgb("#000000")
#let text-white = rgb("#ffffff")

// Color shorthand functions (colorblind-friendly)
#let yellowt(content) = text(fill: highlight-yellow, weight: "bold", content)
#let bluet(content) = text(fill: highlight-blue, weight: "bold", content)
#let oranget(content) = text(fill: highlight-orange, weight: "bold", content)
#let purplet(content) = text(fill: highlight-purple, weight: "bold", content)
#let brownt(content) = text(fill: highlight-brown, weight: "bold", content)

// Highlight box function for code examples
#let highlight-box(color, content) = [
  #rect(fill: color, stroke: none, inset: 0.3em, radius: 0.2em, text(fill: text-black, weight: "bold", content))
]

// Additional font customization options:
#show heading: set text(weight: "bold")
// #show raw: set text(font: ("JetBrains Mono", "Fira Code", "Source Code Pro", "monospace"))

#show: simple-theme.with(aspect-ratio: "16-9", footer: [VSCode-Neovim Integration])

#title-slide[
  = VSCode-Neovim Integration

  #text(size: 0.9em, style: "italic")[
    Combining the best of both worlds: VSCode's ecosystem with Neovim's editing power
  ]
  #v(1em)

  #text(size: 1.2em)[
    *isomo* #footnote[github/jiahaoxiang2000]
  ]

  #v(1em)

  #datetime.today().display()
]

= Overview

== What is VSCode-Neovim Integration?

#slide(composer: (1fr, 1fr))[
  *Traditional Approach:*
  - Choose between VSCode OR Neovim
  - Limited customization in VSCode

  #pause

  *Problems:*
  - Missing VSCode's language servers
  - Separate workflows
][
  *Integrated Approach:*
  - #bluet[VSCode's ecosystem] + #oranget[Neovim's editing power]
  - Native Neovim instance inside VSCode

  #pause

  *Benefits:*
  - Full Vim modal editing
  - Unified workflow
]


== Architecture Overview

#fletcher-diagram(
  node-stroke: .1em,
  spacing: 2em,

  node((0, 0), [VSCode UI], radius: 2em, fill: highlight-blue.lighten(80%)),

  pause,
  edge((0, 0), (4, 0), [vscode-neovim], "-|>"),
  node((4, 0), [Neovim Instance], radius: 2em, fill: highlight-orange.lighten(80%)),

  pause,
  edge((4, 0), (7, -0.5), [Lua Config], "-|>"),
  node((7, -0.5), [Custom Plugins], radius: 2em, fill: highlight-purple.lighten(80%)),

  pause,
  edge((4, 0), (7, 0.5), [VSCode API], "-|>"),
  node((7, 0.5), [VSCode Features], radius: 2em, fill: highlight-yellow.lighten(80%)),
)


== Key Components

#grid(
  columns: 2,
  gutter: 2em,

  [
    *Core Integration:*
    - #bluet[vscode-neovim] extension
    - Bidirectional communication

    #pause

    *Neovim Plugins:*
    - #oranget[flash.nvim] - Enhanced navigation
    - #purplet[nvim-surround] - Text objects
    - #brownt[treewalker.nvim] - Syntax-aware movement
  ],

  [
    *VSCode Features:*
    - IntelliSense & auto-completion
    - Integrated debugging
    - Extension marketplace

    #pause

    *Custom Enhancements:*
    - #yellowt[Colorblind-friendly] highlighting
    - #bluet[API-integrated] keybindings
    - #oranget[Performance optimizations]
  ],
)


= Colorblind-Friendly Highlighting

== Accessibility-First Design

#slide(composer: (1fr, 1fr))[
  *Traditional Highlighting Problems:*
  - Red/green combinations
  - Low contrast ratios
  - Insufficient differentiation

  #pause

  *Impact on Users:*
  - 8% of men have color vision deficiency
  - Accessibility barriers
][
  *Our Solution:*
  - High contrast color palette
  - Bold text styling
  - Multiple visual cues

  #pause

  *Benefits:*
  - Universal accessibility
  - Better visibility
  - Consistent experience
]


== Color Palette Design

#table(
  columns: 4,
  [*Purpose*], [*Color*], [*Hex*], [*Example*],
  [Yank Highlight], [#highlight-box(highlight-yellow, "Yellow")], [`#ffff00`], [Maximum visibility],
  [Primary/Search], [#highlight-box(highlight-blue, "Blue")], [`#0066cc`], [High contrast],
  [Secondary/Current], [#highlight-box(highlight-orange, "Orange")], [`#ff9900`], [Distinct from blue],
  [Tertiary], [#highlight-box(highlight-purple, "Purple")], [`#9900cc`], [Accessible purple],
  [Alternative], [#highlight-box(highlight-brown, "Brown")], [`#663300`], [Earth tone],
)


== Implementation Examples

#slide(composer: (1fr, 1fr))[
  *Yank Highlighting:*
  ```lua
  -- 500ms timeout for visibility
  vim.api.nvim_set_hl(0, "YankHighlight", {
    bg = "#ffff00",
    fg = "#000000",
    bold = true
  })
  ```
][
  *Manual Highlighting:*
  ```lua
  -- 6 distinct colors for manual highlights
  local colors = {
    "#0066cc", "#ff9900", "#9900cc",
    "#ffff00", "#000000", "#663300"
  }
  ```
]


= Custom Keybindings & VSCode API

== File Management & Navigation

#table(
  columns: 3,
  [*Keybinding*], [*Command*], [*Description*],
  [`<leader>e`], [Toggle Explorer], [Focus file explorer],
  [`<leader>fr`], [Recent Files], [Open recent files picker],
  [`<leader>sr`], [Find & Replace], [Replace word under cursor],
  [`<leader>sf`], [Search in Files], [Search word/selection in files],
)


== Code Actions & Refactoring

#table(
  columns: 3,
  [*Keybinding*], [*Command*], [*Description*],
  [`<leader>ca`], [Code Actions], [Quick fix menu (normal/visual)],
  [`<leader>cr`], [Refactor], [Refactor selection/symbol],
  [`<leader>cf`], [Format], [Format document/selection],
  [`gd`], [Go to Definition], [Navigate to definition],
  [`gi`], [Go to Implementation], [Navigate to implementation],
  [`gr`], [Go to References], [Find all references],
)

== VSCode API Integration

*Core API Functions:*
```lua
local vscode = require('vscode')
-- Execute VSCode commands
vscode.action('workbench.action.files.save')
-- Show notifications
vscode.notify('Custom message')
-- Get/set configuration
vscode.get_config('editor.fontSize')
vscode.update_config('vim.insertModeKeyBindings',
  bindings, 'global')
```
#pagebreak()

*Advanced Usage:*
```lua
-- Custom find and replace
vim.keymap.set('n', '<leader>fr', function()
  local word = vim.fn.expand('<cword>')
  vscode.action('editor.action.startFindReplaceAction', {
    args = { searchString = word }
  })
end)
```


= Plugin Ecosystem

== Navigation Enhancement

#slide(composer: (1fr, 1fr))[
  *Flash Navigation (flash.nvim):*
  - #oranget[`s`] - Flash jump to character
  - #oranget[`S`] - Flash treesitter selection
  - #oranget[`r`] - Remote flash (operator-pending)
  - #oranget[`R`] - Treesitter search (visual mode)
  - #oranget[`<C-s>`] - Toggle flash search (command mode)

][
  *Treewalker Movement (treewalker.nvim):*
  - #purplet[`<C-h/j/k/l>`] - Navigate syntax tree
  - #purplet[`<C-S-h/j/k/l>`] - Swap nodes in tree
  - Brief highlight on jump (250ms)
  - Automatic jumplist management
]

== Text Objects & Editing

#slide(composer: (1fr, 1fr))[
  *Surround Operations (nvim-surround):*
  - #bluet[`ys`] - Add surround (normal mode)
  - #bluet[`yss`] - Add surround to line
  - #bluet[`S`] - Add surround (visual mode)
  - #bluet[`ds`] - Delete surround
  - #bluet[`cs`] - Change surround

][
  *Highlighting System (vim-illuminate):*
  - Highlights word under cursor
  - Uses LSP, TreeSitter, regex
  - Large file optimization (2000+ lines)
  - Custom VSCode-compatible highlights

]

= Configuration & Setup

== Installation & Setup

#slide(composer: (1fr, 1fr))[
  *VSCode Extension:*
  1. Install `vscode-neovim` extension
  2. Ensure Neovim is in PATH
  3. Configure extension settings
][
  *Neovim Configuration:*
  ```lua
  -- vscode-config/index.lua
  if vim.g.vscode then
    require('vscode-config.config.options')
    require('vscode-config.keymaps')
    require('vscode-config.plugins')
  end
  ```
]

== Troubleshooting

#table(
  columns: 2,
  [*Issue*], [*Solution*],
  [Extension not loading], [Check Neovim PATH and version],
  [Keybindings conflicts], [Use VSCode keybindings.json to override],
  [Performance issues], [Disable heavy plugins in VSCode mode],
  [Highlighting not working], [Check colorscheme compatibility],
  [Plugin errors], [Use conditional loading: `if vim.g.vscode`],
)

#pause

*Common Debug Commands:*
- `:checkhealth` - Check Neovim configuration
- `:lua print(vim.g.vscode)` - Verify VSCode detection
- Developer → Toggle Keyboard Shortcuts Troubleshooting


= Resources & References

== Documentation Links

- #bluet[vscode-neovim Extension]: GitHub repository with latest updates
- #oranget[Neovim Documentation]: Official Neovim user manual
- #purplet[VSCode API Reference]: Complete command and settings reference
- #brownt[Plugin Documentation]: Individual plugin repositories

== Community & Support

- AstroNvim Community: Tested VSCode integration recipes
- Neovim Discord: Active community for troubleshooting
- VSCode-Neovim Discussions: Extension-specific help

#v(2em)

#align(center)[
  *Thank you for using VSCode-Neovim Integration!*

  #text(size: 0.9em, style: "italic")[
    Questions? Check the repositories at github.com/jiahaoxiang2000
  ]
]
