return {
    {
        'vscode-neovim/vscode-multi-cursor.nvim',
        event = 'VeryLazy',
        cond = not not vim.g.vscode,
        opts = {},
        config = function()
            require('vscode-multi-cursor').setup(
                {
                    -- Whether to set default mappings
                    default_mappings = false,
                    -- If set to true, only multiple cursors will be created without multiple selections
                    no_selection = false
                }
            )
            local cursors = require('vscode-multi-cursor')

            local k = vim.keymap.set
            k({ 'n', 'x' }, 'mc', cursors.create_cursor, { expr = true, desc = 'Create cursor' })
            k({ 'n' }, 'mcc', cursors.cancel, { desc = 'Cancel/Clear all cursors' })
            k({ 'n', 'x' }, 'mi', cursors.start_left, { desc = 'Start cursors on the left' })
            k({ 'n', 'x' }, 'mI', cursors.start_left_edge, { desc = 'Start cursors on the left edge' })
            k({ 'n', 'x' }, 'ma', cursors.start_right, { desc = 'Start cursors on the right' })
            k({ 'n', 'x' }, 'mA', cursors.start_right, { desc = 'Start cursors on the right' })
            k({ 'n' }, '[mc', cursors.prev_cursor, { desc = 'Goto prev cursor' })
            k({ 'n' }, ']mc', cursors.next_cursor, { desc = 'Goto next cursor' })
            k({ 'n' }, 'mcs', cursors.flash_char, { desc = 'Create cursor using flash' })
            k({ 'n' }, 'mcw', cursors.flash_word, { desc = 'Create selection using flash' })
        end
    }
}
