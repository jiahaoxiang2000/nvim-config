-- this is the vscode neovim configuration files

-- NOTE: Specifically, you don't need any code highlighting, completion, LSP plugins, or plugins that spawn windows/buffers (nerdtree , fuzzy-finders, etc).
-- Most navigation/textobject/editing plugins should be fine.

local levels = vim.log.levels
local vscode = require('vscode')

vscode.notify('Welcome to vscode-neovim supported by isomo', levels.INFO)
