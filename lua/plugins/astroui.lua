---@type LazySpec
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "github_dark_colorblind",
      highlights = {
        init = {
          YankHighlight = { bg = "#ffff00", fg = "#000000", bold = true },
          Visual = { bg = "#0066cc", fg = "#ffffff" },
          IncSearch = { bg = "#ff9900", fg = "#000000", bold = true },
          Search = { bg = "#0066cc", fg = "#ffffff", bold = true },
          CurSearch = { bg = "#ff9900", fg = "#000000", bold = true },
          DiffAdd = { bg = "#0066cc", fg = "#ffffff", bold = true },
          DiffDelete = { bg = "#ff9900", fg = "#000000", bold = true },
          DiffChange = { bg = "#9966cc", fg = "#ffffff" },
          DiffText = { bg = "#ffaa00", fg = "#000000", bold = true },
        },
      },
    },
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    priority = 1000,
    opts = {
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
    },
    config = function(_, opts) require("github-theme").setup(opts) end,
  },
}
