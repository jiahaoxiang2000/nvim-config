-- Custom VSCode Keybindings
-- Load VSCode API and set up advanced keybindings for better integration
local vscode = require('vscode')

-- Enhanced file explorer with automatic focus
vim.keymap.set('n', '<leader>e', function()
    vscode.action('workbench.view.explorer')
    vscode.action('workbench.files.action.focusFilesExplorer')
end, { desc = 'Toggle and focus file explorer' })

-- Quick file switching with recent files
vim.keymap.set('n', '<leader>fr', function()
    vscode.action('workbench.action.openRecent')
end, { desc = 'Open recent files' })


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

-- Go to implementation
vim.keymap.set('n', 'gi', function()
    vscode.action('editor.action.goToImplementation')
end, { desc = 'Go to implementation' })

-- Go to references
vim.keymap.set('n', 'gr', function()
    vscode.action('editor.action.goToReferences')
end, { desc = 'Go to references' })

-- Go to definition
vim.keymap.set('n', 'gd', function()
    vscode.action('editor.action.revealDefinition')
end, { desc = 'Go to definition' })

-- Show hover information (Rust docs, type info)
vim.keymap.set('n', 'gh', function()
    vscode.action('editor.action.showHover')
end, { desc = 'Show hover info' })

-- Toggle integrated terminal
vim.keymap.set('n', '<leader>tt', function()
    vscode.action('workbench.action.terminal.toggleTerminal')
end, { desc = 'Toggle terminal' })

-- Run task
vim.keymap.set('n', '<leader>tr', function()
    vscode.action('workbench.action.tasks.runTask')
end, { desc = 'Run task' })


-- Split editors with automatic focus
vim.keymap.set('n', '<leader>wv', function()
    vscode.action('workbench.action.splitEditor')
    vscode.action('workbench.action.focusNextGroup')
end, { desc = 'Split editor vertically and focus' })

vim.keymap.set('n', '<leader>ws', function()
    vscode.action('workbench.action.splitEditorDown')
    vscode.action('workbench.action.focusNextGroup')
end, { desc = 'Split editor horizontally and focus' })

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
