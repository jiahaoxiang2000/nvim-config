return {
  "bloznelis/before.nvim",
  event = { "InsertEnter", "TextChanged" },
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["]b"] = { function() require("before").jump_to_next_edit() end, desc = "Next edit" },
            ["[b"] = { function() require("before").jump_to_last_edit() end, desc = "Previous edit" },
            ["<Leader>xe"] = { function() require("before").show_edits_in_quickfix() end, desc = "Previous edit" },
          },
        },
      },
    },
  },
  opts = {},
}
