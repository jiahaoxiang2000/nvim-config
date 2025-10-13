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

						-- Bright for ssss search matches - contrast
						IncSearch = { bg = "#ff9900", fg = "#000000", bold = true },
						Search = { bg = "#0066cc", fg = "#ffffff", bold = true },
						CurSearch = { bg = "#ff9900", fg = "#000000", bold = true },

						-- Diff view highlights - colorblind-friendly (protanopia/deuteranopia safe)
						-- Use bright blue/orange palette matching Visual/Search highlights for consistency
						DiffAdd = { bg = "#0066cc", fg = "#ffffff", bold = true }, -- Bright blue for additions (matches Visual)
						DiffDelete = { bg = "#ff9900", fg = "#000000", bold = true }, -- Bright orange for deletions (matches IncSearch)
						DiffChange = { bg = "#9966cc", fg = "#ffffff" },        -- Purple for changes (medium contrast)
						DiffText = { bg = "#ffaa00", fg = "#000000", bold = true }, -- Bright yellow-orange for changed text (high contrast)
					}

					for group, settings in pairs(highlights) do
						vim.api.nvim_set_hl(0, group, settings)
					end
				end,
			},
		},
	},
}
