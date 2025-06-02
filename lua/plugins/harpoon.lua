return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<S-M-m>",
        function() require("harpoon"):list():add() end,
        desc = "harpoon file add",
      },
      {
        "<M-m>",
        function()
          local harpoon = require "harpoon"
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "harpoon quick menu",
      },
      { "<M-[>", function() require("harpoon"):list():prev() end, desc = "Goto previous mark" },
      { "<M-]>", function() require("harpoon"):list():next() end, desc = "Goto next mark" },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4" },
      { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5" },
    },
  },
}
