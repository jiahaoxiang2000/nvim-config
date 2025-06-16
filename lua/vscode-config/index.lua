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
    -- Custom highlight groups for colorblind accessibility
    -- Using high contrast and colorblind-friendly color combinations

    -- Bright yellow background for yank - very visible
    vim.api.nvim_set_hl(0, "VSCodeYankHighlight", { bg = "#ffff00", fg = "#000000", bold = true })

    -- Blue tint for word illumination - subtle but visible
    vim.api.nvim_set_hl(0, "VSCodeIlluminatedWord", { bg = "#2d3748", underline = true })
    vim.api.nvim_set_hl(0, "VSCodeIlluminatedCurWord", { bg = "#4a5568", underline = true, bold = true })

    -- Bright blue for search matches - high contrast
    vim.api.nvim_set_hl(0, "VSCodeSearchMatch", { bg = "#0066cc", fg = "#ffffff", bold = true })
    vim.api.nvim_set_hl(0, "VSCodeSearchCurrent", { bg = "#ff9900", fg = "#000000", bold = true })

    -- Colorblind-friendly highlighter colors with high contrast
    vim.api.nvim_set_hl(0, "VSCodeHighlighter0", { bg = "#0066cc", fg = "#ffffff", bold = true }) -- Bright Blue
    vim.api.nvim_set_hl(0, "VSCodeHighlighter1", { bg = "#ff9900", fg = "#000000", bold = true }) -- Bright Orange
    vim.api.nvim_set_hl(0, "VSCodeHighlighter2", { bg = "#9900cc", fg = "#ffffff", bold = true }) -- Purple
    vim.api.nvim_set_hl(0, "VSCodeHighlighter3", { bg = "#ffff00", fg = "#000000", bold = true }) -- Yellow
    vim.api.nvim_set_hl(0, "VSCodeHighlighter4", { bg = "#000000", fg = "#ffffff", bold = true }) -- Black/White (highest contrast)
    vim.api.nvim_set_hl(0, "VSCodeHighlighter5", { bg = "#663300", fg = "#ffffff", bold = true }) -- Brown
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
        vim.highlight.on_yank({
            higroup = "VSCodeYankHighlight",
            timeout = 500
        })
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
