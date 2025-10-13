return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			-- Enable line wrapping in preview windows
			preview_config = {
				border = "rounded",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				-- Enable word diff for better granularity
				vim.keymap.set("n", "<leader>gw", function()
					gitsigns.toggle_word_diff()
				end, { buffer = bufnr, desc = "Toggle word diff" })

				-- Preview hunk with wrap enabled
				vim.keymap.set("n", "<leader>gp", function()
					gitsigns.preview_hunk()
					-- Enable wrap in the preview window after it opens
					vim.defer_fn(function()
						for _, win in ipairs(vim.api.nvim_list_wins()) do
							local buf = vim.api.nvim_win_get_buf(win)
							local bufname = vim.api.nvim_buf_get_name(buf)
							if bufname:match("gitsigns://") then
								vim.api.nvim_set_option_value("wrap", true, { win = win })
								vim.api.nvim_set_option_value("linebreak", true, { win = win })
							end
						end
					end, 50)
				end, { buffer = bufnr, desc = "Preview git hunk with wrap" })

				-- Diff this file with wrap enabled
				vim.keymap.set("n", "<leader>gd", function()
					gitsigns.diffthis()
					-- Enable wrap in diff windows
					vim.defer_fn(function()
						for _, win in ipairs(vim.api.nvim_list_wins()) do
							if vim.api.nvim_get_option_value("diff", { win = win }) then
								vim.api.nvim_set_option_value("wrap", true, { win = win })
								vim.api.nvim_set_option_value("linebreak", true, { win = win })
							end
						end
					end, 100)
				end, { buffer = bufnr, desc = "Git diff this file with wrap" })
			end,
		},
	},
}
