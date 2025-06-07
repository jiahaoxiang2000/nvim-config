-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local xtools = require "xtools"

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    sessions = {
      autosave = { last = false, cwd = false },
    },
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = true, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = true, -- sets vim.opt.wrap
        wrapscan = false, -- sets vim.opt.wrapscan
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- Normal mode
      n = {
        ["<Leader>q"] = false,
        ["<M-q>"] = { "<cmd>close<cr>", desc = "Close window" },
        ["<Leader><tab>"] = { "<C-w>w", desc = "Switch window" },

        ["<M-s>"] = {
          function()
            local count = vim.v.count1
            for _ = 1, count do
              vim.fn.search("\\k\\+[*/+-?>!&]*\\_s*[<>({\\[]", "W")
            end
            vim.cmd "normal! m'"
          end,
          desc = "Go to next scope symbol",
        },

        ["<M-S>"] = {
          function()
            local count = vim.v.count1
            for _ = 1, count do
              vim.fn.search("\\k\\+[*/+-?>!&]*\\_s*[<>({\\[]", "bW")
            end
            vim.cmd "normal! m'"
          end,
          desc = "Go to previous scope symbol",
        },

        ["<M-e>"] = { "<cmd>normal z%<cr>", desc = "Next matchup inside" },
        ["<M-u>"] = { "<cmd>normal [%<cr>", desc = "Goto matchup outside" },
        ["<M-a>"] = { "<cmd>normal %<cr>", desc = "Next matchup" },

        ["<M-d>"] = { "<cmd>normal gd<cr>", desc = "goto definition" },
        ["<M-r>"] = { "<cmd>normal grr<cr>", desc = "goto references" },
        ["<M-y>"] = { "<cmd>normal gy<cr>", desc = "goto type definition" },
        ["<M-i>"] = { "<cmd>normal gri<cr>", desc = "goto implementation" },

        ["<M-1>"] = { "<cmd>tabn 1<cr>", desc = "goto tabn 1" },
        ["<M-2>"] = { "<cmd>tabn 2<cr>", desc = "goto tabn 2" },
        ["<M-3>"] = { "<cmd>tabn 3<cr>", desc = "goto tabn 3" },
        ["<M-4>"] = { "<cmd>tabn 4<cr>", desc = "goto tabn 4" },
        ["<Leader>tx"] = { "<cmd>tabclose<cr>", desc = "tabclose" },
        ["<Leader>tX"] = { "<cmd>tabonly<cr>", desc = "tabonly" },

        -- navigate buffer and tabs
        ["<S-M-i>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["<S-M-u>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings under group name "Find"
        ["<Leader>fl"] = { function() require("telescope.builtin").filetypes() end, desc = "Select Language" },

        -- mappings under group name "Buffer"
        ["<Leader>bv"] = { "<cmd>e!<cr>", desc = "Revert Buffer" },
        ["<Leader>bx"] = {
          function()
            require("astrocore.buffer").close_all(true)
            vim.cmd "only"
          end,
          desc = "Close all buffers/windows except current",
        },

        -- mappings under group name "Local"
        ["<Leader>,"] = { name = "Local" },
        ["<Leader>,a"] = { "<cmd>normal! ggVG<cr>", desc = "Select entire buffer" },
        ["<Leader>,dd"] = { "<cmd>diffthis<cr>", desc = "diffthis" },
        ["<Leader>,dc"] = { "<cmd>diffoff!<cr>", desc = "diffoff" },
        ["<Leader>,dg"] = { "<cmd>diffget<cr>", desc = "diffget" },
        ["<Leader>,dp"] = { "<cmd>diffput<cr>", desc = "diffput" },
        ["<Leader>,z"] = {
          "<cmd>%lua<cr>",
          desc = "lua exec",
        },

        ["<Leader>,e"] = {
          function()
            vim.cmd "cd %:h"
            vim.cmd "Neotree focus"
            vim.cmd "pwd"
          end,
          desc = "Sync Neotree With Current Buffer",
        },
        ["<Leader>,s"] = {
          function()
            xtools.new_term_cmd_vertical {
              cmd = vim.o.shell,
              display_name = "shell",
            }
          end,
          desc = "ToggleTerm shell",
        },
        ["<Leader>,1"] = {
          '<cmd>let @+ = expand("%:p:h")<cr><cmd>echo expand("%:p:h")<cr>',
          desc = "Yank directory path",
        },
        ["<Leader>,2"] = { '<cmd>let @+ = expand("%:t")<cr><cmd>echo expand("%:t")<cr>', desc = "Yank filename" },
        ["<Leader>,3"] = { '<cmd>let @+ = expand("%:p")<cr><cmd>echo expand("%:p")<cr>', desc = "Yank full path" },
        ["<Leader>,c"] = {
          function()
            local work_dir = xtools.cwd()
            xtools.set_clip(work_dir)
            print(work_dir)
          end,
          desc = "Yank CWD",
        },
        ["<Leader>,,"] = {
          function()
            xtools.adjust_path_from_clip()
            local path = xtools.get_clip()
            if xtools.isdir(path) then
              xtools.cd(path)
              print(xtools.cwd())
            elseif xtools.isfile(path) then
              vim.cmd("e " .. path)
            else
              print "Invalid Path !!!"
            end
          end,
          desc = "Set cwd or Open file with clipboard",
        },

        -- mappings under group name "Local/Hex"
        ["<Leader>,hh"] = { "<cmd>%!xxd -g 1<cr>", desc = "Switch to hex view" },
        ["<Leader>,hr"] = { "<cmd>%!xxd -r<cr>", desc = "Switch to binary view" },
        ["<Leader>,ho"] = { ":e ++binary ", desc = "Open binary file" },
        ["<Leader>,h"] = { name = "Hex" },
      },

      -- Visual mode
      v = {
        ["<M-a>"] = { "<cmd>normal %<cr>", desc = "Next matchup" },

        ["<Leader>,"] = { name = "Local" },
        ["<Leader>,z"] = {
          "<Esc><cmd>'<,'>%lua<cr>",
          desc = "lua exec",
        },

        ["<C-S-Left>"] = { "b", desc = "" },
        ["<C-S-Right>"] = { "e", desc = "" },
        ["<S-Up>"] = { "k", desc = "" },
        ["<S-Down>"] = { "j", desc = "" },
        ["<S-Left>"] = { "h", desc = "" },
        ["<S-Right>"] = { "l", desc = "" },
        ["<S-PageUp>"] = { "<C-u>", desc = "" },
        ["<S-PageDown>"] = { "<C-d>", desc = "" },
      },

      -- Command mode
      c = { ["<C-v>"] = { "<C-r>*", desc = "Paste in Command mode" } },

      -- Terminal mode
      t = {
        ["<C-l>"] = false,
        ["<M-q>"] = {
          "<cmd>close<cr>",
          desc = "Close buffer",
        },
      },

      -- Insert mode
      i = {
        ["<C-s>"] = { "<Esc>:w<cr>", desc = "Save" },
        ["<C-v>"] = { "<cmd>normal P<cr><Right>", desc = "Paste from clipboard" },
        ["<C-h>"] = { "<C-w>", desc = "Delete word" },

        ["<C-S-Left>"] = { '_<Esc>mz"_xv`z<BS>ob<Space>', desc = "" },
        ["<C-S-Right>"] = { '_<Esc>my"_xi<S-Right><C-o><BS>_<Esc>mz"_xv`yo`z', desc = "" },
        ["<S-End>"] = { "<cmd>normal v<End><cr><Esc>", desc = "" },
        ["<S-Home>"] = { "<cmd>normal hv<Home><cr><Esc>", desc = "" },
        ["<S-Up>"] = { "<cmd>normal vkloho<cr><Esc>", desc = "" },
        ["<S-Down>"] = { "<cmd>normal vj<cr><Esc>", desc = "" },
        ["<S-Left>"] = { "<Esc>v", desc = "" },
        ["<S-Right>"] = { "<Esc>vlolo", desc = "" },
        ["<S-PageUp>"] = { "<Esc>v<C-u>", desc = "" },
        ["<S-PageDown>"] = { "<Esc>v<C-d>", desc = "" },
      },
    },
  },
}
