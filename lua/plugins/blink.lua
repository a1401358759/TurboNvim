return {
  "saghen/blink.cmp",
  cond = vim.g.blink_main,
  dependencies = {
    "rafamadriz/friendly-snippets",
    "mikavilpas/blink-ripgrep.nvim",
  },
  event = { "InsertEnter", "CmdlineEnter" },

  version = "v0.*",
  opts = {
    keymap = {
      preset = "enter",
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      -- ["<Tab>"] = { "select_next", "fallback" },
      -- ["<S-Tab>"] = { "select_prev", "fallback" },

      -- cmdline keymap
      cmdline = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
      kind_icons = { Color = "██" },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer", "ripgrep" },
      cmdline = {},
      providers = {
        ripgrep = {
          module = "blink-ripgrep",
          name = "Ripgrep",
        },
      },
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      menu = {
        border = "rounded",
        winblend = 0,
        scrollbar = true,
        draw = {
          treesitter = { "lsp" },
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
          winblend = 0,
          scrollbar = true,
        },
      },
      ghost_text = {
        enabled = true,
      },
    },
    signature = {
      enabled = true,
      window = {
        border = "rounded",
        winblend = 0,
        scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
      },
    },
  },
  opts_extend = { "sources.default" },
}
