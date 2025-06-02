return {
  "jake-stewart/multicursor.nvim",
  -- branch = "1.0",
  config = function()
    local mc = require "multicursor-nvim"
    mc.setup()

    local set = vim.keymap.set

    -- match new cursors within visual selections by regex.
    set("x", "m", mc.matchCursors)

    -- Append/insert for each line of visual selections.
    -- Similar to block selection insertion.
    set("x", "I", mc.insertVisual)
    set("x", "A", mc.appendVisual)

    -- Align cursor columns.
    set("n", "<leader>A", mc.alignCursors)

    -- Disable and enable cursors.
    set({ "n", "x" }, "<M-c>", mc.toggleCursor)

    -- Add or skip cursor above/below the main cursor.
    set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
    set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)

    -- Add or skip adding a new cursor by matching word/selection
    set({ "n", "x" }, "gj", function() mc.matchAddCursor(1) end)
    set({ "n", "x" }, "gk", function() mc.matchAddCursor(-1) end)

    -- Pressing `gaip` will add a cursor on each line of a paragraph.
    set("n", "ga", mc.addCursorOperator)

    -- Pressing `<leader>miwap` will create a cursor in every match of the
    -- string captured by `iw` inside range `ap`.
    -- This action is highly customizable, see `:h multicursor-operator`.
    set({ "n", "x" }, "gb", mc.operator)

    -- Increment/decrement sequences, treaing all cursors as one sequence.
    set({ "n", "x" }, "g<c-a>", mc.sequenceIncrement)
    set({ "n", "x" }, "g<c-x>", mc.sequenceDecrement)

    -- Add and remove cursors with alt + left click.
    set("n", "<M-leftmouse>", mc.handleMouse)
    set("n", "<M-leftdrag>", mc.handleMouseDrag)
    set("n", "<M-leftrelease>", mc.handleMouseRelease)

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      -- Select a different cursor as the main one.
      layerSet({ "n", "x" }, "<left>", mc.prevCursor)
      layerSet({ "n", "x" }, "<right>", mc.nextCursor)

      -- Delete the main cursor.
      layerSet({ "n", "x" }, "<M-c>", mc.toggleCursor)

      -- Enable and clear cursors using escape.
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
