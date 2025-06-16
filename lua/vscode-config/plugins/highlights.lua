return {
    {
        -- Word highlighting plugin
        "RRethy/vim-illuminate",
        cond = vim.g.vscode,
        event = "BufRead",
        config = function()
            require("illuminate").configure({
                -- providers: provider used to get references in the buffer, ordered by priority
                providers = {
                    "lsp",
                    "treesitter",
                    "regex",
                },
                -- delay: delay in milliseconds
                delay = 100,
                -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
                filetypes_denylist = {
                    "dirvish",
                    "fugitive",
                    "NvimTree",
                    "lazy",
                },
                -- under_cursor: whether or not to illuminate under the cursor
                under_cursor = true,
                -- large_file_cutoff: number of lines at which to use large_file_config
                large_file_cutoff = 2000,
                -- large_file_config: config to use for large files (based on large_file_cutoff).
                large_file_config = {
                    providers = { "lsp" },
                },
            })

            -- Set custom highlight groups for VSCode compatibility
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "VSCodeIlluminatedWord" })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "VSCodeIlluminatedWord" })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "VSCodeIlluminatedCurWord" })
        end,
    },

    {
        -- Search highlighting
        "kevinhwang91/nvim-hlslens",
        cond = vim.g.vscode,
        event = "BufRead",
        opts = {
            calm_down = true,
            nearest_only = true,
        },
        config = function(_, opts)
            require('hlslens').setup(opts)

            -- Set custom highlight groups for VSCode compatibility
            vim.api.nvim_set_hl(0, "HlSearchNear", { link = "VSCodeSearchCurrent" })
            vim.api.nvim_set_hl(0, "HlSearchLens", { link = "VSCodeSearchMatch" })
            vim.api.nvim_set_hl(0, "HlSearchLensNear", { link = "VSCodeSearchCurrent" })
        end,
        keys = {
            { "n",         [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], desc = "Next search result" },
            { "N",         [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], desc = "Previous search result" },
            { "*",         [[*<Cmd>lua require('hlslens').start()<CR>]],                                             desc = "Search word under cursor forward" },
            { "#",         [[#<Cmd>lua require('hlslens').start()<CR>]],                                             desc = "Search word under cursor backward" },
            { "<Leader>l", "<Cmd>noh<CR>",                                                                           desc = "Clear search highlight" },
        },
    },

    {
        -- Manual highlighting
        "azabiong/vim-highlighter",
        cond = vim.g.vscode,
        lazy = false,
        config = function()
            -- Configure vim-highlighter to use custom highlight groups
            vim.g.HiSet = "f<Enter>"
            vim.g.HiErase = "f<BS>"
            vim.g.HiClear = "f<C-l>"
            vim.g.HiFind = "f<Tab>"

            -- Set custom highlight groups for vim-highlighter
            vim.api.nvim_set_hl(0, "HiColor0", { link = "VSCodeHighlighter0" })
            vim.api.nvim_set_hl(0, "HiColor1", { link = "VSCodeHighlighter1" })
            vim.api.nvim_set_hl(0, "HiColor2", { link = "VSCodeHighlighter2" })
            vim.api.nvim_set_hl(0, "HiColor3", { link = "VSCodeHighlighter3" })
            vim.api.nvim_set_hl(0, "HiColor4", { link = "VSCodeHighlighter4" })
            vim.api.nvim_set_hl(0, "HiColor5", { link = "VSCodeHighlighter5" })
        end,
        keys = {
            { "f<Enter>", desc = "Highlight word" },
            { "f<BS>",    desc = "Remove highlight" },
            { "f<C-l>",   desc = "Clear all highlights" },
            { "f<Tab>",   desc = "Find highlights" },
            { "<S-M-j>",  "<cmd>Hi><CR>",               desc = "Next highlight" },
            { "<S-M-k>",  "<cmd>Hi<<CR>",               desc = "Previous highlight" },
        },
    },
}
