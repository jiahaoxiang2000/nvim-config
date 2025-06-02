return {
  "kevinhwang91/nvim-hlslens",
  opts = {},
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      on_keys = { auto_hlsearch = false },
      mappings = {
        n = {
          ["<Leader>L"] = { "<Cmd>noh<CR>", desc = "nohlsearch" },
        },
      },
    },
  },
  event = "BufRead",
}
