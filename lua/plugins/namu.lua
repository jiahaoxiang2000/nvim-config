return {
  "bassamsdata/namu.nvim",
  cmd = "Namu",
  event = "User AstroFile",
  opts = {
    namu_symbols = {
      options = {
        -- in namu_symbols.options
        movement = {
          next = { "<C-n>", "<C-j>", "<DOWN>" },
          previous = { "<C-p>", "<C-k>", "<UP>" },
          delete_word = { "<C-w>" }, -- delete word mapping
          clear_line = { "<C-u>" }, -- clear line mapping
        },
      },
    },
  },
  specs = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<M-f>"] = { "<cmd>Namu symbols<cr>", desc = "Namu symbols" },
          ["<S-M-f>"] = { "<cmd>Namu ctags<cr>", desc = "Namu ctags" },
          ["<Leader>vx"] = { "<cmd>Namu watchtower<cr>", desc = "Namu watchtower (lsp/treesitter)" },
          ["<Leader>vn"] = { "<cmd>Namu ctags watchtower<cr>", desc = "Namu watchtower (ctags)" },
          ["<Leader>vs"] = { "<cmd>Namu workspace<cr>", desc = "Namu workspace" },
          ["<Leader>vd"] = { "<cmd>Namu diagnostics<cr>", desc = "Namu diagnostics" },
          ["<Leader>vi"] = { "<cmd>Namu call in<cr>", desc = "Namu call in" },
          ["<Leader>vo"] = { "<cmd>Namu call out<cr>", desc = "Namu call out" },
          ["<Leader>vb"] = { "<cmd>Namu call both<cr>", desc = "Namu call both" },
          ["<Leader>vh"] = { "<cmd>Namu help symbols<cr>", desc = "Namu help symbols" },
          ["<Leader>va"] = { "<cmd>Namu help analysis<cr>", desc = "Namu help analysis" },
        },
      },
    },
  },
}
