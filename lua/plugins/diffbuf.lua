local function setup_diff_mappings()
  if vim.wo.diff then
    vim.keymap.set("n", "<M-n>", "]czz", {
      buffer = true,
      desc = "Next diff hunk",
      silent = true,
      nowait = true,
    })

    vim.keymap.set("n", "<M-p>", "[czz", {
      buffer = true,
      desc = "Previous diff hunk",
      silent = true,
      nowait = true,
    })
  end
end

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  callback = function()
    setup_diff_mappings()
    if not vim.wo.diff then
      pcall(vim.keymap.del, "n", "<M-n>", { buffer = true })
      pcall(vim.keymap.del, "n", "<M-p>", { buffer = true })
    end
  end,
})

if vim.wo.diff then setup_diff_mappings() end
return {}
