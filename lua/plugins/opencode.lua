return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Required for ask() and select()
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration here
    }

    -- Required for opts.events.reload
    vim.o.autoread = true

    -- Keymaps
    vim.keymap.set({ "n", "x" }, "<C-a>", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode" })

    vim.keymap.set({ "n", "x" }, "<C-x>", function()
      require("opencode").select()
    end, { desc = "Execute opencode action…" })

    vim.keymap.set({ "n", "x" }, "ga", function()
      require("opencode").prompt("@this")
    end, { desc = "Add to opencode" })

    vim.keymap.set({ "n", "t" }, "<C-.>", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })

    vim.keymap.set("n", "<S-C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "opencode half page up" })

    vim.keymap.set("n", "<S-C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "opencode half page down" })

    -- Restore increment/decrement since we're using <C-a> and <C-x>
    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
  end,
}
