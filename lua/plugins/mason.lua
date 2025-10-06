-- Mason configuration for managing LSP servers, DAP servers, linters, and formatters
return {
	{
		"williamboman/mason.nvim",
		opts = {
			-- Ensure these tools are installed
			ensure_installed = {
				-- LSP Servers
				"lua-language-server",
				"pyright",
				"rust-analyzer",
				"markdown-oxide",
				"tinymist",

				-- Formatters
				"stylua",
				"prettier",
				"black",

				-- Linters
				"eslint_d",
				"markdownlint",
			},
		},
	},
}
