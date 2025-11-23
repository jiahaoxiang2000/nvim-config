return {
	-- CodeQL LSP Configuration
	{
		"AstroNvim/astrolsp",
		opts = {
			config = {
				codeqlls = {
					cmd = {
						"/usr/bin/codeql",
						"execute",
						"language-server",
						"--check-errors",
						"ON_CHANGE",
						"-q",
					},
					filetypes = { "ql", "qll" },
					root_dir = function(fname)
						return vim.fs.dirname(vim.fs.find({ "qlpack.yml", ".git" }, { upward = true, path = fname })[1])
								or vim.fn.getcwd()
					end,
					settings = {
						additional_packs = {
							"/opt/codeql",
							vim.fn.expand("~/.codeql/packages/"),
						},
					},
				},
			},
		},
	},

	-- CodeQL Plugin
	{
		"pwntester/codeql.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/telescope.nvim",
			"kyazdani42/nvim-web-devicons",
			{
				"s1n7ax/nvim-window-picker",
				version = "v1.*",
				opts = {
					autoselect_one = true,
					include_current = false,
					filter_rules = {
						bo = {
							filetype = {
								"codeql_panel",
								"codeql_explorer",
								"qf",
								"TelescopePrompt",
								"TelescopeResults",
								"notify",
								"noice",
								"NvimTree",
								"neo-tree",
							},
							buftype = { "terminal" },
						},
					},
					current_win_hl_color = "#e35e4f",
					other_win_hl_color = "#44cc41",
				},
			},
		},
		config = function()
			require("codeql").setup({
				results = {
					max_paths = 10,
					max_path_depth = nil,
				},
				panel = {
					width = 50,
					pos = "botright",
					group_by = "sink", -- "source"
					show_filename = true,
					long_filename = false,
					context_lines = 3,
				},
				max_ram = 32000,
				job_timeout = 15000,
				format_on_save = true,
				additional_packs = {
					vim.fn.expand("~/.codeql"),
				},
				mappings = {
					run_query = { modes = { "n" }, lhs = "<space>qr", desc = "run query" },
					quick_eval = { modes = { "x", "n" }, lhs = "<space>qe", desc = "quick evaluate" },
					quick_eval_predicate = {
						modes = { "n" },
						lhs = "<space>qp",
						desc = "quick evaluate enclosing predicate",
					},
				},
			})
		end,
	},
}
