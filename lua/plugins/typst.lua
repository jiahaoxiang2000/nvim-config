-- Typst configuration with tinymist LSP and live preview
return {
  -- Tinymist LSP configuration
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        tinymist = {
          settings = {
            formatterMode = "typstyle",
            exportPdf = "onType",
            semanticTokens = "disable",
          },
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<leader>wm", function()
              client:exec_cmd({
                title = "pin",
                command = "tinymist.pinMain",
                arguments = { vim.api.nvim_buf_get_name(0) },
              }, { bufnr = bufnr })
            end, { desc = "[W]riting Typst Pin [M]ain", noremap = true, buffer = bufnr })

            vim.keymap.set("n", "<leader>wu", function()
              client:exec_cmd({
                title = "unpin",
                command = "tinymist.pinMain",
                arguments = { vim.v.null },
              }, { bufnr = bufnr })
            end, { desc = "[W]riting Typst [U]npin", noremap = true, buffer = bufnr })
          end,
        },
      },
    },
  },

  -- Live preview plugin
  {
    "chomosuke/typst-preview.nvim",
    lazy = false,
    version = "1.*",
    ft = "typst",
    opts = {},
    keys = {
      {
        "<leader>wp",
        "<cmd>TypstPreviewToggle<cr>",
        desc = "[W]riting Typst [P]review Toggle",
        ft = "typst",
      },
      {
        "<leader>wf",
        "<cmd>TypstPreviewFollowCursorToggle<cr>",
        desc = "[W]riting Typst [F]ollow Cursor Toggle",
        ft = "typst",
      },
      {
        "<leader>ws",
        "<cmd>TypstPreviewSyncCursor<cr>",
        desc = "[W]riting Typst [S]ync Cursor",
        ft = "typst",
      },
      {
        "<leader>wn",
        "<cmd>TypstPreviewNoFollowCursor<cr>",
        desc = "[W]riting Typst [N]o Follow Cursor",
        ft = "typst",
      },
    },
  },
}
