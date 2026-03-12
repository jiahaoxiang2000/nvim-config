return {
	{
		"AstroNvim/astrocore",
		---@type AstroCoreOpts
		opts = {
			options = {
				opt = {
					wrap = true, -- Enable line wrapping
					linebreak = true, -- Break lines at word boundaries
					breakindent = true, -- Preserve indentation for wrapped lines
					spell = false, -- Enable spell checking
					spelllang = "en_us", -- Set spell check language
				},
			},
			autocmds = {
				autosave = {
					{
						event = { "InsertLeave", "TextChanged" },
						desc = "Auto save on leaving insert or text change",
						callback = function()
							local bufnr = vim.api.nvim_get_current_buf()
							local bufname = vim.api.nvim_buf_get_name(bufnr)

							-- Check if buffer is valid for saving
							if not vim.bo[bufnr].modifiable or bufname == "" or vim.bo[bufnr].readonly then
								return
							end

							-- Check if buffer has been modified
							if not vim.bo[bufnr].modified then
								return
							end

							-- Debounce: use a buffer-local timer to avoid excessive saves
							local timer_key = "autosave_timer"
							if vim.b[bufnr][timer_key] then
								vim.fn.timer_stop(vim.b[bufnr][timer_key])
							end

							vim.b[bufnr][timer_key] = vim.fn.timer_start(500, function()
								-- Check again if buffer is still valid
								if not vim.api.nvim_buf_is_valid(bufnr) or not vim.bo[bufnr].modified then
									return
								end

								-- Save the buffer
								vim.cmd("silent! write")
								vim.b[bufnr][timer_key] = nil
							end)
						end,
					},
				},
			},
			mappings = {
				n = {
					-- Disable default <leader>q to avoid conflict with CodeQL mappings
					-- ["<Leader>q"] = false,
					-- Ctrl+w to close buffer
					["<C-w>"] = {
						function()
							require("astrocore.buffer").close()
						end,
						desc = "Close buffer",
					},
					-- Close all buffers except current
					["<C-S-w>"] = {
						function()
							local current_buf = vim.api.nvim_get_current_buf()
							local bufs = vim.t.bufs or {}
							for _, bufnr in ipairs(bufs) do
								if bufnr ~= current_buf then
									require("astrocore.buffer").close(bufnr)
								end
							end
						end,
						desc = "Close all buffers except current",
					},
					-- Alt+number to switch to Nth buffer in the list
					["<A-1>"] = {
						function()
							local bufs = vim.t.bufs
							if bufs and bufs[1] then
								vim.api.nvim_set_current_buf(bufs[1])
							end
						end,
						desc = "Go to 1st buffer",
					},
					["<A-2>"] = {
						function()
							local bufs = vim.t.bufs
							if bufs and bufs[2] then
								vim.api.nvim_set_current_buf(bufs[2])
							end
						end,
						desc = "Go to 2nd buffer",
					},
					["<A-3>"] = {
						function()
							local bufs = vim.t.bufs
							if bufs and bufs[3] then
								vim.api.nvim_set_current_buf(bufs[3])
							end
						end,
						desc = "Go to 3rd buffer",
					},
					["<A-4>"] = {
						function()
							local bufs = vim.t.bufs
							if bufs and bufs[4] then
								vim.api.nvim_set_current_buf(bufs[4])
							end
						end,
						desc = "Go to 4th buffer",
					},
					["<A-5>"] = {
						function()
							local bufs = vim.t.bufs
							if bufs and bufs[5] then
								vim.api.nvim_set_current_buf(bufs[5])
							end
						end,
						desc = "Go to 5th buffer",
					},
					["<A-6>"] = {
						function()
							local bufs = vim.t.bufs
							if bufs and bufs[6] then
								vim.api.nvim_set_current_buf(bufs[6])
							end
						end,
						desc = "Go to 6th buffer",
					},
					["<A-7>"] = {
						function()
							local bufs = vim.t.bufs
							if bufs and bufs[7] then
								vim.api.nvim_set_current_buf(bufs[7])
							end
						end,
						desc = "Go to 7th buffer",
					},
					["<A-8>"] = {
						function()
							local bufs = vim.t.bufs
							if bufs and bufs[8] then
								vim.api.nvim_set_current_buf(bufs[8])
							end
						end,
						desc = "Go to 8th buffer",
					},
					["<A-9>"] = {
						function()
							local bufs = vim.t.bufs
							if bufs and bufs[9] then
								vim.api.nvim_set_current_buf(bufs[9])
							end
						end,
						desc = "Go to 9th buffer",
					},
				},
			},
		},
	},
}
