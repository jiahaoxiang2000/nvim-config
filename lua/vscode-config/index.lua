-- VSCode Neovim configuration

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load basic configurations
require("vscode-config.config.options")
-- Initialize lazy.nvim
require("lazy").setup({
    spec = {
        { import = "vscode-config.plugins" },
    },
    defaults = {
        lazy = true,
    },
    install = {
        missing = true,
    },
    checker = {
        enabled = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
