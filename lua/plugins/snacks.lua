local Snacks = require "snacks"

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      },
    },
  },
  keys = {
    { "<Leader>se", function() Snacks.explorer() end, desc = "File Explorer" },
    -- Grep
    { "<Leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<Leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<Leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<Leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    { "<Leader>sf", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    -- search
    { "<Leader>sr", function() Snacks.picker.registers() end, desc = "Registers" },
    { "<Leader>s/", function() Snacks.picker.search_history() end, desc = "Search History" },
    { "<Leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<Leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<Leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<Leader>sC", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<Leader>sd", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<Leader>sD", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<Leader>sn", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<Leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<Leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<Leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<Leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<Leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<Leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<Leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<Leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
    { "<Leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<Leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<Leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
    { "<Leader>sx", function() Snacks.toggle.dim()() end, desc = "Snacks dim" },

    { "<Leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<Leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    -- Other
    { "<M-p>", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    { "<M-n>", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "<Leader>sz", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<Leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<Leader>s.", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        -- Snacks.toggle.treesitter():map "<Leader>uT"
        Snacks.toggle.dim():map "<Leader>sx"
      end,
    })
  end,
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<M-w>"] = { function() Snacks.picker.buffers() end, desc = "Find Buffer" },
          ["<Leader>s"] = { name = "Snacks" },
          ["<Leader>fp"] = {
            function()
              Snacks.picker.projects {
                win = {
                  input = {
                    keys = {
                      ["<c-e>"] = { { "tcd", "picker_explorer" }, mode = { "n", "i" } },
                      ["<c-f>"] = { { "tcd", "picker_files" }, mode = { "n", "i" } },
                      ["<c-g>"] = { { "tcd", "picker_grep" }, mode = { "n", "i" } },
                      ["<c-r>"] = { { "tcd", "picker_recent" }, mode = { "n", "i" } },
                      ["<c-w>"] = { { "tcd", "cancel" }, mode = { "n", "i" } },
                    },
                  },
                },
              }
            end,
            desc = "Find projects",
          },
          ["<Leader>fz"] = {
            function()
              Snacks.picker.zoxide {
                win = {
                  input = {
                    keys = {
                      ["<c-e>"] = { { "tcd", "picker_explorer" }, mode = { "n", "i" } },
                      ["<c-f>"] = { { "tcd", "picker_files" }, mode = { "n", "i" } },
                      ["<c-g>"] = { { "tcd", "picker_grep" }, mode = { "n", "i" } },
                      ["<c-r>"] = { { "tcd", "picker_recent" }, mode = { "n", "i" } },
                      ["<c-w>"] = { { "tcd", "cancel" }, mode = { "n", "i" } },
                    },
                  },
                },
              }
            end,
            desc = "Snacks zoxide",
          },
        },
      },
    },
  },
}
