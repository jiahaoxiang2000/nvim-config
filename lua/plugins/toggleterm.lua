vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = { "term://*" },
  callback = function()
    local opts = { buffer = 0 }
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
    vim.keymap.set({ "t", "n" }, "<M-w>", "<cmd>TermSelect<cr>", opts)
  end,
})

return {
  "akinsho/toggleterm.nvim",
  cmd = { "TermSelect" },
}
