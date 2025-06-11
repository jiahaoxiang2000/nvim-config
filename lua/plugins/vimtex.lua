return {
  "lervag/vimtex",
  lazy = false,
  init = function()
      -- VimTeX configuration goes here, e.g.
      local os_name = vim.loop.os_uname().sysname
      if os_name == "Darwin" then
          -- macOS - use open command to launch Skim with SyncTeX support
          vim.g.vimtex_view_general_viewer = "open"
          vim.g.vimtex_view_general_options = "-a Skim @pdf"
          -- Enable SyncTeX for forward/inverse search
          vim.g.vimtex_view_skim_sync = 1
          vim.g.vimtex_view_skim_activate = 1
      else
        -- Linux - use okular
        vim.g.vimtex_view_general_viewer = "okular"
        vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
      end
      vim.g.vimtex_quickfix_mode = 0
  end,
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        vimtex_mapping_descriptions = {
          {
            event = "FileType",
            desc = "Set up VimTex Which-Key descriptions",
            pattern = "tex",
            callback = function(event)
              local wk_avail, wk = pcall(require, "which-key")
              if not wk_avail then return end
              wk.add {
                buffer = event.buf,
                {
                  mode = "n",
                  { ",l", group = "VimTeX" },
                  { ",la", desc = "Show Context Menu" },
                  { ",lC", desc = "Full Clean" },
                  { ",lc", desc = "Clean" },
                  { ",le", desc = "Show Errors" },
                  { ",lG", desc = "Show Status for All" },
                  { ",lg", desc = "Show Status" },
                  { ",li", desc = "Show Info" },
                  { ",lI", desc = "Show Full Info" },
                  { ",lk", desc = "Stop VimTeX" },
                  { ",lK", desc = "Stop All VimTeX" },
                  { ",lL", desc = "Compile Selection" },
                  { ",ll", desc = "Compile" },
                  { ",lm", desc = "Show Imaps" },
                  { ",lo", desc = "Show Compiler Output" },
                  { ",lq", desc = "Show VimTeX Log" },
                  { ",ls", desc = "Toggle Main" },
                  { ",lt", desc = "Open Table of Contents" },
                  { ",lT", desc = "Toggle Table of Contents" },
                  { ",lv", desc = "View Compiled Document" },
                  { ",lX", desc = "Reload VimTeX State" },
                  { ",lx", desc = "Reload VimTeX" },
                  { "ts", group = "VimTeX Toggles & Cycles" },
                  { "ts$", desc = "Cycle inline, display & numbered equation" },
                  { "tsc", desc = "Toggle star of command" },
                  { "tsd", desc = "Cycle (), \\left(\\right) [,...]" },
                  { "tsD", desc = "Reverse Cycle (), \\left(\\right) [, ...]" },
                  { "tse", desc = "Toggle star of environment" },
                  { "tsf", desc = "Toggle a/b vs \\frac{a}{b}" },
                  { "[/", desc = "Previous start of a LaTeX comment" },
                  { "[*", desc = "Previous end of a LaTeX comment" },
                  { "[[", desc = "Previous beginning of a section" },
                  { "[]", desc = "Previous end of a section" },
                  { "[m", desc = "Previous \\begin" },
                  { "[M", desc = "Previous \\end" },
                  { "[n", desc = "Previous start of a math zone" },
                  { "[N", desc = "Previous end of a math zone" },
                  { "[r", desc = "Previous \\begin{frame}" },
                  { "[R", desc = "Previous \\end{frame}" },
                  { "]/", desc = "Next start of a LaTeX comment %" },
                  { "]*", desc = "Next end of a LaTeX comment %" },
                  { "][", desc = "Next beginning of a section" },
                  { "]]", desc = "Next end of a section" },
                  { "]m", desc = "Next \\begin" },
                  { "]M", desc = "Next \\end" },
                  { "]n", desc = "Next start of a math zone" },
                  { "]N", desc = "Next end of a math zone" },
                  { "]r", desc = "Next \\begin{frame}" },
                  { "]R", desc = "Next \\end{frame}" },
                  { "csc", desc = "Change surrounding command" },
                  { "cse", desc = "Change surrounding environment" },
                  { "cs$", desc = "Change surrounding math zone" },
                  { "csd", desc = "Change surrounding delimiter" },
                  { "dsc", desc = "Delete surrounding command" },
                  { "dse", desc = "Delete surrounding environment" },
                  { "ds$", desc = "Delete surrounding math zone" },
                  { "dsd", desc = "Delete surrounding delimiter" },
                },
                {
                  mode = "o",
                  { "ic", desc = "LaTeX Command" },
                  { "ac", desc = "LaTeX Command" },
                  { "id", desc = "LaTeX Math Delimiter" },
                  { "ad", desc = "LaTeX Math Delimiter" },
                  { "ie", desc = "LaTeX Environment" },
                  { "ae", desc = "LaTeX Environment" },
                  { "i$", desc = "LaTeX Math Zone" },
                  { "a$", desc = "LaTeX Math Zone" },
                  { "iP", desc = "LaTeX Section, Paragraph, ..." },
                  { "aP", desc = "LaTeX Section, Paragraph, ..." },
                  { "im", desc = "LaTeX Item" },
                  { "am", desc = "LaTeX Item" },
                },
              }
            end,
          },
        },
      },
    },
  },
}
