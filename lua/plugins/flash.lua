-- flash.lua
return {
    {
        "folke/flash.nvim",
        event = "VeryLazy", -- Load the plugin lazily
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
        config = function()
            require("flash").setup({
                -- Configuration options for Flash
                labels = "abcdefghijklmnopqrstuvwxyz", -- Labels for jump targets
                search = {
                    mode = "fuzzy",                    -- Fuzzy search mode
                },
                jump = {
                    autojump = true, -- Automatically jump to the first match
                },
            })
        end,
    },
}
