-- the snippet not compatible with the `cmp`, so now we closed the snippets

-- return {
--     -- Your existing LazyVim plugins
--     {
--         "L3MON4D3/LuaSnip",              -- LuaSnip plugin
--         version = "v2.*",                -- Use the latest version
--         spec = {
--             vscode = true,               -- Enable VSCode-like snippets
--         },
--         build = "make install_jsregexp", -- Optional: Build step for advanced features
--         event = "InsertEnter",           -- Load on entering insert mode
--         config = function()
--             require("luasnip").setup()   -- Basic LuaSnip setup
--         end,
--     },
--     {
--         "rafamadriz/friendly-snippets", -- Friendly snippets collection
--         event = "InsertEnter",          -- Load on entering insert mode
--         spec = {
--             vscode = true,              -- Enable VSCode-like snippets
--         },
--         dependencies = {
--             "L3MON4D3/LuaSnip", -- LuaSnip is required for friendly-snippets
--         },
--         config = function()
--             require("luasnip.loaders.from_vscode").lazy_load() -- Load friendly-snippets
--         end,
--     },
-- }
