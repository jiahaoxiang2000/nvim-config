# 💤 NeoVim Configuration of Isomo

A dual-environment neovim configuration based on [LazyVim](https://github.com/LazyVim/LazyVim) that works seamlessly in both standalone Neovim and VSCode Neovim extension.
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Features

- **Dual Environment Support**: Automatically detects and configures for VSCode Neovim extension or standalone Neovim
- **Mouse-free operation**: Maximize efficiency through keyboard-only workflows
- **AI Integration**: GitHub Copilot support with intelligent completion and chat
- **Enhanced UI**: Custom Lualine configuration with time display and git status
- **Smart Completion**: Blink CMP with snippet support and multiple sources
- **VS Code Integration**: Dedicated VSCode configuration with which-key and flash navigation
- **Language Support**: Built-in support for JSON, Markdown, LaTeX, and more

## Configuration Structure

```
nvim/
├── init.lua                 # Entry point with environment detection
├── lua/
│   ├── config/             # Core LazyVim configuration
│   │   ├── autocmds.lua    # Auto commands with Copilot integration
│   │   ├── keymaps.lua     # Key mappings
│   │   ├── lazy.lua        # Lazy.nvim setup
│   │   └── options.lua     # Vim options
│   ├── plugins/            # Custom plugin configurations
│   │   ├── ai.lua          # AI plugin setup (Copilot)
│   │   ├── cmp.lua         # Blink CMP completion engine
│   │   ├── colorscheme.lua # TokyoNight theme configuration
│   │   ├── disabled.lua    # Disabled plugins
│   │   ├── lualine.lua     # Enhanced statusline with time
│   │   └── mini.lua        # Mini.surround text objects
│   └── vscode-config/      # VSCode Neovim extension setup
│       ├── config/         # VSCode-specific options
│       ├── plugins/        # VSCode-compatible plugins
│       └── index.lua       # VSCode entry point
├── lazyvim.json           # LazyVim extras configuration
└── lazy-lock.json         # Plugin version lock (gitignored)
```

## Enabled LazyVim Extras

- **AI**: `lazyvim.plugins.extras.ai.copilot` - GitHub Copilot integration
- **Languages**:
  - `lazyvim.plugins.extras.lang.json` - JSON support with schemas
  - `lazyvim.plugins.extras.lang.markdown` - Enhanced Markdown editing
  - `lazyvim.plugins.extras.lang.tex` - LaTeX support

## Key Plugin Customizations

### Completion Engine (Blink CMP)

- Fast completion with multiple sources (LSP, snippets, buffer, path)
- Integrated with Copilot for AI-powered suggestions
- Smart snippet expansion with LazyVim compatibility

### Statusline (Lualine)

- Custom configuration with real-time clock display
- Git integration with diff indicators
- Diagnostic symbols and mode indicators
- Trouble.nvim integration for symbol navigation

### VSCode Integration

- Automatic environment detection in `init.lua`
- Which-key integration for familiar keybindings
- Flash.nvim for character-based navigation
- Vim-surround for text manipulation

### AI Features

- GitHub Copilot with chat support
- Smart auto-completion with context awareness
- Copilot suggestions properly hidden during CMP menu display

## Installation

### Prerequisites

- Neovim >= 0.9.0
- Git
- A Nerd Font (optional, but recommended)
- Node.js (for GitHub Copilot)

### Setup Steps

1. **Backup existing configuration** (if any):

   ```fish
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this configuration**:

   ```fish
   git clone <your-repo-url> ~/.config/nvim
   ```

3. **Start Neovim**:

   ```fish
   nvim
   ```

   LazyVim will automatically install all plugins on first launch.

4. **Restart Neovim** to ensure all configurations are properly loaded.

### VSCode Neovim Extension Setup

1. Install the [VSCode Neovim extension](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim)
2. Configure the extension to use this Neovim configuration
3. The configuration will automatically detect the VSCode environment and load appropriate plugins

## Usage

### Environment Detection

The configuration automatically detects whether it's running in:

- **Standalone Neovim**: Loads full LazyVim configuration with all features
- **VSCode Neovim**: Loads minimal configuration optimized for VSCode integration

### Key Features in Action

#### AI Integration

- **Copilot Completion**: Automatic suggestions while typing
- **Copilot Chat**: Access AI assistance with `:CopilotChat`
- **Smart Context**: Copilot suggestions are hidden when completion menu is open

#### Enhanced Navigation

- **Flash Navigation**: Quick character-based movement (VSCode mode)
- **Which-key Integration**: Discoverable keybindings with hints
- **Mini Surround**: Text object manipulation with `gsa`, `gsd`, `gsr`

## Customization

### Adding New Plugins

Create new files in `lua/plugins/` directory. Each file should return a plugin specification:

```lua
-- lua/plugins/my-plugin.lua
return {
  "author/plugin-name",
  config = function()
    -- Plugin configuration
  end,
  -- Additional options...
}
```

### Modifying Existing Plugins

Override default LazyVim configurations by creating files with the same plugin name:

```lua
-- lua/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  opts = {
    -- Your custom telescope options
    defaults = {
      layout_strategy = "horizontal",
    },
  },
}
```

### VSCode-Specific Customizations

Add VSCode-only plugins in `lua/vscode-config/plugins/`:

```lua
-- lua/vscode-config/plugins/my-vscode-plugin.lua
return {
  "vscode-specific/plugin",
  -- Configuration for VSCode environment only
}
```

### Environment Variables

The configuration respects these environment variables:

- `vim.g.vscode` - Automatically set when running in VSCode
- LazyVim environment detection for optimal plugin loading

## Configuration Notes

### Plugin Override Behavior

- Custom configurations in `lua/plugins/*.lua` will override default LazyVim settings
- The configuration preserves LazyVim's plugin ecosystem integrations
- VSCode-specific plugins are isolated in `lua/vscode-config/plugins/`

### Version Management

- `lazy-lock.json` is excluded from git tracking to allow personalized plugin versions
- Plugin updates can be managed with `:Lazy update`
- Rollback capability with `:Lazy restore`

### Known Issues Status

- **RESOLVED**: Document Scrolling Issue - `<C-u>` and `<C-d>` keys work correctly
- **RESOLVED**: Command Line Issue - `<C-u>` and `<C-d>` keys work in command line
- **RESOLVED**: Copilot Integration - Proper integration with completion menu

## Troubleshooting

### Common Issues

1. **Plugins not loading**: Ensure you have internet connection and restart Neovim
2. **Copilot not working**: Check if you're logged in with `:Copilot auth`
3. **LSP issues**: Run `:Mason` to check language server installations
4. **Performance issues**: Consider disabling unused LazyVim extras in `lazyvim.json`

### Logs and Debugging

- Check logs with `:Lazy log`
- View health status with `:checkhealth`
- Debug startup time with `:Lazy profile`

## Specific Plugin Configurations

### Completion System (lua/plugins/cmp.lua)

- **Blink CMP**: Fast completion engine with multiple sources
- **Copilot Integration**: Auto-hide suggestions during completion menu
- **Snippet Support**: LazyVim-compatible snippet expansion
- **Sources**: LSP, path, snippets, buffer completion

### Status Line (lua/plugins/lualine.lua)

- **Real-time Clock**: Current time display in status line
- **Git Integration**: Branch info and diff statistics
- **Diagnostic Display**: Error, warning, info, and hint counts
- **Mode Indicators**: Current vim mode and DAP status

### AI Integration (lua/plugins/ai.lua)

- **GitHub Copilot**: Configured via LazyVim extras
- **Chat Support**: Integrated Copilot chat functionality
- **Smart Hiding**: Copilot suggestions hidden during active completion

### Color Scheme (lua/plugins/colorscheme.lua)

- **TokyoNight**: Set to dark variant for consistent theming
- **Gruvbox**: Available as alternative color scheme
- **Theme Consistency**: Matches terminal and system themes

### Text Objects (lua/plugins/mini.lua)

- **Mini.surround**: Enhanced text manipulation
- **Custom Mappings**: `gsa` (add), `gsd` (delete), `gsr` (replace)
- **Efficient Workflow**: Quick text object operations

## Contributing

Feel free to submit issues and enhancement requests. When contributing:

1. Test changes in both standalone Neovim and VSCode environments
2. Ensure compatibility with LazyVim's plugin ecosystem
3. Document any new features or configuration changes

## License

This configuration is based on LazyVim and follows the same license terms.
