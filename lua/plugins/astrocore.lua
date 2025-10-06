return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      options = {
        opt = {
          wrap = true,        -- Enable line wrapping
          linebreak = true,   -- Break lines at word boundaries
          breakindent = true, -- Preserve indentation for wrapped lines
        },
      },
      mappings = {
        n = {
          -- Alt+number to switch to Nth buffer in the list
          ["<A-1>"] = { function()
            local bufs = vim.fn.getbufinfo({ buflisted = 1 })
            if bufs[1] then vim.cmd("buffer " .. bufs[1].bufnr) end
          end, desc = "Go to 1st buffer" },
          ["<A-2>"] = { function()
            local bufs = vim.fn.getbufinfo({ buflisted = 1 })
            if bufs[2] then vim.cmd("buffer " .. bufs[2].bufnr) end
          end, desc = "Go to 2nd buffer" },
          ["<A-3>"] = { function()
            local bufs = vim.fn.getbufinfo({ buflisted = 1 })
            if bufs[3] then vim.cmd("buffer " .. bufs[3].bufnr) end
          end, desc = "Go to 3rd buffer" },
          ["<A-4>"] = { function()
            local bufs = vim.fn.getbufinfo({ buflisted = 1 })
            if bufs[4] then vim.cmd("buffer " .. bufs[4].bufnr) end
          end, desc = "Go to 4th buffer" },
          ["<A-5>"] = { function()
            local bufs = vim.fn.getbufinfo({ buflisted = 1 })
            if bufs[5] then vim.cmd("buffer " .. bufs[5].bufnr) end
          end, desc = "Go to 5th buffer" },
          ["<A-6>"] = { function()
            local bufs = vim.fn.getbufinfo({ buflisted = 1 })
            if bufs[6] then vim.cmd("buffer " .. bufs[6].bufnr) end
          end, desc = "Go to 6th buffer" },
          ["<A-7>"] = { function()
            local bufs = vim.fn.getbufinfo({ buflisted = 1 })
            if bufs[7] then vim.cmd("buffer " .. bufs[7].bufnr) end
          end, desc = "Go to 7th buffer" },
          ["<A-8>"] = { function()
            local bufs = vim.fn.getbufinfo({ buflisted = 1 })
            if bufs[8] then vim.cmd("buffer " .. bufs[8].bufnr) end
          end, desc = "Go to 8th buffer" },
          ["<A-9>"] = { function()
            local bufs = vim.fn.getbufinfo({ buflisted = 1 })
            if bufs[9] then vim.cmd("buffer " .. bufs[9].bufnr) end
          end, desc = "Go to 9th buffer" },
        },
      },
    },
  },
}