--luacheck: globals vim
if vim.g.vscode then
    require("vscode-config.index") -- VSCode Neovim integration
else
    require("config.lazy")         -- Lazy.nvim plugin managers
end
