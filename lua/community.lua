-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- language packs
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.toml" },

  { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.git.git-blame-nvim" },
  { import = 'astrocommunity.git.gitgraph-nvim' },

  { import = "astrocommunity.motion.vim-matchup" },
  { import = "astrocommunity.motion.marks-nvim" },

  { import = "astrocommunity.project.projectmgr-nvim" },
  { import = "astrocommunity.editing-support.wildfire-nvim" },

  -- { import = "astrocommunity.color.transparent-nvim" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.utility.noice-nvim" },

  { import = "astrocommunity.recipes.ai" },

}
