return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
        },
      })
      -- Dark colorblind theme for protanopia & deuteranopia (red-green color blindness)
      vim.cmd("colorscheme github_dark_colorblind")
      -- Alternative: vim.cmd('colorscheme github_light_colorblind')
    end,
  },
}
