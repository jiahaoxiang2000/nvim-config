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

-- VSCode Highlight Colors Configuration
-- Note: Due to VSCode support for syntax option requiring processing of syntax highlights,
-- all built-in highlight groups may be overridden or cleared.
-- Therefore, we define custom highlight groups instead of linking to built-in ones.
local function setup_vscode_highlights()
    -- Custom highlight groups for VSCode compatibility
    vim.api.nvim_set_hl(0, "VSCodeYankHighlight", { bg = "#d19a66", fg = "#282c34" })
    vim.api.nvim_set_hl(0, "VSCodeIlluminatedWord", { bg = "#3e4451", underline = true })
    vim.api.nvim_set_hl(0, "VSCodeIlluminatedCurWord", { bg = "#3e4451", underline = true, bold = true })
    vim.api.nvim_set_hl(0, "VSCodeSearchMatch", { bg = "#528bff", fg = "#ffffff" })
    vim.api.nvim_set_hl(0, "VSCodeSearchCurrent", { bg = "#e5c07b", fg = "#282c34" })
    vim.api.nvim_set_hl(0, "VSCodeHighlighter0", { bg = "#e06c75", fg = "#ffffff" })
    vim.api.nvim_set_hl(0, "VSCodeHighlighter1", { bg = "#98c379", fg = "#282c34" })
    vim.api.nvim_set_hl(0, "VSCodeHighlighter2", { bg = "#61afef", fg = "#ffffff" })
    vim.api.nvim_set_hl(0, "VSCodeHighlighter3", { bg = "#c678dd", fg = "#ffffff" })
    vim.api.nvim_set_hl(0, "VSCodeHighlighter4", { bg = "#e5c07b", fg = "#282c34" })
    vim.api.nvim_set_hl(0, "VSCodeHighlighter5", { bg = "#56b6c2", fg = "#282c34" })
end

-- Yank highlight configuration
local function augroup(name)
    return vim.api.nvim_create_augroup("vscode_" .. name, { clear = true })
end

-- -- Apply highlight colors when configuration loads
setup_vscode_highlights()

-- Reapply highlights when colorscheme changes (if any)
vim.api.nvim_create_autocmd("ColorScheme", {
    group = augroup("highlights"),
    callback = setup_vscode_highlights,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("yank_highlight"),
    callback = function()
        vim.highlight.on_yank({ timeout = 500 })
    end,
})

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
