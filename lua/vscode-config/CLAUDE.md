# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a VSCode Neovim configuration designed for the `vscode-neovim` extension. It provides enhanced Neovim capabilities within VSCode with a focus on colorblind accessibility, performance optimization, and comprehensive VSCode integration.

## Architecture

### Core Structure

- **`index.lua`**: Main entry point that bootstraps lazy.nvim, sets up custom highlight groups, configures yank highlighting, and loads all modules
- **`config/options.lua`**: Basic Neovim options and VSCode-specific settings (leader keys, clipboard, case sensitivity)
- **`keymaps.lua`**: Comprehensive VSCode API integration keybindings for file management, code actions, git operations, and workflow automation
- **`plugins/`**: Modular plugin configurations using lazy.nvim

### Plugin Architecture

All plugins are configured with:

- `cond = vim.g.vscode` for proper VSCode-only loading
- Lazy loading via `event = "VeryLazy"` or `event = "BufRead"`
- Custom VSCode-compatible highlight groups
- Integration with VSCode commands via the vscode-neovim API

### Key Plugins

1. **`flash.lua`**: Jump navigation with fuzzy search (`s`, `S`, `r`, `R`, `<C-s>`)
2. **`surround.lua`**: Text surrounding operations (`ys`, `ds`, `cs`, `S` in visual mode)
3. **`highlights.lua`**: Three highlighting systems:
   - `vim-illuminate`: Word highlighting under cursor
   - `nvim-hlslens`: Enhanced search highlighting
   - `vim-highlighter`: Manual highlighting with colorblind-friendly colors

## Key Features

### Accessibility Design

The configuration prioritizes colorblind accessibility:

- High contrast color combinations avoiding red/green
- Bold styling for better visibility
- 6 distinct manual highlighter colors (blue, orange, purple, yellow, black/white, brown)
- Custom VSCode-compatible highlight groups

### VSCode Integration

Extensive VSCode API integration via `keymaps.lua`:

- File management (`<leader>e`, `<leader>fr`)
- Search & replace (`<leader>sr`, `<leader>sf`)
- Code actions (`<leader>ca`, `<leader>cr`, `<leader>cf`)
- Git operations (`<leader>gs`, `<leader>gc`, `<leader>gp`, `<leader>gl`)
- Window management (`<leader>wv`, `<leader>ws`)
- Terminal integration (`<leader>tt`, `<leader>tr`)
- Custom workflows (`<leader>wa`, `<leader>fi`)

## Configuration Patterns

### Adding New Plugins

1. Create new file in `plugins/` directory
2. Configure custom highlight groups linking to VSCode\* highlights
3. Use lazy loading with appropriate events

### Adding New Keybindings

1. Edit `keymaps.lua`
2. Use `vscode.action()` for VSCode commands
3. Use `vscode.with_insert()` for insert mode compatibility
4. Include descriptive `desc` fields

### Custom Highlight Groups

All custom highlights follow `VSCode*` naming:

- `VSCodeYankHighlight`: Yank operations
- `VSCodeIlluminatedWord`: Word highlighting
- `VSCodeSearchMatch`: Search results
- `VSCodeHighlighter0-5`: Manual highlighting colors

## Important Notes

- All plugins are VSCode-specific and won't load in regular Neovim
- Configuration is optimized for VSCode environment performance
- Highlight groups are designed for accessibility compliance
- Keybindings integrate seamlessly with VSCode's command system
