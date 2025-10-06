return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      highlights = {
        init = function()
          -- Colorblind-friendly custom highlights with high contrast
          local highlights = {
            -- Bright yellow for yank highlighting
            YankHighlight = { bg = "#ffff00", fg = "#000000", bold = true },

            -- Visual selection - high contrast blue
            Visual = { bg = "#0066cc", fg = "#ffffff" },

            -- Bright blue for search matches - high contrast
            IncSearch = { bg = "#ff9900", fg = "#000000", bold = true },
            Search = { bg = "#0066cc", fg = "#ffffff", bold = true },
            CurSearch = { bg = "#ff9900", fg = "#000000", bold = true },
          }

          for group, settings in pairs(highlights) do
            vim.api.nvim_set_hl(0, group, settings)
          end
        end,
      },
    },
  },
}
