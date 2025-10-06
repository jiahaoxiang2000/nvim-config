return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- hide hidden files by default
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
  },
}

