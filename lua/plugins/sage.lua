-- SageMath (.sage) support. Neovim already detects *.sage as filetype "sage"
-- but ships no syntax, ftplugin, indent, or LSP for it; no sage treesitter
-- grammar or language server exists either (the community-standard setup is
-- python-parser highlighting + a python LSP attached to sage buffers).

-- Reuse the python treesitter parser for sage buffers. Spec files are
-- required during lazy.setup(), before the first FileType event, which is
-- early enough for astrocore's treesitter integration to resolve
-- sage -> python for parser auto-install, highlight, and indent. The few
-- preparser-only constructs (R.<x> = QQ[]) show as localized ERROR nodes;
-- python's grammar recovers well around them.
vim.treesitter.language.register("python", "sage")

local sage_repl ---@type Terminal?

---The shared sage REPL terminal, created on first use and spawned on open.
local function sage_term()
  if not sage_repl then
    sage_repl = require("toggleterm.terminal").Terminal:new {
      cmd = "sage -q",
      direction = "horizontal",
      hidden = true, -- keep it out of the generic ToggleTerm rotation
    }
  end
  return sage_repl
end

---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      filetypes = {
        -- .sage detection is built into the runtime; .spyx (Sage Cython) is not
        extension = { spyx = "pyrex" },
      },
      autocmds = {
        sage_settings = {
          {
            event = "FileType",
            pattern = "sage",
            desc = "Sage buffer-local options and REPL keymaps",
            callback = function(ev)
              -- no ftplugin ships for ft=sage, so nothing else sets these
              vim.bo[ev.buf].commentstring = "# %s"
              vim.bo[ev.buf].makeprg = "sage -t %" -- :make runs the file's doctests
              -- basedpyright attaches (see astrolsp below) for completion,
              -- hover, and goto-definition, but Sage preparser syntax
              -- (R.<x> = QQ[], ^ as power, bare Integer literals) makes its
              -- diagnostics pure noise on .sage files.
              vim.diagnostic.enable(false, { bufnr = ev.buf })

              local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = "Sage: " .. desc })
              end

              map("n", "<LocalLeader>r", function() sage_term():toggle() end, "Toggle REPL")

              -- attach() makes the REPL re-preparse and reload the file after
              -- every :w — the canonical edit-in-editor sage workflow.
              map("n", "<LocalLeader>a", function()
                local term = sage_term()
                if not term:is_open() then term:open() end
                term:send(("attach(%q)"):format(vim.api.nvim_buf_get_name(ev.buf)), true)
              end, "attach() file to REPL (reloads on :w)")

              map("x", "<LocalLeader>s", function()
                local term = sage_term()
                if not term:is_open() then term:open() end
                -- leave visual mode so the '< and '> marks (which
                -- send_lines_to_terminal reads) cover the current selection
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
                require("toggleterm").send_lines_to_terminal("visual_lines", true, { args = term.id })
              end, "Send selection to REPL")
            end,
          },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      config = {
        basedpyright = {
          -- this list REPLACES the default { "python" } (tbl_deep_extend
          -- never merges lists), so "python" must be repeated here
          filetypes = { "python", "sage" },
          -- the server only understands languageId "python"; by default the
          -- buffer's filetype ("sage") would be sent and the file ignored
          get_language_id = function() return "python" end,
        },
      },
    },
  },
}
