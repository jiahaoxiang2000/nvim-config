# VSCode Neovim Configuration

This configuration uses the `vscode-neovim` extension to enhance VSCode with Neovim capabilities, featuring colorblind-friendly highlighting and optimized plugin integrations.

## Project Structure

```
vscode-config/
├── index.lua           # Main entry point with lazy.nvim setup and highlight configuration
├── config/
│   └── options.lua     # Basic vim options and VSCode-specific settings
└── plugins/
    ├── flash.lua       # Flash navigation plugin
    ├── surround.lua    # Text surround operations
    ├── motions.lua     # Motion enhancements
    ├── multi-cursor.lua # Multi-cursor support
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

- **Multi-cursor Operations**: Enhanced with `vscode-multi-cursor.nvim`
  - `mc` - Create cursor at current position
  - `mcc` - Cancel/Clear all cursors
  - `mi` - Start cursors on the left
  - `mI` - Start cursors on the left edge
  - `ma` - Start cursors on the right
  - `mA` - Start cursors on the right edge
  - `[mc` - Go to previous cursor
  - `]mc` - Go to next cursor
  - `mcs` - Create cursor using flash navigation
  - `mcw` - Create selection using flash navigation

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

### 🔄 Plugin Management

- Uses `lazy.nvim` for efficient plugin management
- Lazy loading enabled for better performance
- Auto-discovery of plugin files in the `plugins/` directory
- VSCode-specific plugin loading with `cond = vim.g.vscode`
- Modular architecture for easy customization

## Highlight Color Palette (Colorblind-Friendly)

| Purpose | Background | Foreground | Notes |
|---------|------------|------------|-------|
| Yank Highlight | `#ffff00` (Yellow) | `#000000` (Black) | Maximum visibility |
| Search Match | `#0066cc` (Blue) | `#ffffff` (White) | High contrast |
| Search Current | `#ff9900` (Orange) | `#000000` (Black) | Distinct from matches |
| Highlighter 0 | `#0066cc` (Blue) | `#ffffff` (White) | Primary |
| Highlighter 1 | `#ff9900` (Orange) | `#000000` (Black) | Secondary |
| Highlighter 2 | `#9900cc` (Purple) | `#ffffff` (White) | Tertiary |
| Highlighter 3 | `#ffff00` (Yellow) | `#000000` (Black) | Quaternary |
| Highlighter 4 | `#000000` (Black) | `#ffffff` (White) | High contrast |
| Highlighter 5 | `#663300` (Brown) | `#ffffff` (White) | Earth tone |

## Mode Reference

- **"n"**: Normal mode
- **"x"**: Visual mode
- **"o"**: Operator-pending mode
- **"c"**: Command-line mode

## Installation

1. Ensure you have the `vscode-neovim` extension installed in VSCode
2. Place this configuration in your Neovim config directory
3. Restart VSCode or reload the window
4. All plugins will be automatically installed via lazy.nvim

## Development Notes

- Configuration is designed specifically for VSCode integration
- All highlight groups use custom VSCode-compatible names
- Colorblind accessibility is a primary design consideration
- Performance optimizations included for VSCode environment
- Modular plugin structure allows easy addition/removal of features
- All plugins are configured with `cond = vim.g.vscode` for proper loading
