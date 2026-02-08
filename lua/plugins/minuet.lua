-- Minuet AI completion plugin configuration with DeepSeek
local deepseek_api_key = vim.env.DEEPSEEK_API_KEY

if not deepseek_api_key or deepseek_api_key == "" then
  return {}
end

return {
  {
    "milanglacier/minuet-ai.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("minuet").setup({

        -- Use DeepSeek with FIM (Fill-in-the-Middle) completion
        provider = "openai_fim_compatible",

        -- Context and timing settings
        context_window = 16000,
        throttle = 1500,
        debounce = 600,
        request_timeout = 3,

        -- Completion settings
        n_completions = 1,
        add_single_line_entry = true,
        -- blink = {
        -- 	enable_auto_complete = true,
        -- },

        -- Notification level
        notify = "warn",

        -- Provider-specific options for DeepSeek
        provider_options = {
          openai_fim_compatible = {
            api_key = deepseek_api_key,
            model = "deepseek-chat",
            end_point = "https://api.deepseek.com/beta/completions",
            name = "Deepseek",
            stream = true,
            optional = {
              max_tokens = 512,
              top_p = 0.9,
              stop = { "\n\n" },
            },
          },
        },

        -- Virtual text configuration (manual trigger by default)
        virtualtext = {
          auto_trigger_ft = { "markdown", "python", "rust", "typst", "latex" }, -- Empty = manual trigger only
          keymap = {
            accept = "<A-A>",                                              -- Disabled, will set up custom Tab binding below
            accept_line = "<A-a>",                                         -- Accept one line
            accept_n_lines = "<A-z>",                                      -- Accept n lines
            next = "<A-]>",                                                -- Next completion
            prev = "<A-[>",                                                -- Previous completion
            dismiss = "<A-e>",                                             -- Dismiss completion
          },
        },
      })

      -- Custom Tab mapping: accept completion if visible, otherwise insert tab
      vim.keymap.set("i", "<Tab>", function()
        local virtualtext = require("minuet.virtualtext")
        if virtualtext.action.is_visible() then
          virtualtext.action.accept()
        else
          return "<Tab>"
        end
      end, { expr = true, desc = "Accept minuet completion or insert tab" })
    end,
  },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      -- Extend existing keymap
      opts.keymap = opts.keymap or {}
      opts.keymap["<A-y>"] = {
        function(cmp)
          cmp.show({ providers = { "minuet" } })
        end,
      }
      -- Disable Tab in blink.cmp to avoid conflict with minuet Tab mapping
      opts.keymap["<Tab>"] = {}
      opts.keymap["<S-Tab>"] = {}

      -- Extend sources
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or {}

      -- Add minuet to default sources if not already present
      local has_minuet = false
      for _, source in ipairs(opts.sources.default) do
        if source == "minuet" then
          has_minuet = true
          break
        end
      end
      if not has_minuet then
        table.insert(opts.sources.default, "minuet")
      end

      -- Configure minuet provider
      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.minuet = {
        name = "minuet",
        module = "minuet.blink",
        async = true,
        -- Should match minuet.config.request_timeout * 1000
        timeout_ms = 3000,
        score_offset = 50, -- Gives minuet higher priority
      }

      -- Configure completion trigger
      opts.completion = opts.completion or {}
      opts.completion.trigger = opts.completion.trigger or {}
      opts.completion.trigger.prefetch_on_insert = false

      return opts
    end,
  },
}
