return {
  "stevearc/aerial.nvim",

  opts = {
    disable_max_lines = 300000,
    disable_max_size = 8000000,
  },
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<C-g>"] = {
            function() require("aerial").toggle() end,
            desc = "Symbols Outline",
          },
        },
      },
    },
  },
}
