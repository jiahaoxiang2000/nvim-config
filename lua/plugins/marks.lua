return {
  "chentoast/marks.nvim",
  opts = {
    cyclic = false,
  },
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<M-{>"] = { "<cmd>normal m[<cr>", desc = "Previous Mark" },
          ["<M-}>"] = { "<cmd>normal m]<cr>", desc = "Next Mark" },
          ["<Leader>f'"] = {
            function()
              require "marks"
              vim.cmd "MarksQFListAll"
            end,
            desc = "List Marks in QFList",
          },
        },
      },
    },
  },
}
