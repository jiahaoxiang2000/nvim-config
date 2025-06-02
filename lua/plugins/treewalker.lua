return {
  "aaronik/treewalker.nvim",
  opts = {
    highlight = true,
    highlight_duration = 250,
    highlight_group = "CursorLine",
    jumplist = true,
  },
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<C-K>"] = {
            function()
              for _ = 1, vim.v.count1 do
                vim.cmd "Treewalker Up"
              end
            end,
            desc = "Treewalker Up (repeatable)",
          },
          ["<C-J>"] = {
            function()
              for _ = 1, vim.v.count1 do
                vim.cmd "Treewalker Down"
              end
            end,
            desc = "Treewalker Down (repeatable)",
          },
          ["<C-H>"] = {
            function()
              for _ = 1, vim.v.count1 do
                vim.cmd "Treewalker Left"
              end
            end,
            desc = "Treewalker Left (repeatable)",
          },
          ["<C-L>"] = {
            function()
              for _ = 1, vim.v.count1 do
                vim.cmd "Treewalker Right"
              end
            end,
            desc = "Treewalker Right (repeatable)",
          },
        },
      },
    },
  },
}
