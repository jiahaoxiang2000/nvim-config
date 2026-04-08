---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      treesitter = {
        highlight = true,
        indent = true,
        auto_install = true,
        ensure_installed = {
          "cpp",
          "java",
          "latex",
          "lua",
          "python",
          "ql",
          "rust",
          "toml",
          "typst",
          "typescript",
          "vim",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
  },
}
