---@diagnostic disable: missing-fields
return {
  "saghen/blink.cmp",
  -- version = vim.g.blink_main and "v0.*",
  event = { "InsertEnter", "CmdlineEnter" },
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
  },
  dependencies = {
    "rafamadriz/friendly-snippets",
    "niuiic/blink-cmp-rg.nvim",
    -- add blink.compat to dependencies
    {
      "saghen/blink.compat",
      optional = true, -- make optional so it's only enabled if any extras need it
      opts = {},
    },
  },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        border = "rounded",
        winblend = 0,
        scrollbar = true,
        draw = {
          treesitter = true,
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
    -- Experimental signature help support
    signature = {
      enabled = true,
      window = {
        border = "rounded",
        winblend = 0,
        scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
      },
    },
    sources = {
      -- adding any nvim-cmp sources here will enable them
      -- with blink.compat
      compat = {},
      completion = {
        -- remember to enable your providers here
        enabled_providers = { "lsp", "path", "snippets", "buffer", "ripgrep" },
      },
      providers = {
        -- other sources
        ripgrep = {
          module = "blink-cmp-rg",
          name = "Ripgrep",
          -- options below are optional, these are the default values
          opts = {
            -- `min_keyword_length` only determines whether to show completion items in the menu,
            -- not whether to trigger a search. And we only has one chance to search.
            prefix_min_len = 3,
            get_command = function(_, prefix)
              return {
                "rg",
                "--no-config",
                "--json",
                "--word-regexp",
                "--ignore-case",
                "--",
                prefix .. "[\\w_-]+",
                vim.fs.root(0, ".git") or vim.fn.getcwd(),
              }
            end,
            get_prefix = function(context)
              return context.line:sub(1, context.cursor[2]):match("[%w_-]+$") or ""
            end,
          },
        },
        -- fittencode = {
        --   name = "fittencode",
        --   module = "fittencode.sources.blink",
        -- },
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
      -- kind_icons = {},
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
  },
  ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
  config = function(_, opts)
    -- setup compat sources
    local enabled = opts.sources.completion.enabled_providers
    for _, source in ipairs(opts.sources.compat or {}) do
      opts.sources.providers[source] = vim.tbl_deep_extend(
        "force",
        { name = source, module = "blink.compat.source" },
        opts.sources.providers[source] or {}
      )
      if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
        table.insert(enabled, source)
      end
    end
    require("blink.cmp").setup(opts)
  end,
}
