---@type LazySpec
return {
  "Julian/lean.nvim",
  ft = "lean", -- load on Lean files (remove to load eagerly)
  dependencies = {
    -- Optional but recommended: enables :Telescope loogle and
    -- :Telescope lean_abbreviations. (Modern lean.nvim does NOT need plenary.)
    "nvim-telescope/telescope.nvim",
  },
  ---@type lean.Config
  opts = {
    -- Keymaps are configured EXPLICITLY in `config` below instead of the blanket
    -- `mappings = true`, following the lean.nvim manual:
    -- https://github.com/Julian/lean.nvim/wiki/The-lean.nvim-Manual#key-mappings
    -- This keeps the suggested <LocalLeader> (",") binds while letting us see and
    -- control every key, so nothing silently shadows our other keymaps.
    -- (Infoview-window keys like <CR>/gd/]g are set by lean.nvim regardless and
    -- live only in its `leaninfo` scratch buffer — they never need our flag.)
    mappings = false,
    abbreviations = { enable = true, leader = "\\" }, -- \to → → , \all → ∀ , ...
    infoview = { autoopen = true }, -- persistent goal-state window
    -- lean.nvim starts the Lean server itself (lake serve / lean --server);
    -- do NOT add Lean to nvim-lspconfig or mason, or you'll run two servers.
  },
  config = function(_, opts)
    require("lean").setup(opts)

    -- Buffer-local Lean keymaps. LocalLeader is "," in this config
    -- (lua/lazy_setup.lua), so each key below is reachable as `,<key>`. They are
    -- buffer-local to Lean files and live in a different namespace than the global
    -- <Leader> (Space) maps, so they cannot shadow anything in astrocore.lua. The
    -- RHS uses the `:Lean*` user commands lean.nvim registers at setup.
    --
    -- `K` (hover) is left to AstroLSP, which binds it on LspAttach (after this
    -- runs); LeanHover just calls vim.lsp.buf.hover() unless you set
    -- `lsp = { enhanced_handlers = { hover = true } }`. AstroLSP's `gD` is gated on
    -- textDocument/declaration, which leanls doesn't implement, so `gD` stays
    -- unbound in Lean files — use `gd` go-to-definition instead.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "lean",
      group = vim.api.nvim_create_augroup("lean_keymaps", { clear = true }),
      desc = "Lean buffer-local keymaps",
      callback = function(ev)
        local function map(lhs, cmd, desc)
          vim.keymap.set("n", lhs, "<cmd>" .. cmd .. "<cr>", {
            buffer = ev.buf,
            silent = true,
            desc = "Lean: " .. desc,
          })
        end

        -- Infoview window
        map("<LocalLeader>i", "LeanInfoviewToggle", "Toggle infoview")
        map("<LocalLeader><Tab>", "LeanGotoInfoview", "Jump into infoview")
        map("<LocalLeader>v", "LeanInfoviewViewOptions", "Infoview view options")
        map("<LocalLeader>p", "LeanInfoviewPinTogglePause", "Pause/resume infoview")
        map("<LocalLeader>w", "LeanInfoviewEnableWidgets", "Enable widgets")
        map("<LocalLeader>W", "LeanInfoviewDisableWidgets", "Disable widgets")

        -- Pins (`,d…` = diff-pin subgroup)
        map("<LocalLeader>x", "LeanInfoviewAddPin", "Add pin")
        map("<LocalLeader>c", "LeanInfoviewClearPins", "Clear pins")
        map("<LocalLeader>dx", "LeanInfoviewSetDiffPin", "Set diff pin")
        map("<LocalLeader>dc", "LeanInfoviewClearDiffPin", "Clear diff pin")
        map("<LocalLeader>dd", "LeanInfoviewToggleAutoDiffPin", "Toggle auto-diff")
        map("<LocalLeader>dt", "LeanInfoviewToggleNoClearAutoDiffPin", "Toggle auto-diff (keep pins)")

        -- Editing / server
        map("<LocalLeader>s", "LeanInfoviewAcceptSuggestion", "Accept first 'Try this' suggestion")
        map("<LocalLeader>r", "LeanRestartFile", "Restart Lean server for file")
        map([[<LocalLeader>\]], "LeanAbbreviationsReverseLookup", "How to type symbol under cursor")

        -- Handy extras lean.nvim ships but the suggested set omits (uncomment to use):
        -- map("<LocalLeader>S", "LeanSorryFill", "Fill in `sorry` placeholders")
        -- map("<LocalLeader>m", "LeanModuleImports", "Show module imports")
      end,
    })
  end,
}
