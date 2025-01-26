local M = {}

-- Get the directory of the current file
local current_file = debug.getinfo(1, "S").source:sub(2)
local current_dir = vim.fn.fnamemodify(current_file, ":h")

-- Find all .lua files in the plugins directory
local plugin_files = vim.fn.glob(current_dir .. "/*.lua")
local plugins = {}

for file in string.gmatch(plugin_files, "[^\n]+") do
    -- Convert file path to module path and skip init.lua
    local module_name = vim.fn.fnamemodify(file, ":t:r")
    if module_name ~= "init" then
        table.insert(plugins, { import = "vscode-config.plugins." .. module_name })
    end
end

return plugins
