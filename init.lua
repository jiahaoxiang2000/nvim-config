--luacheck: globals vim
if vim.g.vscode then
    require("vscode-config.index")
else
    require("config.lazy")
end
