---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "pyright",
        "rust-analyzer",
        "tinymist",
        "texlab",
        "stylua",
        "prettier",
        "black",
        "latexindent",
        "eslint_d",
        "bacon",
      },
    },
  },
}
