return {
  "sindrets/diffview.nvim",
  event = "User AstroGitFile",
  cmd = { "DiffviewOpen" },
  opts = {
    keymaps = {
      disable_defaults = true, -- Disable the default keymaps
      view = {
        {
          "n",
          "<M-p>",
          function()
            vim.cmd "norm! [c"
            vim.cmd "norm! zz"
          end,
          { desc = "Previous diff" },
        },
        {
          "n",
          "<M-n>",
          function()
            vim.cmd "norm! ]c"
            vim.cmd "norm! zz"
          end,
          { desc = "Next diff" },
        },
        { "n", "<M-q>", function() vim.cmd "DiffviewClose" end, { desc = "Diffview close" } },
        { "n", "<tab>", require("diffview.actions").select_next_entry, { desc = "Open the diff for the next file" } },
        {
          "n",
          "<s-tab>",
          require("diffview.actions").select_prev_entry,
          { desc = "Open the diff for the previous file" },
        },
        { "n", "[F", require("diffview.actions").select_first_entry, { desc = "Open the diff for the first file" } },
        { "n", "]F", require("diffview.actions").select_last_entry, { desc = "Open the diff for the last file" } },
        { "n", "gf", require("diffview.actions").goto_file_tab, { desc = "Open the file in a new tabpage" } },
        { "n", "<Leader>b", require("diffview.actions").toggle_files, { desc = "Toggle the file panel." } },
        { "n", "g<C-x>", require("diffview.actions").cycle_layout, { desc = "Cycle through available layouts." } },
        {
          "n",
          "<S-M-p>",
          require("diffview.actions").prev_conflict,
          { desc = "In the merge-tool: jump to the previous conflict" },
        },
        {
          "n",
          "<S-M-n>",
          require("diffview.actions").next_conflict,
          { desc = "In the merge-tool: jump to the next conflict" },
        },
        {
          "n",
          ",o",
          require("diffview.actions").conflict_choose "ours",
          { desc = "Choose the OURS version of a conflict" },
        },
        {
          "n",
          ",t",
          require("diffview.actions").conflict_choose "theirs",
          { desc = "Choose the THEIRS version of a conflict" },
        },
        {
          "n",
          ",b",
          require("diffview.actions").conflict_choose "base",
          { desc = "Choose the BASE version of a conflict" },
        },
        {
          "n",
          ",a",
          require("diffview.actions").conflict_choose "all",
          { desc = "Choose all the versions of a conflict" },
        },
        { "n", "dx", require("diffview.actions").conflict_choose "none", { desc = "Delete the conflict region" } },
        {
          "n",
          ",O",
          require("diffview.actions").conflict_choose_all "ours",
          { desc = "Choose the OURS version of a conflict for the whole file" },
        },
        {
          "n",
          ",T",
          require("diffview.actions").conflict_choose_all "theirs",
          { desc = "Choose the THEIRS version of a conflict for the whole file" },
        },
        {
          "n",
          ",B",
          require("diffview.actions").conflict_choose_all "base",
          { desc = "Choose the BASE version of a conflict for the whole file" },
        },
        {
          "n",
          ",A",
          require("diffview.actions").conflict_choose_all "all",
          { desc = "Choose all the versions of a conflict for the whole file" },
        },
        {
          "n",
          "dX",
          require("diffview.actions").conflict_choose_all "none",
          { desc = "Delete the conflict region for the whole file" },
        },
      },
      diff1 = {
        -- Mappings in single window diff layouts
        { "n", "g?", require("diffview.actions").help { "view", "diff1" }, { desc = "Open the help panel" } },
      },
      diff2 = {
        -- Mappings in 2-way diff layouts
        { "n", "g?", require("diffview.actions").help { "view", "diff2" }, { desc = "Open the help panel" } },
      },
      diff3 = {
        -- Mappings in 3-way diff layouts
        {
          { "n", "x" },
          "2do",
          require("diffview.actions").diffget "ours",
          { desc = "Obtain the diff hunk from the OURS version of the file" },
        },
        {
          { "n", "x" },
          "3do",
          require("diffview.actions").diffget "theirs",
          { desc = "Obtain the diff hunk from the THEIRS version of the file" },
        },
        { "n", "g?", require("diffview.actions").help { "view", "diff3" }, { desc = "Open the help panel" } },
      },
      diff4 = {
        -- Mappings in 4-way diff layouts
        {
          { "n", "x" },
          "1do",
          require("diffview.actions").diffget "base",
          { desc = "Obtain the diff hunk from the BASE version of the file" },
        },
        {
          { "n", "x" },
          "2do",
          require("diffview.actions").diffget "ours",
          { desc = "Obtain the diff hunk from the OURS version of the file" },
        },
        {
          { "n", "x" },
          "3do",
          require("diffview.actions").diffget "theirs",
          { desc = "Obtain the diff hunk from the THEIRS version of the file" },
        },
        { "n", "g?", require("diffview.actions").help { "view", "diff4" }, { desc = "Open the help panel" } },
      },
      file_panel = {
        {
          "n",
          "<M-p>",
          function()
            require("diffview.actions").view_windo(function(_, sym)
              if sym == "b" then
                vim.cmd "norm! [c"
                vim.cmd "norm! zz"
              end
            end)()
          end,
        },
        {
          "n",
          "<M-n>",
          function()
            require("diffview.actions").view_windo(function(_, sym)
              if sym == "b" then
                vim.cmd "norm! ]c"
                vim.cmd "norm! zz"
              end
            end)()
          end,
        },
        { "n", "<M-q>", function() vim.cmd "DiffviewClose" end, { desc = "Diffview close" } },
        {
          "n",
          "j",
          require("diffview.actions").next_entry,
          { desc = "Bring the cursor to the next file entry" },
        },
        {
          "n",
          "<down>",
          require("diffview.actions").next_entry,
          { desc = "Bring the cursor to the next file entry" },
        },
        {
          "n",
          "k",
          require("diffview.actions").prev_entry,
          { desc = "Bring the cursor to the previous file entry" },
        },
        {
          "n",
          "<up>",
          require("diffview.actions").prev_entry,
          { desc = "Bring the cursor to the previous file entry" },
        },
        {
          "n",
          "<cr>",
          require("diffview.actions").select_entry,
          { desc = "Open the diff for the selected entry" },
        },
        {
          "n",
          "o",
          require("diffview.actions").select_entry,
          { desc = "Open the diff for the selected entry" },
        },
        {
          "n",
          "l",
          require("diffview.actions").select_entry,
          { desc = "Open the diff for the selected entry" },
        },
        {
          "n",
          "<2-LeftMouse>",
          require("diffview.actions").select_entry,
          { desc = "Open the diff for the selected entry" },
        },
        {
          "n",
          "s",
          require("diffview.actions").toggle_stage_entry,
          { desc = "Stage / unstage the selected entry" },
        },
        { "n", "S", require("diffview.actions").stage_all, { desc = "Stage all entries" } },
        { "n", "U", require("diffview.actions").unstage_all, { desc = "Unstage all entries" } },
        {
          "n",
          "X",
          require("diffview.actions").restore_entry,
          { desc = "Restore entry to the state on the left side" },
        },
        { "n", "L", require("diffview.actions").open_commit_log, { desc = "Open the commit log panel" } },
        { "n", "zo", require("diffview.actions").open_fold, { desc = "Expand fold" } },
        { "n", "h", require("diffview.actions").close_fold, { desc = "Collapse fold" } },
        { "n", "zc", require("diffview.actions").close_fold, { desc = "Collapse fold" } },
        { "n", "za", require("diffview.actions").toggle_fold, { desc = "Toggle fold" } },
        { "n", "zR", require("diffview.actions").open_all_folds, { desc = "Expand all folds" } },
        { "n", "zM", require("diffview.actions").close_all_folds, { desc = "Collapse all folds" } },
        { "n", "<c-b>", require("diffview.actions").scroll_view(-0.25), { desc = "Scroll the view up" } },
        { "n", "<c-f>", require("diffview.actions").scroll_view(0.25), { desc = "Scroll the view down" } },
        { "n", "<tab>", require("diffview.actions").select_next_entry, { desc = "Open the diff for the next file" } },
        {
          "n",
          "<s-tab>",
          require("diffview.actions").select_prev_entry,
          { desc = "Open the diff for the previous file" },
        },
        {
          "n",
          "[F",
          require("diffview.actions").select_first_entry,
          { desc = "Open the diff for the first file" },
        },
        { "n", "]F", require("diffview.actions").select_last_entry, { desc = "Open the diff for the last file" } },
        { "n", "gf", require("diffview.actions").goto_file_tab, { desc = "Open the file in a new tabpage" } },
        {
          "n",
          "i",
          require("diffview.actions").listing_style,
          { desc = "Toggle between 'list' and 'tree' views" },
        },
        {
          "n",
          "f",
          require("diffview.actions").toggle_flatten_dirs,
          { desc = "Flatten empty subdirectories in tree listing style" },
        },
        {
          "n",
          "R",
          require("diffview.actions").refresh_files,
          { desc = "Update stats and entries in the file list" },
        },
        { "n", "<Leader>b", require("diffview.actions").toggle_files, { desc = "Toggle the file panel" } },
        { "n", "g<C-x>", require("diffview.actions").cycle_layout, { desc = "Cycle available layouts" } },
        { "n", "<S-M-p>", require("diffview.actions").prev_conflict, { desc = "Go to the previous conflict" } },
        { "n", "<S-M-n>", require("diffview.actions").next_conflict, { desc = "Go to the next conflict" } },
        { "n", "g?", require("diffview.actions").help "file_panel", { desc = "Open the help panel" } },
        {
          "n",
          ",O",
          require("diffview.actions").conflict_choose_all "ours",
          { desc = "Choose the OURS version of a conflict for the whole file" },
        },
        {
          "n",
          ",T",
          require("diffview.actions").conflict_choose_all "theirs",
          { desc = "Choose the THEIRS version of a conflict for the whole file" },
        },
        {
          "n",
          ",B",
          require("diffview.actions").conflict_choose_all "base",
          { desc = "Choose the BASE version of a conflict for the whole file" },
        },
        {
          "n",
          ",A",
          require("diffview.actions").conflict_choose_all "all",
          { desc = "Choose all the versions of a conflict for the whole file" },
        },
        {
          "n",
          "dX",
          require("diffview.actions").conflict_choose_all "none",
          { desc = "Delete the conflict region for the whole file" },
        },
      },
      file_history_panel = {
        { "n", "g!", require("diffview.actions").options, { desc = "Open the option panel" } },
        {
          "n",
          "<C-A-d>",
          require("diffview.actions").open_in_diffview,
          { desc = "Open the entry under the cursor in a diffview" },
        },
        {
          "n",
          "y",
          require("diffview.actions").copy_hash,
          { desc = "Copy the commit hash of the entry under the cursor" },
        },
        { "n", "L", require("diffview.actions").open_commit_log, { desc = "Show commit details" } },
        {
          "n",
          "X",
          require("diffview.actions").restore_entry,
          { desc = "Restore file to the state from the selected entry" },
        },
        { "n", "zo", require("diffview.actions").open_fold, { desc = "Expand fold" } },
        { "n", "zc", require("diffview.actions").close_fold, { desc = "Collapse fold" } },
        { "n", "h", require("diffview.actions").close_fold, { desc = "Collapse fold" } },
        { "n", "za", require("diffview.actions").toggle_fold, { desc = "Toggle fold" } },
        { "n", "zR", require("diffview.actions").open_all_folds, { desc = "Expand all folds" } },
        { "n", "zM", require("diffview.actions").close_all_folds, { desc = "Collapse all folds" } },
        {
          "n",
          "j",
          require("diffview.actions").next_entry,
          { desc = "Bring the cursor to the next file entry" },
        },
        {
          "n",
          "<down>",
          require("diffview.actions").next_entry,
          { desc = "Bring the cursor to the next file entry" },
        },
        {
          "n",
          "k",
          require("diffview.actions").prev_entry,
          { desc = "Bring the cursor to the previous file entry" },
        },
        {
          "n",
          "<up>",
          require("diffview.actions").prev_entry,
          { desc = "Bring the cursor to the previous file entry" },
        },
        {
          "n",
          "<cr>",
          require("diffview.actions").select_entry,
          { desc = "Open the diff for the selected entry" },
        },
        {
          "n",
          "o",
          require("diffview.actions").select_entry,
          { desc = "Open the diff for the selected entry" },
        },
        {
          "n",
          "l",
          require("diffview.actions").select_entry,
          { desc = "Open the diff for the selected entry" },
        },
        {
          "n",
          "<2-LeftMouse>",
          require("diffview.actions").select_entry,
          { desc = "Open the diff for the selected entry" },
        },
        { "n", "<c-b>", require("diffview.actions").scroll_view(-0.25), { desc = "Scroll the view up" } },
        { "n", "<c-f>", require("diffview.actions").scroll_view(0.25), { desc = "Scroll the view down" } },
        { "n", "<tab>", require("diffview.actions").select_next_entry, { desc = "Open the diff for the next file" } },
        {
          "n",
          "<s-tab>",
          require("diffview.actions").select_prev_entry,
          { desc = "Open the diff for the previous file" },
        },
        { "n", "[F", require("diffview.actions").select_first_entry, { desc = "Open the diff for the first file" } },
        { "n", "]F", require("diffview.actions").select_last_entry, { desc = "Open the diff for the last file" } },
        { "n", "gf", require("diffview.actions").goto_file_tab, { desc = "Open the file in a new tabpage" } },
        { "n", "<Leader>b", require("diffview.actions").toggle_files, { desc = "Toggle the file panel" } },
        { "n", "g<C-x>", require("diffview.actions").cycle_layout, { desc = "Cycle available layouts" } },
        { "n", "g?", require("diffview.actions").help "file_history_panel", { desc = "Open the help panel" } },
      },
      option_panel = {
        { "n", "<tab>", require("diffview.actions").select_entry, { desc = "Change the current option" } },
        { "n", "q", require("diffview.actions").close, { desc = "Close the panel" } },
        { "n", "g?", require("diffview.actions").help "option_panel", { desc = "Open the help panel" } },
      },
      help_panel = {
        { "n", "q", require("diffview.actions").close, { desc = "Close help menu" } },
        { "n", "<esc>", require("diffview.actions").close, { desc = "Close help menu" } },
      },
    },
    enhanced_diff_hl = true,
    view = {
      default = { winbar_info = true },
      file_history = { winbar_info = true },
    },
    hooks = { diff_buf_read = function(bufnr) vim.b[bufnr].view_activated = false end },
  },
  specs = {
    {
      "NeogitOrg/neogit",
      optional = true,
      opts = { integrations = { diffview = true } },
    },
  },
}
