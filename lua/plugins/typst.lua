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
            local function exec_tinymist(command, arguments)
              client.request("workspace/executeCommand", {
                command = command,
                arguments = arguments,
              }, nil, bufnr)
            end

            vim.keymap.set("n", "<leader>wm", function()
              exec_tinymist("tinymist.pinMain", { vim.api.nvim_buf_get_name(0) })
            end, { desc = "[W]riting Typst Pin [M]ain", noremap = true, buffer = bufnr })

            vim.keymap.set("n", "<leader>wu", function()
              exec_tinymist("tinymist.pinMain", { vim.v.null })
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
