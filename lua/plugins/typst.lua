-- Typst configuration with tinymist LSP and live preview
return {
	-- Tinymist LSP configuration
	{
		"AstroNvim/astrolsp",
		opts = {
			config = {
				tinymist = {
					settings = {
						formatterMode = "typstyle",
						exportPdf = "onType",
						semanticTokens = "disable",
					},
					on_attach = function(client, bufnr)
						vim.keymap.set("n", "<leader>tm", function()
							client:exec_cmd({
								title = "pin",
								command = "tinymist.pinMain",
								arguments = { vim.api.nvim_buf_get_name(0) },
							}, { bufnr = bufnr })
						end, { desc = "[T]inymist Pin [M]ain", noremap = true, buffer = bufnr })

						vim.keymap.set("n", "<leader>tu", function()
							client:exec_cmd({
								title = "unpin",
								command = "tinymist.pinMain",
								arguments = { vim.v.null },
							}, { bufnr = bufnr })
						end, { desc = "[T]inymist [U]npin", noremap = true, buffer = bufnr })
					end,
				},
			},
		},
	},

	-- Live preview plugin
	{
		"chomosuke/typst-preview.nvim",
		lazy = false,
		version = "1.*",
		ft = "typst",
		opts = {},
	},
}
