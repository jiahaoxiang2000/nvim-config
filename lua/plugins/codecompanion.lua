return {
  "olimorris/codecompanion.nvim",
  event = "User AstroFile",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "ravitemer/mcphub.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      lazy = true,
      opts = function(_, opts)
        opts.file_types = require("astrocore").list_insert_unique(opts.file_types, { "codecompanion" })
      end,
    },
    { "echasnovski/mini.diff", opts = {} },
    -- {
    --   "Davidyz/VectorCode",
    --   version = "*", -- optional, depending on whether you're on nightly or release
    --   -- build = "pipx upgrade vectorcode", -- optional but recommended. This keeps your CLI up-to-date.
    --   dependencies = { "nvim-lua/plenary.nvim" },
    -- },
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        local maps = opts.mappings
        if maps then
          maps.n["<leader>a"] = { desc = "󰚩 " .. "AI" }

          maps.n["<leader>ap"] = { "<cmd>CodeCompanionActions<cr>", desc = "code actions plane" }
          maps.v["<leader>ap"] = { "<cmd>CodeCompanionActions<cr>", desc = "code actions plane" }

          maps.n["<leader>aa"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle code companion" }
          maps.v["<leader>aa"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle code companion" }

          maps.n["<leader>ac"] = { "<cmd>CodeCompanion /commit<cr>", desc = "generate commit message" }

          maps.v["ga"] = { "<cmd>CodeCompanionChat Add<cr>", desc = "add selected content as chat context" }

          vim.cmd [[cab cc CodeCompanion]]
        end
      end,
    },
  },
  opts = function()
    local default_adapter = {
      name = "copilot",
      model = "claude-sonnet-4",
    }
    return {
      adapters = {
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://openrouter.ai/api",
              api_key = "OPENROUTER_API_KEY",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "deepseek/deepseek-chat-v3-0324",
                choices = {
                  "openai/gpt-4.1",
                  "anthropic/claude-3.7-sonnet",
                  "deepseek/deepseek-chat-v3-0324",
                },
              },
            },
          })
        end,
        opts = {
          -- proxy = "http://localhost:1080",
        },
      },
      strategies = {
        chat = {
          adapter = default_adapter,
          tools = {
            opts = {
              auto_submit_success = true,
              auto_submit_errors = true,
            },
          },
          variables = {
            ["buffer"] = {
              opts = {
                default_params = "watch", -- or 'pin'
              },
            },
          },
          keymaps = {
            completion = {
              modes = {
                i = "<C-.>",
              },
              index = 1,
              -- TODO: the completion function not work
              callback = "keymaps.completion",
              description = "Completion Menu",
            },
          },
        },
        inline = {
          adapter = default_adapter,
          keymaps = {
            reject_change = {
              modes = {
                n = "gR",
              },
            },
          },
        },
        cmd = {
          adapter = default_adapter,
        },
      },
      display = {
        chat = {
          render_headers = false,
          show_settings = true, -- Show LLM settings at the top of the chat buffer?
          show_token_count = true, -- Show the token count for each response?
          show_references = true,
          start_in_insert_mode = false,
        },
      },
      opts = {
        log_level = "ERROR",
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
        vectorcode = {
          opts = {
            add_tool = true,
          },
        },
      },
    }
  end,
}
