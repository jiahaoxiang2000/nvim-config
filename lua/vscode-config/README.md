# VSCode Neovim Configuration

This configuration uses the `vscode-neovim` extension to enhance VSCode with Neovim capabilities, featuring colorblind-friendly highlighting and optimized plugin integrations.

- references: [astro community tested plugin](https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/recipes/vscode/init.lua)

## Project Structure

```
vscode-config/
├── index.lua           # Main entry point with lazy.nvim setup, highlight configuration, and yank highlighting
├── keymaps.lua         # Comprehensive VSCode API integration keybindings
├── config/
│   └── options.lua     # Basic vim options and VSCode-specific settings
└── plugins/
    ├── flash.lua       # Flash navigation plugin
    ├── surround.lua    # Text surround operations
    ├── treewalker.lua  # Treesitter-based movement and swapping
    └── highlights.lua  # Advanced highlighting plugins (vim-illuminate, hlslens, vim-highlighter)
```

## Current Features

### ✅ Accessibility Features

- **Colorblind-Friendly Highlights**: Custom highlight groups designed for accessibility
  - High contrast color combinations
  - Avoids problematic red/green combinations
  - Uses bold styling for better visibility
  - Bright yellow yank highlighting with 500ms timeout
  - Custom search highlighting (blue/orange)
  - 6 distinct manual highlighter colors (blue, orange, purple, yellow, black/white, brown)

### ✅ Visual Enhancements

- **Word Highlighting**: Via `vim-illuminate`

  - Highlights word under cursor across buffer
  - Uses LSP, TreeSitter, and regex providers
  - Custom VSCode-compatible highlight groups
  - Large file optimization (2000+ lines)

- **Search Highlighting**: Via `nvim-hlslens`

  - Enhanced search result visualization
  - Shows search count and position
  - Calm mode for reduced noise
  - Custom keybindings for navigation

- **Manual Highlighting**: Via `vim-highlighter`
  - `f<Enter>` - Highlight word under cursor
  - `f<BS>` - Remove highlight from word
  - `f<C-l>` - Clear all highlights
  - `f<Tab>` - Find/navigate highlights
  - `<S-M-j>` / `<S-M-k>` - Navigate between highlights

### ✅ Navigation Features

- **Flash Navigation**: Enhanced with `flash.nvim`

  - `s` - Flash jump to character
  - `S` - Flash treesitter selection
  - `r` - Remote flash (operator-pending mode)
  - `R` - Treesitter search (visual/operator-pending mode)
  - `<C-s>` - Toggle flash search (command mode)

- **Enhanced Motions**: Custom motion improvements
  - Optimized for VSCode environment
  - Seamless integration with VSCode navigation

### ✅ Editing Features

- **Text Surround Operations**: Enhanced with `nvim-surround`

  - `ys` - Add surround in normal mode
  - `yss` - Add surround to current line
  - `yS` / `ySS` - Add surround with newlines
  - `S` - Add surround in visual mode
  - `ds` - Delete surround
  - `cs` - Change surround
  - Aliases: `b` **()**, `i` _text_

- **Treesitter Movement**: Enhanced with `treewalker.nvim`
  - `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` - Navigate syntax tree (left/down/up/right)
  - `<C-S-h>` / `<C-S-j>` / `<C-S-k>` / `<C-S-l>` - Swap nodes in syntax tree
  - Brief highlight on jump (250ms duration)
  - Automatic jumplist management for movements > 1 line
  - Treesitter-aware navigation for precise code movement

### ✅ System Integration

- **Yank Highlighting**: Custom implementation

  - Bright yellow background for maximum visibility
  - 500ms timeout duration
  - Colorblind-friendly color scheme
  - Auto-reapplies on colorscheme changes

- **Performance Optimizations**:
  - Lazy loading for all plugins
  - Disabled unnecessary vim plugins for VSCode
  - Efficient highlight group management
  - Large file handling optimizations

### ⌨️ Built-in Custom Keybindings

The configuration includes a comprehensive set of custom keybindings that integrate Neovim with VSCode features:

#### File Management & Navigation

- `<leader>e` - Toggle and focus file explorer
- `<leader>fr` - Open recent files

#### Search & Replace

- `<leader>sr` - Find and replace word under cursor
- `<leader>sf` - Search word under cursor in files (normal), search selection in files (visual)

#### Code Actions & Refactoring

- `<leader>ca` - Code actions (quick fix) - supports normal and visual modes
- `<leader>cr` - Refactor selection - supports normal and visual modes
- `<leader>cf` - Format document (normal), format selection (visual)
- `gd` - Go to definition
- `gi` - Go to implementation
- `gr` - Go to references
- `gh` - Show hover information

#### Terminal & Tasks

- `<leader>tt` - Toggle integrated terminal
- `<leader>tr` - Run task

#### Window & Panel Management

- `<leader>wv` - Split editor vertically and focus
- `<leader>ws` - Split editor horizontally and focus

#### Git Integration

- `<leader>gs` - Open source control
- `<leader>gc` - Commit staged changes
- `<leader>gp` - Git push
- `<leader>gl` - Git pull
- `gs` (visual mode) - Stage selected lines

#### Diagnostic Navigation

- `]d` - Go to next diagnostic
- `[d` - Go to previous diagnostic
- `]c` - Go to next change in compare/diff editor
- `[c` - Go to previous change in compare/diff editor

#### Advanced Workflows

- `<leader>wa` - Save all and format document
- `<leader>fi` - Show current file information (displays file name, line count, language, and selection status)

**Note**: All custom keybindings use the VSCode API for seamless integration and include proper insert mode handling with `vscode.with_insert()` where appropriate. The keybindings are organized into logical sections for better workflow integration. These keybindings are defined in `keymaps.lua` and loaded automatically.

## Highlight Color Palette (Colorblind-Friendly)

| Purpose        | Background         | Foreground        | Notes                 |
| -------------- | ------------------ | ----------------- | --------------------- |
| Yank Highlight | `#ffff00` (Yellow) | `#000000` (Black) | Maximum visibility    |
| Search Match   | `#0066cc` (Blue)   | `#ffffff` (White) | High contrast         |
| Search Current | `#ff9900` (Orange) | `#000000` (Black) | Distinct from matches |
| Highlighter 0  | `#0066cc` (Blue)   | `#ffffff` (White) | Primary               |
| Highlighter 1  | `#ff9900` (Orange) | `#000000` (Black) | Secondary             |
| Highlighter 2  | `#9900cc` (Purple) | `#ffffff` (White) | Tertiary              |
| Highlighter 3  | `#ffff00` (Yellow) | `#000000` (Black) | Quaternary            |
| Highlighter 4  | `#000000` (Black)  | `#ffffff` (White) | High contrast         |
| Highlighter 5  | `#663300` (Brown)  | `#ffffff` (White) | Earth tone            |

## Installation

1. Ensure you have the `vscode-neovim` extension installed in VSCode
2. Place this configuration in your Neovim config directory
3. Restart VSCode or reload the window
4. All plugins will be automatically installed via lazy.nvim

## Keybinding Configuration

### Default Keybindings

The `vscode-neovim` extension provides default keybindings through its `package.json` configuration. Here are the main categories of default keybindings:

#### Core Neovim Keys

- **Escape sequences**: `Ctrl+[`, `Ctrl+C`, `Escape` - Exit insert mode or cancel operations
- **Basic movement**: `h`, `j`, `k`, `l`, arrow keys, `Home`, `End`
- **Modifier keys**: `Shift` + movement keys for selection
- **Special keys**: `Tab`, `Shift+Tab`, `Backspace`, `Delete`

#### Ctrl Key Combinations (Normal Mode)

**Enabled by default**: `Ctrl+A`, `Ctrl+B`, `Ctrl+C`, `Ctrl+D`, `Ctrl+E`, `Ctrl+F`, `Ctrl+H`, `Ctrl+I`, `Ctrl+J`, `Ctrl+K`, `Ctrl+L`, `Ctrl+M`, `Ctrl+O`, `Ctrl+R`, `Ctrl+T`, `Ctrl+U`, `Ctrl+V`, `Ctrl+W`, `Ctrl+X`, `Ctrl+Y`, `Ctrl+Z`, `Ctrl+/`, `Ctrl+]`, arrow keys with Ctrl

#### Ctrl Key Combinations (Insert Mode)

**Enabled by default**: `Ctrl+A`, `Ctrl+C`, `Ctrl+D`, `Ctrl+H`, `Ctrl+J`, `Ctrl+M`, `Ctrl+O`, `Ctrl+R`, `Ctrl+T`, `Ctrl+U`, `Ctrl+W`

#### List Navigation (Explorer, Quick Open, etc.)

- **Vim-style movement**: `j`/`k` (down/up), `h`/`l` (collapse/expand)
- **Quick navigation**: `G G` (top), `Shift+G` (bottom), `Ctrl+U`/`Ctrl+D` (page up/down)
- **Actions**: `Enter` (select), `o` (toggle expand), `/` (find)

#### File Explorer Specific

- **File operations**: `r` (rename), `d` (delete), `y` (copy), `x` (cut), `p` (paste)
- **Create**: `a` (new file), `Shift+A` (new folder)
- **View**: `v` (open to side), `Shift+R` (refresh)

#### Window Management (`Ctrl+W` prefix)

- **Navigation**: `Ctrl+W` + `h`/`j`/`k`/`l` or arrow keys
- **Splitting**: `Ctrl+W` + `s` (horizontal), `Ctrl+W` + `v` (vertical)
- **Sizing**: `Ctrl+W` + `=` (equal), `Ctrl+W` + `_` (maximize height)
- **Resize**: `Ctrl+W` + `+`/`-` (height), `Ctrl+W` + `<`/`>` (width)
- **Close**: `Ctrl+W` + `q`

#### Command Line Mode (`neovim.mode == cmdline`)

- **Navigation**: `Tab`/`Shift+Tab`, arrow keys, `Ctrl+N`/`Ctrl+P`
- **Editing**: `Ctrl+H`, `Ctrl+W`, `Ctrl+U` for deletion
- **Register access**: `Ctrl+R` + register key (0-9, a-z, symbols)

#### Output Panel Navigation

When focused on output panel, all standard Vim keys (`a`-`z`, `0`-`9`, movement, etc.) are passed to Neovim

#### Context-Sensitive Bindings

- **Hover widgets**: Vim navigation (`j`/`k`/`h`/`l`), scrolling (`Ctrl+F`/`Ctrl+B`/`Ctrl+D`/`Ctrl+U`)
- **Suggestions**: `Ctrl+N`/`Ctrl+P` for next/previous
- **Parameter hints**: `Ctrl+N`/`Ctrl+P` for multiple signatures
- **Quick open**: `Ctrl+N`/`Ctrl+P` for selection navigation

**Note**: All keybindings include conditions like `neovim.init`, `editorTextFocus`, and `neovim.mode` to ensure they only activate in appropriate contexts. The `editorLangIdExclusions` setting can disable bindings for specific file types.

### Customizing Keybindings

To customize or override the default keybindings, you have two approaches:

#### Method 1: VS Code Keybindings (`keybindings.json`)

For simple key remapping and VS Code integration:

1. **Open VS Code Keybindings**:

   - Command Palette: `Ctrl+Shift+P` → "Preferences: Open Keyboard Shortcuts (JSON)"
   - Or go to File → Preferences → Keyboard Shortcuts, then click the "Open Keyboard Shortcuts (JSON)" icon

2. **File Location**: `~/.config/Code/User/keybindings.json` (Linux)

3. **Example Overrides**:

```json
[
  {
    "key": "ctrl+j",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.mode == normal",
    "args": "<C-j>",
    "description": "Override default Ctrl+J behavior"
  },
  {
    "key": "alt+s",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.mode == normal",
    "args": "s",
    "description": "Alternative key for Flash navigation"
  }
]
```

#### Method 2: Neovim + VSCode API (Built-in Integration)

Advanced integrations that combine Neovim functionality with VS Code features are **built into this configuration** using the VSCode API. All the keybindings listed in the "Built-in Custom Keybindings" section above are ready to use out of the box.

**VSCode API Functions Available**:

- **`vscode.action(name, opts)`** - Execute VS Code commands asynchronously
- **`vscode.call(name, opts, timeout)`** - Execute VS Code commands synchronously
- **`vscode.notify(msg)`** - Show VS Code notifications
- **`vscode.get_config(name)`** / **`vscode.update_config(name, value, target)`** - Manage VS Code settings
- **`vscode.eval(code, opts, timeout)`** - Execute JavaScript in VS Code context
- **`vscode.with_insert(callback, ms)`** - Perform operations in insert mode

**Example Usage**:

```lua
local vscode = require('vscode')

-- Custom find and replace with word under cursor
vim.keymap.set('n', '<leader>fr', function()
  local word = vim.fn.expand('<cword>')
  vscode.action('editor.action.startFindReplaceAction', {
    args = { searchString = word }
  })
end, { desc = 'Find and replace word under cursor' })
```

**Disabling Default Keybindings**:

```json
[
  {
    "key": "s",
    "command": "-vscode-neovim.send",
    "when": "editorTextFocus && neovim.mode == normal"
  }
]
```

### Debugging Keybindings

Use these VS Code commands for troubleshooting keybinding conflicts:

- `Developer: Toggle Keyboard Shortcuts Troubleshooting` - Traces keypress processing
- `Developer: Inspect Key Mapping` - Shows current keyboard layout mappings
- Check the Output panel → "vscode-neovim" for extension logs

## Usage

1. Ensure you have the `vscode-neovim` extension installed in VS Code
2. Place this configuration in your Neovim config directory
3. Restart VS Code or reload the window
4. All plugins and custom keybindings will be automatically loaded
5. Use the built-in custom keybindings (see ⌨️ Built-in Custom Keybindings section) for enhanced workflow
