local uv = vim.uv or vim.loop

---@param source string|integer
---@param markers string[]
---@return string
local function find_root(source, markers)
  local path = source
  if type(source) == "number" then
    path = vim.api.nvim_buf_get_name(source)
    if path == "" then return vim.fn.getcwd() end
  end

  local match = vim.fs.find(markers, { upward = true, path = path })[1]
  return match and vim.fs.dirname(match) or vim.fn.getcwd()
end

---@param markers string[]
---@return fun(bufnr: integer, on_dir: fun(root_dir: string))
local function root_dir(markers)
  return function(bufnr, on_dir) on_dir(find_root(bufnr, markers)) end
end

---@param client vim.lsp.Client
---@param bufnr integer
local function attach_texlab_keymaps(client, bufnr)
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
    client.request("textDocument/forwardSearch", params, function(err)
      if err then vim.notify("Forward search error: " .. vim.inspect(err), vim.log.levels.ERROR) end
    end, bufnr)
  end, { desc = "[W]riting LaTeX [V]iew (forward search)", noremap = true, buffer = bufnr })
end

---@param client vim.lsp.Client
---@param bufnr integer
local function attach_tinymist_keymaps(client, bufnr)
  ---@param command string
  ---@param arguments any[]
  local function exec_tinymist(command, arguments)
    client.request("workspace/executeCommand", {
      command = command,
      arguments = arguments,
    }, nil, bufnr)
  end

  vim.keymap.set("n", "<leader>wm", function()
    exec_tinymist("tinymist.pinMain", { vim.api.nvim_buf_get_name(bufnr) })
  end, { desc = "[W]riting Typst Pin [M]ain", noremap = true, buffer = bufnr })

  vim.keymap.set("n", "<leader>wu", function()
    exec_tinymist("tinymist.pinMain", { vim.NIL })
  end, { desc = "[W]riting Typst [U]npin", noremap = true, buffer = bufnr })
end

---@type vim.lsp.Config
local texlab = {
  cmd = { "texlab" },
  filetypes = { "tex", "bib", "plaintex" },
  root_dir = root_dir { ".git", ".latexmkrc" },
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
          if uv and uv.fs_stat(skim_displayline) then
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
}

---@type vim.lsp.Config
local codeqlls = {
  cmd = {
    "/usr/bin/codeql",
    "execute",
    "language-server",
    "--check-errors",
    "ON_CHANGE",
    "-q",
  },
  filetypes = { "ql", "qll" },
  root_dir = root_dir { "qlpack.yml", ".git" },
  settings = {
    additional_packs = {
      "/opt/codeql",
      vim.fn.expand "~/.codeql/packages/",
    },
  },
}

---@type vim.lsp.Config
local tinymist = {
  settings = {
    formatterMode = "typstyle",
    exportPdf = "onType",
    semanticTokens = "disable",
  },
}

---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    event = { "BufReadPre", "BufNewFile" },
    ---@type AstroLSPOpts
    opts = {
    formatting = {
      format_on_save = {
        enabled = false,
      },
    },
    config = {
      texlab = texlab,
      codeqlls = codeqlls,
      tinymist = tinymist,
    },
    servers = { "texlab", "tinymist", "codeqlls" },
    mappings = {
      n = {
        K = {
          function() vim.lsp.buf.hover() end,
          desc = "Hover symbol details",
        },
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
      },
    },
      on_attach = function(client, bufnr)
        if client.name == "texlab" then
          attach_texlab_keymaps(client, bufnr)
        elseif client.name == "tinymist" then
          attach_tinymist_keymaps(client, bufnr)
        end
      end,
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },
}
