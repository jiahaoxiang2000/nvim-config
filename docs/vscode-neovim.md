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
