return {
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "saghen/blink.compat", -- Compatibility layer for using nvim-cmp sources on blink.cmp
        optional = true, -- make optional so it's only enabled if any extras need it
        opts = {},
        version = not vim.g.lazyvim_blink_main and "*",
      },
    },

    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        preset = "none",
        -- 2025-01-23 22:15  the fallback is to forward to the vim basic key fucntions
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<cr>"] = { "select_and_accept", "fallback" },

        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },

        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = false,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      snippets = {
        expand = function(snippet)
          -- for use the lazyvim cmp s
          return LazyVim.cmp.expand(snippet)
        end,
      },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        compat = {},
        default = { "lsp", "path", "snippets", "buffer" },
        cmdline = {},
      },
    },
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
  },
}
