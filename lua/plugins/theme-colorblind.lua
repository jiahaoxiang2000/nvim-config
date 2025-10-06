return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    priority = 1000,
    config = function()
      require('github-theme').setup({
        options = {
          styles = {
            comments = 'italic',
            keywords = 'bold',
            types = 'italic,bold',
          },
        }
      })
      -- Dark colorblind theme for protanopia & deuteranopia (red-green color blindness)
      vim.cmd('colorscheme github_dark_colorblind')
      -- Alternative: vim.cmd('colorscheme github_light_colorblind')

      -- Colorblind-friendly custom highlights with high contrast
      -- Bright yellow for yank highlighting
      vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#ffff00", fg = "#000000", bold = true })

      -- Visual selection - high contrast blue
      vim.api.nvim_set_hl(0, "Visual", { bg = "#0066cc", fg = "#ffffff" })

      -- Bright blue for search matches - high contrast
      vim.api.nvim_set_hl(0, "IncSearch", { bg = "#ff9900", fg = "#000000", bold = true })
      vim.api.nvim_set_hl(0, "Search", { bg = "#0066cc", fg = "#ffffff", bold = true })
      vim.api.nvim_set_hl(0, "CurSearch", { bg = "#ff9900", fg = "#000000", bold = true })
    end,
  },
}
