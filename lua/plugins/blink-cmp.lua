return {
  "saghen/blink.cmp",
  cond = vim.g.blink_main,
  dependencies = {
    "rafamadriz/friendly-snippets",
    "mikavilpas/blink-ripgrep.nvim",
    "bydlw98/blink-cmp-env",
    "archie-judd/blink-cmp-words",
  },
  event = { "InsertEnter", "CmdlineEnter" },

  version = "*",
  opts = {
    snippets = {
      preset = "default",
    },
    cmdline = {
      enabled = true,
      keymap = { preset = "cmdline" },
      completion = {
        list = { selection = { preselect = false } },
        menu = {
          auto_show = function()
            local valid_types = { [":"] = true, ["/"] = true, ["?"] = true }
            return valid_types[vim.fn.getcmdtype()]
          end,
        },
        ghost_text = { enabled = true },
      },
    },
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
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
      kind_icons = { Color = "██" },
    },

    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer", "ripgrep", "dictionary", "thesaurus", "env" },
      providers = {
        ripgrep = {
          module = "blink-ripgrep",
          name = "Ripgrep",
          opts = {
            prefix_min_len = 5,
            backend = {
              ripgrep = {
                ignore_paths = { ".gitignore", ".git/info/exclude", ".ignore", "node_modules" },
              },
            },
          },
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        env = {
          name = "Env",
          module = "blink-cmp-env",
          opts = {
            show_braces = false,
            show_documentation_window = true,
          },
        },
        -- Use the thesaurus source
        thesaurus = {
          name = "blink-cmp-words",
          module = "blink-cmp-words.thesaurus",
          opts = {
            score_offset = 0,
          },
        },
        -- Use the dictionary source
        dictionary = {
          name = "blink-cmp-words",
          module = "blink-cmp-words.dictionary",
          opts = {
            dictionary_search_threshold = 3,
            score_offset = 0,
          },
        },
      },
      per_filetype = {
        text = { "dictionary" },
        markdown = { "thesaurus" },
        lua = { inherit_defaults = true, "lazydev" },
      },
    },
    completion = {
      accept = { auto_brackets = { enabled = false } },
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
      enabled = false,
      window = {
        border = "rounded",
        winblend = 0,
        scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
      },
    },
  },
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
}
