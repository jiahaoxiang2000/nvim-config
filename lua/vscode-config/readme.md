# VSCode Neovim Configuration

This configuration uses the `vscode-neovim` extension to enhance VSCode with Neovim capabilities.

## Project Structure

```
vscode-config/
├── index.lua           # Main entry point with lazy.nvim setup
├── config/
│   └── options.lua     # Basic vim options and VSCode-specific settings
└── plugins/
    ├── init.lua        # Auto-loads all plugin files
    ├── flash.lua       # Flash navigation plugin
    ├── surround.lua    # Text surround operations
    ├── editing.lua     # Additional editing utilities
    ├── motions.lua     # Motion enhancements
    ├── multi-cursor.lua # Multi-cursor support (currently disabled)
    └── snippet.lua     # Snippet support (currently disabled)
```

## Current Features

### ✅ Implemented Features

- **Flash Navigation**: Use `[flash.nvim](https://github.com/folke/flash.nvim)` for quick character-based navigation

  - `s` - Flash jump
  - `S` - Flash treesitter
  - `r` - Remote flash (operator-pending mode)
  - `R` - Treesitter search (visual/operator-pending mode)
  - `<C-s>` - Toggle flash search (command mode)

- **Text Surround Operations**: Enhanced with `nvim-surround`

  - `ys` - Add surround in normal mode
  - `yss` - Add surround to current line
  - `yS` / `ySS` - Add surround with newlines
  - `S` - Add surround in visual mode
  - `ds` - Delete surround
  - `cs` - Change surround
  - Aliases: `b` **x**, `i` _x_

- **Editing Enhancements**:

  - `vim-surround` - Additional surround operations
  - `ReplaceWithRegister` - Replace text with register content
  - `vim-repeat` - Repeat plugin actions with `.`

- **Basic Configuration**:
  - Clipboard integration with system clipboard
  - Smart case-insensitive search

### 🔄 Plugin Management

- Uses `lazy.nvim` for efficient plugin management
- Lazy loading enabled for better performance
- Auto-discovery of plugin files in the `plugins/` directory
- Disabled unnecessary default vim plugins for VSCode environment

### ⚠️ Currently Disabled Features

- **Multi-cursor support**: Commented out due to compatibility issues
- **Snippet support**: Disabled due to conflicts with completion systems

## Mode Reference

- **"n"**: Normal mode
- **"x"**: Visual mode
- **"o"**: Operator-pending mode
- **"c"**: Command-line mode

## Installation

1. Ensure you have the `vscode-neovim` extension installed in VSCode
2. Place this configuration in your Neovim config directory
3. Restart VSCode or reload the window

## Development Notes

- The configuration is designed specifically for VSCode integration
- Performance optimizations included for VSCode environment
- Modular plugin structure allows easy addition/removal of features
- All plugins are configured with VSCode compatibility in mind
