-- Basic vim options
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- VSCode-specific settings
vim.opt.clipboard = "unnamedplus"

-- Wayland clipboard provider for Hyprland
vim.g.clipboard = {
  name = 'wl-clipboard',
  copy = {
    ['+'] = 'wl-copy',
    ['*'] = 'wl-copy',
  },
  paste = {
    ['+'] = 'wl-paste --no-newline',
    ['*'] = 'wl-paste --no-newline',
  },
  cache_enabled = 0,
}

vim.opt.ignorecase = true
vim.opt.smartcase = false
