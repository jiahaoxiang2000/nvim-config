local xtools = require "xtools"

return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  opts = {
    preview = {
      auto_preview = true,
      win_height = 999,
    },
  },
  dependencies = {
    { "junegunn/fzf" },
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        if not opts.signs then opts.signs = {} end
        opts.signs.BqfSign = { text = " " .. require("astroui").get_icon "Selected", texthl = "BqfSign" }
      end,
    },
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<M-;>"] = {
              function()
                local qf_exists = false
                for _, win in ipairs(vim.fn.getwininfo()) do
                  if win.quickfix == 1 then
                    qf_exists = true
                    break
                  end
                end
                if qf_exists then
                  vim.cmd "cclose"
                else
                  vim.cmd "copen"
                end
              end,
              desc = "Toggle Quickfix",
            },
            ["<M-9>"] = {
              function()
                vim.cmd "cprevious"
                vim.cmd "norm! zz"
              end,
              desc = "Previous quickfix item",
            },
            ["<M-0>"] = {
              function()
                vim.cmd "cnext"
                vim.cmd "norm! zz"
              end,
              desc = "Next quickfix item",
            },
            ["<M-(>"] = {
              function()
                vim.cmd "cfirst"
                vim.cmd "norm! zz"
              end,
              desc = "First quickfix item",
            },
            ["<M-)>"] = {
              function()
                vim.cmd "clast"
                vim.cmd "norm! zz"
              end,
              desc = "Last quickfix item",
            },
            ["<M-8>"] = {
              function()
                vim.cmd "cc"
                vim.cmd "norm! zz"
              end,
              desc = "Current quickfix item",
            },
            ["<M-*>"] = {
              function()
                xtools.goto_nearest_qf_item()
                vim.cmd "cc"
                vim.cmd "norm! zz"
              end,
              desc = "Nearest quickfix item",
            },
            ["<M-7>"] = {
              function() xtools.sort_qf() end,
              desc = "Sort qflist",
            },
            ["<M-&>"] = {
              function() xtools.filter_qflist_current_buffer() end,
              desc = "Filter qflist in current buffer",
            },
          },
          v = {
            ["<Leader>vv"] = {
              function() xtools.filter_qflist_visual() end,
              desc = "Filter qflist in visual mode",
            },
          },
        },
      },
    },
  },
}
