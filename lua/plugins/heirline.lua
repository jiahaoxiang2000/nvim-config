return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"

    local selection_info = {
      condition = function() return vim.fn.mode():find "[vV]" end,
      provider = function()
        local start_line = vim.fn.getpos("v")[2]
        local end_line = vim.fn.getpos(".")[2]
        local line_count = math.abs(end_line - start_line) + 1

        local text = require("xtools").get_vbuf_content()
        local char_count = vim.fn.strchars(text)

        if vim.fn.mode():find "[]" then
          return string.format(
            "  Sel: %dx%d -> %d",
            line_count,
            math.abs(vim.fn.getpos(".")[3] - vim.fn.getpos("v")[3]) + 1,
            char_count
          )
        else
          return string.format("  Sel: %d|%d", line_count, char_count)
        end
      end,
      hl = { fg = "#FF9E3B", bold = true },
    }

    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(),
      status.component.git_branch(),
      status.component.file_info {
        filename = { modify = ":p" },
        filetype = false,
      },
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      selection_info,
      status.component.lsp(),
      status.component.virtual_env(),
      status.component.treesitter(),
      status.component.nav(),
      status.component.mode { surround = { separator = "right" } },
    }
  end,
}
