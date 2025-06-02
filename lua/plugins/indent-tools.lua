return {
  "arsham/indent-tools.nvim",
  event = "User AstroFile",
  dependencies = {
    "arsham/arshlib.nvim",
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<M-k>"] = { "<cmd>normal [u<cr>", desc = "Previous Indent" },
            ["<M-j>"] = { "<cmd>normal ]u<cr>", desc = "Next Indent" },
          },
        },
      },
    },
  },
  opts = {
    normal = {
      up = "[u",
      down = "]u",
      repeatable = false, -- requires nvim-treesitter-textobjects
    },
    textobj = false,
  },
  config = true,
  keys = { "]u", "[u" },
}
