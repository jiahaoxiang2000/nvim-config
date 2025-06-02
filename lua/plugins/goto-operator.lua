local ts_utils = require "nvim-treesitter.ts_utils"

-- Operator list sorted by priority (longer first)
local OPERATORS = {
  "->",
  "<=",
  ">=",
  "==",
  "!=",
  "||",
  "&&",
  "<",
  ">",
  "|",
  "&",
  "=",
}

-- Find next valid operator
local function safe_search(forward)
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local step = forward and 1 or -1

  for l = line, forward and vim.fn.line "$" or 1, step do
    local text = vim.fn.getline(l)
    local start_col = (l == line) and (col + (forward and 1 or 0)) or (forward and 1 or #text)
    local end_col = forward and #text or 1

    for c = start_col, end_col, forward and 1 or -1 do
      for _, op in ipairs(OPERATORS) do
        if text:sub(c, c + #op - 1) == op then
          vim.api.nvim_win_set_cursor(0, { l, c - 1 })
          local node = ts_utils.get_node_at_cursor()
          if node and node:named_child_count() >= 2 then return true end
        end
      end
    end
  end
  return false
end

local function search_operator(forward, select_child)
  -- Exit visual mode if active
  if vim.fn.mode():match "[vV]" then
    vim.cmd("normal! " .. vim.api.nvim_replace_termcodes("<Esc>", true, true, true))
  end

  if not safe_search(forward) then
    vim.notify("No valid operator found", vim.log.levels.WARN)
    return
  end

  local node = ts_utils.get_node_at_cursor()
  if node and node:named_child_count() > select_child then
    ts_utils.update_selection(0, node:named_child(select_child))
  end
end

-- Keymaps
vim.keymap.set({ "n", "v" }, "<M->>", function()
  search_operator(true, 1) -- Next operator, select second operand
end, { desc = "Find next operator and select second operand" })

vim.keymap.set({ "n", "v" }, "<M-<>", function()
  search_operator(false, 0) -- Previous operator, select first operand
end, { desc = "Find previous operator and select first operand" })

return {}
