return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      options = {
        opt = {
          wrap = true,    -- Enable line wrapping
          linebreak = true, -- Break lines at word boundaries
          breakindent = true, -- Preserve indentation for wrapped lines
          spell = true,   -- Enable spell checking
          spelllang = "en_us", -- Set spell check language
        },
      },
      autocmds = {
        autosave_with_format = {
          {
            event = { "InsertLeave" },
            desc = "Auto save and format on leaving insert",
            callback = function()
              -- Only save if file is modifiable and has a name
              if vim.bo.modifiable and vim.fn.expand("%") ~= "" and not vim.bo.readonly then
                -- Format first
                vim.lsp.buf.format({ async = false })
                -- Then save
                vim.cmd("silent! write")
              end
            end,
          },
        },
      },
      mappings = {
        n = {
          -- Ctrl+w to close buffer
          ["<C-w>"] = {
            function()
              require("astrocore.buffer").close()
            end,
            desc = "Close buffer",
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
