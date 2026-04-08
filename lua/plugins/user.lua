local toggle_key = "<C-,>"

---@type LazySpec
return {
  {
    "mrcjkb/rustaceanvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.server = opts.server or {}

      -- AstroCommunity merges lspconfig's rust_analyzer config into rustaceanvim,
      -- but the two plugins currently expect different root_dir function signatures.
      opts.server.root_dir = function(filename, default)
        local root = type(default) == "function" and default(filename) or nil
        return root or vim.fs.root(filename, { "rust-project.json", ".git" })
      end
    end,
  },
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
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gitsigns = require "gitsigns"

        vim.keymap.set("n", "]g", function() gitsigns.nav_hunk "next" end, { buffer = bufnr, desc = "Next git hunk" })
        vim.keymap.set("n", "[g", function() gitsigns.nav_hunk "prev" end, { buffer = bufnr, desc = "Previous git hunk" })
        vim.keymap.set("n", "<leader>gw", function() gitsigns.toggle_word_diff() end,
          { buffer = bufnr, desc = "Toggle word diff" })

        vim.keymap.set("n", "<leader>gp", function()
          gitsigns.preview_hunk()
          vim.defer_fn(function()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              local buf = vim.api.nvim_win_get_buf(win)
              local bufname = vim.api.nvim_buf_get_name(buf)
              if bufname:match "gitsigns://" then
                vim.api.nvim_set_option_value("wrap", true, { win = win })
                vim.api.nvim_set_option_value("linebreak", true, { win = win })
              end
            end
          end, 50)
        end, { buffer = bufnr, desc = "Preview git hunk with wrap" })

        vim.keymap.set("n", "<leader>gd", function()
          gitsigns.diffthis()
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
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewFocusFiles", "DiffviewRefresh" },
    keys = {
      { "<leader>gD", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current)" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File History (all)" },
      { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = "diff2_horizontal",
        },
        file_history = {
          layout = "diff2_horizontal",
        },
      },
      file_panel = {
        listing_style = "list",
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "bottom",
          width = 15,
          height = 5,
        },
      },
      hooks = {
        diff_buf_read = function()
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true
        end,
      },
    },
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinLeave" },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc = "Treesitter Search",
      },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
    config = function()
      require("flash").setup {
        labels = "abcdefghijklmnopqrstuvwxyz",
        search = {
          mode = "fuzzy",
        },
        jump = {
          autojump = true,
        },
      }
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
    },
  },
  {
    "aaronik/treewalker.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufRead",
    opts = {
      highlight = true,
      highlight_duration = 250,
      highlight_group = "CursorLine",
      select = false,
      jumplist = true,
    },
  },
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
      require("codeql").setup {
        results = {
          max_paths = 10,
          max_path_depth = nil,
        },
        panel = {
          width = 50,
          pos = "botright",
          group_by = "sink",
          show_filename = true,
          long_filename = false,
          context_lines = 3,
        },
        max_ram = 32000,
        job_timeout = 15000,
        format_on_save = false,
        additional_packs = {
          vim.fn.expand "~/.codeql",
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
      }
    end,
  },
  {
    "chomosuke/typst-preview.nvim",
    lazy = false,
    version = "1.*",
    ft = "typst",
    opts = {},
    keys = {
      { "<leader>wp", "<cmd>TypstPreviewToggle<cr>", desc = "[W]riting Typst [P]review Toggle", ft = "typst" },
      {
        "<leader>wf",
        "<cmd>TypstPreviewFollowCursorToggle<cr>",
        desc = "[W]riting Typst [F]ollow Cursor Toggle",
        ft = "typst",
      },
      { "<leader>ws", "<cmd>TypstPreviewSyncCursor<cr>", desc = "[W]riting Typst [S]ync Cursor", ft = "typst" },
      { "<leader>wn", "<cmd>TypstPreviewNoFollowCursor<cr>", desc = "[W]riting Typst [N]o Follow Cursor", ft = "typst" },
    },
  },
}
