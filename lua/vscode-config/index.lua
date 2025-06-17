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

-- Custom VSCode Keybindings
-- Load VSCode API and set up advanced keybindings for better integration
local vscode = require('vscode')

-- ============================================================================
-- File Management & Navigation
-- ============================================================================

-- Enhanced file explorer with automatic focus
vim.keymap.set('n', '<leader>e', function()
    vscode.action('workbench.view.explorer')
    vscode.action('workbench.files.action.focusFilesExplorer')
end, { desc = 'Toggle and focus file explorer' })

-- Quick file switching with recent files
vim.keymap.set('n', '<leader>fr', function()
    vscode.action('workbench.action.openRecent')
end, { desc = 'Open recent files' })

-- ============================================================================
-- Search & Replace
-- ============================================================================

-- Find and replace word under cursor
vim.keymap.set('n', '<leader>sr', function()
    local word = vim.fn.expand('<cword>')
    vscode.action('editor.action.startFindReplaceAction', {
        args = { searchString = word }
    })
end, { desc = 'Find and replace word under cursor' })

-- Search in files with word under cursor
vim.keymap.set('n', '<leader>sf', function()
    local word = vim.fn.expand('<cword>')
    vscode.action('workbench.action.findInFiles', {
        args = { query = word }
    })
end, { desc = 'Search word in files' })

-- Advanced search with selection
vim.keymap.set('v', '<leader>sf', function()
    vscode.with_insert(function()
        vscode.action('workbench.action.findInFiles')
    end)
end, { desc = 'Search selection in files' })

-- ============================================================================
-- Code Actions & Refactoring
-- ============================================================================

-- Quick fix with insert mode support
vim.keymap.set({ 'n', 'v' }, '<leader>ca', function()
    vscode.with_insert(function()
        vscode.action('editor.action.quickFix')
    end)
end, { desc = 'Code actions (quick fix)' })

-- Refactor with selection support
vim.keymap.set({ 'n', 'v' }, '<leader>cr', function()
    vscode.with_insert(function()
        vscode.action('editor.action.refactor')
    end)
end, { desc = 'Refactor selection' })

-- Format document or selection
vim.keymap.set('n', '<leader>cf', function()
    vscode.action('editor.action.formatDocument')
end, { desc = 'Format document' })

vim.keymap.set('v', '<leader>cf', function()
    vscode.action('editor.action.formatSelection')
end, { desc = 'Format selection' })

-- ============================================================================
-- Multi-cursor & Selection
-- ============================================================================

-- ============================================================================
-- Terminal & Tasks
-- ============================================================================

-- Toggle integrated terminal
vim.keymap.set('n', '<leader>tt', function()
    vscode.action('workbench.action.terminal.toggleTerminal')
end, { desc = 'Toggle terminal' })

-- Run task
vim.keymap.set('n', '<leader>tr', function()
    vscode.action('workbench.action.tasks.runTask')
end, { desc = 'Run task' })

-- ============================================================================
-- Window & Panel Management
-- ============================================================================

-- Split editors with automatic focus
vim.keymap.set('n', '<leader>wv', function()
    vscode.action('workbench.action.splitEditor')
    vscode.action('workbench.action.focusNextGroup')
end, { desc = 'Split editor vertically and focus' })

vim.keymap.set('n', '<leader>ws', function()
    vscode.action('workbench.action.splitEditorDown')
    vscode.action('workbench.action.focusNextGroup')
end, { desc = 'Split editor horizontally and focus' })

-- Panel toggles

-- ============================================================================
-- Git Integration
-- ============================================================================

-- Git operations with better UX
vim.keymap.set('n', '<leader>gs', function()
    vscode.action('workbench.view.scm')
end, { desc = 'Open source control' })

vim.keymap.set('n', '<leader>gc', function()
    vscode.action('git.commitStaged')
end, { desc = 'Commit staged changes' })

vim.keymap.set('n', '<leader>gp', function()
    vscode.action('git.push')
end, { desc = 'Git push' })

vim.keymap.set('n', '<leader>gl', function()
    vscode.action('git.pull')
end, { desc = 'Git pull' })

-- ============================================================================
-- Settings & Configuration Management
-- ============================================================================

-- ============================================================================
-- Advanced Workflow Examples
-- ============================================================================

-- Custom workflow: Save all, format, and show notification
vim.keymap.set('n', '<leader>wa', function()
    vscode.action('workbench.action.files.saveAll')
    vscode.action('editor.action.formatDocument')
    vscode.notify('Files saved and formatted')
end, { desc = 'Save all and format document' })

-- Show current file information using JavaScript evaluation
vim.keymap.set('n', '<leader>fi', function()
    local file_info = vscode.eval([[
        const editor = vscode.window.activeTextEditor;
        if (!editor) return { error: 'No active editor' };

        const doc = editor.document;
        const selection = editor.selection;

        return {
            fileName: doc.fileName,
            lineCount: doc.lineCount,
            language: doc.languageId,
            hasSelection: !selection.isEmpty
        };
    ]])

    if file_info and not file_info.error then
        local info = string.format(
            'File: %s\nLines: %d\nLanguage: %s\nHas selection: %s',
            vim.fn.fnamemodify(file_info.fileName, ':t'),
            file_info.lineCount,
            file_info.language,
            file_info.hasSelection and 'Yes' or 'No'
        )
        vscode.notify(info)
    else
        vscode.notify('Could not get file info')
    end
end, { desc = 'Show current file information' })

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
