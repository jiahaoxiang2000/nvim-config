-- LaTeX configuration with texlab LSP
return {
  -- Texlab LSP configuration
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        texlab = {
          cmd = { "texlab" },
          filetypes = { "tex", "bib", "plaintex" },
          root_dir = function(fname)
            return vim.fs.dirname(vim.fs.find({ ".git", ".latexmkrc" }, { upward = true, path = fname })[1])
                or vim.fn.getcwd()
          end,
          settings = {
            texlab = {
              build = {
                executable = "latexmk",
                args = {
                  "-synctex=1",
                  "-interaction=nonstopmode",
                  "-file-line-error",
                  "%f",
                },
                onSave = true,
              },
              forwardSearch = (function()
                local skim_displayline = "/Applications/Skim.app/Contents/SharedSupport/displayline"
                if vim.fn.has("mac") == 1 then
                  if vim.uv.fs_stat(skim_displayline) then
                    return {
                      executable = skim_displayline,
                      args = { "%l", "%p", "%f" },
                    }
                  end

                  return {
                    executable = "open",
                    args = { "-a", "Preview", "%p" },
                  }
                end

                return {
                  executable = "okular",
                  args = { "--unique", "file:%p#src:%l%f" },
                }
              end)(),
              chktex = {
                onOpenAndSave = true,
                onEdit = false,
              },
            },
          },
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<leader>wb", function()
              local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
              client.request("textDocument/build", params, function(err, result)
                if err then
                  vim.notify("Build error: " .. vim.inspect(err), vim.log.levels.ERROR)
                elseif result and result.status == 0 then
                  vim.notify("Build successful", vim.log.levels.INFO)
                else
                  vim.notify("Build failed", vim.log.levels.WARN)
                end
              end, bufnr)
            end, { desc = "[W]riting LaTeX [B]uild", noremap = true, buffer = bufnr })

            vim.keymap.set("n", "<leader>wv", function()
              local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
              client.request("textDocument/forwardSearch", params, function(err, result)
                if err then
                  vim.notify("Forward search error: " .. vim.inspect(err), vim.log.levels.ERROR)
                end
              end, bufnr)
            end, { desc = "[W]riting LaTeX [V]iew (forward search)", noremap = true, buffer = bufnr })
          end,
        },
      },
    },
  },
}
