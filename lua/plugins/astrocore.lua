---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = {
        wrap = true,
        linebreak = true,
        breakindent = true,
        spell = false,
        spelllang = "en_us",
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

            if not vim.bo[bufnr].modifiable or bufname == "" or vim.bo[bufnr].readonly then return end
            if not vim.bo[bufnr].modified then return end

            local timer_key = "autosave_timer"
            if vim.b[bufnr][timer_key] then vim.fn.timer_stop(vim.b[bufnr][timer_key]) end

            vim.b[bufnr][timer_key] = vim.fn.timer_start(500, function()
              if not vim.api.nvim_buf_is_valid(bufnr) or not vim.bo[bufnr].modified then return end

              vim.cmd "silent! write"
              vim.b[bufnr][timer_key] = nil
            end)
          end,
        },
      },
    },
    mappings = {
      n = {
        ["<Leader>b"] = { desc = "Buffers" },
        ["<Leader>w"] = { desc = "Writing" },
        ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
        ["<C-w>"] = {
          function() require("astrocore.buffer").close() end,
          desc = "Close buffer",
        },
        ["<C-S-w>"] = {
          function()
            local current_buf = vim.api.nvim_get_current_buf()
            local bufs = vim.t.bufs or {}
            for _, bufnr in ipairs(bufs) do
              if bufnr ~= current_buf then require("astrocore.buffer").close(bufnr) end
            end
          end,
          desc = "Close all buffers except current",
        },
        ["<A-1>"] = {
          function()
            local bufs = vim.t.bufs
            if bufs and bufs[1] then vim.api.nvim_set_current_buf(bufs[1]) end
          end,
          desc = "Go to 1st buffer",
        },
        ["<A-2>"] = {
          function()
            local bufs = vim.t.bufs
            if bufs and bufs[2] then vim.api.nvim_set_current_buf(bufs[2]) end
          end,
          desc = "Go to 2nd buffer",
        },
        ["<A-3>"] = {
          function()
            local bufs = vim.t.bufs
            if bufs and bufs[3] then vim.api.nvim_set_current_buf(bufs[3]) end
          end,
          desc = "Go to 3rd buffer",
        },
        ["<A-4>"] = {
          function()
            local bufs = vim.t.bufs
            if bufs and bufs[4] then vim.api.nvim_set_current_buf(bufs[4]) end
          end,
          desc = "Go to 4th buffer",
        },
        ["<A-5>"] = {
          function()
            local bufs = vim.t.bufs
            if bufs and bufs[5] then vim.api.nvim_set_current_buf(bufs[5]) end
          end,
          desc = "Go to 5th buffer",
        },
        ["<A-6>"] = {
          function()
            local bufs = vim.t.bufs
            if bufs and bufs[6] then vim.api.nvim_set_current_buf(bufs[6]) end
          end,
          desc = "Go to 6th buffer",
        },
        ["<A-7>"] = {
          function()
            local bufs = vim.t.bufs
            if bufs and bufs[7] then vim.api.nvim_set_current_buf(bufs[7]) end
          end,
          desc = "Go to 7th buffer",
        },
        ["<A-8>"] = {
          function()
            local bufs = vim.t.bufs
            if bufs and bufs[8] then vim.api.nvim_set_current_buf(bufs[8]) end
          end,
          desc = "Go to 8th buffer",
        },
        ["<A-9>"] = {
          function()
            local bufs = vim.t.bufs
            if bufs and bufs[9] then vim.api.nvim_set_current_buf(bufs[9]) end
          end,
          desc = "Go to 9th buffer",
        },
        ["<C-S-k>"] = { "<cmd>Treewalker Up<cr>", silent = true, desc = "Treewalker up" },
        ["<C-S-j>"] = { "<cmd>Treewalker Down<cr>", silent = true, desc = "Treewalker down" },
        ["<C-S-h>"] = { "<cmd>Treewalker Left<cr>", silent = true, desc = "Treewalker left" },
        ["<C-S-l>"] = { "<cmd>Treewalker Right<cr>", silent = true, desc = "Treewalker right" },
      },
      x = {
        ["<C-S-k>"] = { "<cmd>Treewalker Up<cr>", silent = true, desc = "Treewalker up" },
        ["<C-S-j>"] = { "<cmd>Treewalker Down<cr>", silent = true, desc = "Treewalker down" },
        ["<C-S-h>"] = { "<cmd>Treewalker Left<cr>", silent = true, desc = "Treewalker left" },
        ["<C-S-l>"] = { "<cmd>Treewalker Right<cr>", silent = true, desc = "Treewalker right" },
      },
    },
  },
}
