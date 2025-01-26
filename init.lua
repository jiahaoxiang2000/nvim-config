if vim.g.vscode then
    require("vscode.index")
else
    require("config.lazy")
end
