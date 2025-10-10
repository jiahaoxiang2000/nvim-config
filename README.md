# 💤 NeoVim Configuration of Isomo

A dual-environment neovim configuration based on [LazyVim](https://github.com/LazyVim/LazyVim)
that works seamlessly in both standalone Neovim and VSCode Neovim extension.
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Plugins Overview

| Plugin           | Purpose                                                                          |
| ---------------- | -------------------------------------------------------------------------------- |
| `astrocore.lua`  | AstroNvim core config: autosave with format, keymaps (buffer switching, closing) |
| `astrotheme.lua` | GitHub colorblind theme (protanopia/deuteranopia friendly)                       |
| `astroui.lua`    | Custom highlights (yank, visual, search) with high contrast colors               |
| `claudecode.lua` | Claude Code AI integration with Snacks terminal provider                         |
| `latex.lua`      | LaTeX support via texlab LSP (build, forward search with Okular)                 |
| `mappings.lua`   | Custom keybindings (save with Ctrl+S, LSP hover/declaration)                     |
| `mason.lua`      | Auto-install LSP servers, formatters, linters (Lua, Python, Rust, Typst)         |
| `minuet.lua`     | DeepSeek AI completion with FIM (Fill-in-the-Middle)                             |
| `misc.lua`       | Colorful window separators                                                       |
| `neo-tree.lua`   | File tree config (show hidden files, hide gitignored)                            |
| `typst.lua`      | Typst support via tinymist LSP with live preview                                 |

## Intro Video

- [vscode-nvim-function-introduction](https://www.bilibili.com/video/BV1eVudzWE8u)
- [My IDE Journey: From JetBrains IDEs to NeoVim + Claude Code](https://www.bilibili.com/video/BV19PxRzbEfF)

## Reference

- [AstroNvim (@wzj-zz)](https://github.com/wzj-zz/AstroNvim)
- [astrocommunity](https://github.com/AstroNvim/astrocommunity)
