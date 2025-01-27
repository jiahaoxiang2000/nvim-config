-- config the surround plugin_files for neovim on the vscode
return {

    "kylechui/nvim-surround",
    version = "*",      -- Use the latest version
    event = "VeryLazy", -- Load the plugin lazily
    spec = {
        vscode = true
    },
    config = function()
        require("nvim-surround").setup({
            keymaps = {
                insert = "<C-g>s",
                insert_line = "<C-g>S",
                normal = "ys",
                normal_cur = "yss",
                normal_line = "yS",
                normal_cur_line = "ySS",
                visual = "S",
                visual_line = "gS",
                delete = "ds",
                change = "cs",
            },
            aliases = {
                ["a"] = ">",
                ["b"] = ")",
                ["B"] = "}",
                ["q"] = '"',
                ["s"] = "]",
            },
        })
    end
}
