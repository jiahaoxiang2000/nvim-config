return {
  "dhananjaylatkar/cscope_maps.nvim",
  opts = {
    disable_maps = true,
    skip_input_prompt = true,
    prefix = "<C-c>",
    cscope = {
      exec = "gtags-cscope",
    },
  },
  specs = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<C-c>,"] = { "<cmd>CsStackView open down<cr>", desc = "CsStackView call_in" },
          ["<C-c>."] = { "<cmd>CsStackView open up<cr>", desc = "CsStackView call_out" },
          ["<C-c>/"] = { "<cmd>CsStackView toggle<cr>", desc = "CsStackView last_view" },
          ["<C-c>r"] = { "<cmd>Cscope reload<cr>", desc = "cscope reload" },
          ["<C-c>a"] = { "<cmd>Cscope find a<cr>", desc = "cscope find_this [a] assignments" },
          ["<C-c>c"] = { "<cmd>Cscope find c<cr>", desc = "cscope find_this [c] call_in" },
          ["<C-c>d"] = { "<cmd>Cscope find d<cr>", desc = "cscope find_this [d] call_out" },
          ["<C-c>e"] = { ":Cscope find e ", desc = "cscope find [e] egrep_pattern" },
          ["<C-c>p"] = { ":Cscope find f ", desc = "cscope find [f] file" },
          ["<C-c>o"] = { ":Cscope find g ", desc = "cscope find [g] global definition" },
          ["<C-c>g"] = { "<cmd>Cscope find g<cr>", desc = "cscope find_this [g] global definition" },
          ["<C-c>i"] = { "<cmd>Cscope find i<cr>", desc = "cscope find_this [i] #including" },
          ["<C-c>s"] = { "<cmd>Cscope find s<cr>", desc = "cscope find_this [s] C symbol" },
          ["<C-c>x"] = {
            function()
              vim.cmd "Hi+"
              vim.cmd "Cscope reload"
              vim.cmd "Cscope find s"
              vim.cmd "norm q"
              require("xtools").goto_nearest_qf_item()
            end,
            desc = "cscope find_this [s] C symbol (Build qflist)",
          },
          ["<C-c>y"] = { ":Cscope find s ", desc = "cscope find [s] C symbol" },
          ["<C-c>t"] = { "<cmd>Cscope find t<cr>", desc = "cscope find_this [t] text_string" },
          ["<C-c>b"] = { "<cmd>Cscope db buid<cr>", desc = "Buid database" },
          ["<C-c>B"] = {
            function()
              vim.fn.system "fd -e c -e c++ -e cc -e cpp -e cxx -e h -e h++ -e hh -e hpp -e hxx -e inl -e ipp -e tcc -e java > cscope.files"
              vim.cmd "Cscope db buid"
            end,
            desc = "Force buid database",
          },
        },
      },
    },
  },
}
