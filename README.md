# 💤 NeoVim Configuration of Isomo

A dual-environment neovim configuration based on [AstroNvim v5](https://github.com/AstroNvim/AstroNvim)
that works seamlessly in both standalone Neovim and VSCode Neovim extension.
Refer to the [AstroNvim documentation](https://docs.astronvim.com) to get started.

## Language Support

- **Lua**: LSP, formatting, linting
- **Python**: LSP, formatting, linting  
- **Rust**: LSP, formatting, linting
- **TypeScript/JavaScript**: LSP, formatting, linting
- **Java**: LSP support
- **TOML**: Syntax highlighting and LSP
- **LaTeX**: texlab LSP with Okular integration
- **Typst**: tinymist LSP with live preview

## Plugins Overview

| Plugin           | Purpose                                                                          |
| ---------------- | -------------------------------------------------------------------------------- |
| `astrocore.lua`  | AstroNvim core config: autosave with format, keymaps (buffer switching, closing) |
| `astrotheme.lua` | GitHub colorblind theme (protanopia/deuteranopia friendly)                       |
| `astroui.lua`    | Custom highlights (yank, visual, search) with high contrast colors               |
| `claudecode.lua` | Claude Code AI integration with Snacks terminal provider                         |
| `codeql.lua`     | CodeQL security analysis integration                                             |
| `flash.lua`      | Fast motion/jumping with fuzzy search and autojump navigation                    |
| `gitsigns.lua`   | Git integration with line blame and hunk navigation                              |
| `latex.lua`      | LaTeX support via texlab LSP (build, forward search with Okular)                 |
| `mappings.lua`   | Custom keybindings (save with Ctrl+S, LSP hover/declaration)                     |
| `mason.lua`      | Auto-install LSP servers, formatters, linters (Lua, Python, Rust, Typst)         |
| `minuet.lua`     | DeepSeek AI completion with FIM (Fill-in-the-Middle)                             |
| `misc.lua`       | Colorful window separators                                                       |
| `neo-tree.lua`   | File tree config (show hidden files, hide gitignored)                            |
| `opencode.lua`   | OpenCode AI integration with auto-reload and custom keybindings                  |
| `treewalker.lua` | AST-based navigation using Treesitter with visual highlighting                   |
| `typst.lua`      | Typst support via tinymist LSP with live preview                                 |

## Intro Video

- [vscode-nvim-function-introduction](https://www.bilibili.com/video/BV1eVudzWE8u)
- [My IDE Journey: From JetBrains IDEs to NeoVim + Claude Code](https://www.bilibili.com/video/BV19PxRzbEfF)

## Reference

- [AstroNvim (@wzj-zz)](https://github.com/wzj-zz/AstroNvim)
- [astrocommunity](https://github.com/AstroNvim/astrocommunity)
