# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dual-environment Neovim configuration based on **LazyVim** and **AstroNvim v5** that works seamlessly in both:
1. **Standalone Neovim**: Full-featured IDE setup with AstroNvim
2. **VSCode Neovim Extension**: Optimized integration with colorblind-friendly highlighting

## Architecture

### Dual Environment Loading (`init.lua`)

The configuration uses **conditional loading** to provide different experiences:

```lua
if vim.g.vscode then
  require "vscode-config.index"  -- VSCode Neovim integration
else
  -- Standalone Neovim with lazy.nvim bootstrap
end
```

### Standalone Neovim Structure

- **`init.lua`**: Bootstraps lazy.nvim and loads `lazy_setup.lua`
- **`lua/lazy_setup.lua`**: Configures lazy.nvim with AstroNvim v5, imports community packs and plugins
- **`lua/community.lua`**: Language pack imports (Lua, Markdown, Python, Rust, TOML)
- **`lua/plugins/`**: Custom plugin configurations
  - `claudecode.lua`: Claude Code integration with Snacks terminal provider

### VSCode Neovim Structure

Located in `lua/vscode-config/`:

- **`index.lua`**: Entry point with lazy.nvim setup and colorblind-friendly highlight configuration
- **`keymaps.lua`**: VSCode API integration keybindings (file management, git, code actions)
- **`config/options.lua`**: Basic Neovim options
- **`plugins/`**: VSCode-specific plugins (flash, surround, treewalker, highlights)

Full documentation: `lua/vscode-config/README.md`

## Important Patterns

### Adding Plugins to Standalone Neovim

Create file in `lua/plugins/`:

```lua
return {
  "author/plugin-name",
  dependencies = { "dep1", "dep2" },
  opts = {
    -- options
  },
  keys = {
    { "<leader>x", "<cmd>Command<cr>", desc = "Description" },
  },
}
```

## References

- [LazyVim Documentation](https://lazyvim.github.io/installation)
- [AstroNvim Documentation](https://docs.astronvim.com)
- [vscode-neovim Extension](https://github.com/vscode-neovim/vscode-neovim)
