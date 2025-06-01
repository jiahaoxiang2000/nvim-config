# vscode-neovim Manual

The [vscode-neovim](https://github.com/vscode-neovim/vscode-neovim) extension brings Neovim integration to VS Code.  
Here, we record some useful tips and tricks for using it, based on the [README](https://github.com/vscode-neovim/vscode-neovim/blob/main/README.md).

## Tips

### VsCode specific differences

- Editor customization (relative line number, scrolloff, etc) is handled by VSCode.

### Troubleshooting

- View the logs via Output: `Focus on Output View` and select vscode-neovim logs.
  - To enable debug logs, click the "gear" icon and select Debug, then click it again and choose Set As Default
- Two VSCode developer commands are useful for keybindings debugging:
  - `Developer: Toggle Keyboard Shortcuts Troubleshooting` for tracing VSCode emitted keypresses and their processing via defined keybindings.
  - `Developer: Inspect Key Mapping` for getting the recognized mappings for the current keyboard layout inside VSCode.

### Performance

If you have any performance problems (cursor jitter usually) make sure you're not using vim plugins that increase latency and cause performance problems.

### Multiple cursors

If you have any performance problems (cursor jitter usually) make sure you're not using [vim plugins](https://github.com/vscode-neovim/vscode-multi-cursor.nvim) that increase latency and cause performance problems.

## 🚄 API

- `vscode.action()`: asynchronously executes a vscode command.
- `vscode.call()`: synchronously executes a vscode command.
- `vscode.on()`: defines a handler for some Nvim UI events.
- `vscode.has_config()`: checks if a vscode setting exists.
- `vscode.get_config()`: gets a vscode setting value.
- `vscode.update_config()`: sets a vscode setting.
- `vscode.notify()`: shows a vscode message (see also Nvim's vim.notify).
- `vscode.eval()`: evaluate javascript synchronously in vscode and return the result
- `vscode.eval_async()`: evaluate javascript asynchronously in vscode
- `vscode.with_insert()`: perform operations in insert mode.

## ⌨️ Keybindings

- **Neovim keybindings**: These are the keybindings defined in the extension's vimscript files or your `init.vim` file. They provide code navigation, buffer management, and other Neovim-specific overrides.
- **VSCode keybindings**: These are the keybindings defined in the extension's `package.json` or your `keybindings.json` file. They allow you to interact with VSCode's built-in features and make VSCode more Vim-like.
- **VSCode passthrough keybindings**: These are keybindings defined in the extension's `package.json` or your `keybindings.json` file that simply pass the keypress through to Neovim. This lets Neovim handle certain keypresses that would otherwise be handled by VSCode.
