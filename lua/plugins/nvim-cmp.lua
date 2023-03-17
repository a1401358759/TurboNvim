return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/vim-vsnip",
    "hrsh7th/cmp-vsnip",
    "friendly-snippets",
    "tzachar/cmp-tabnine",
  },
  opts = function()
    local cmp = require("cmp")
    -- cmp.setup.cmdline("/", {
    --   sources = {
    --     { name = "buffer" },
    --   },
    -- })
    --
    -- cmp.setup.cmdline("?", {
    --   sources = {
    --     { name = "buffer" },
    --   },
    -- })
    --
    -- cmp.setup.cmdline(":", {
    --   sources = cmp.config.sources({
    --     { name = "path" },
    --     { name = "cmdline" },
    --   }),
    -- })
    return {
      -- Insert or Replace
      confirmation = {
        default_behavior = cmp.ConfirmBehavior.Insert,
      },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ---@diagnostic disable-next-line: missing-parameter
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      -- define sorting rules
      sorting = {
        priority_weight = 2,
        comparators = {
          require("cmp_tabnine.compare"),
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "vsnip" },
        { name = "nvim_lsp" },
        { name = "cmp_tabnine" },
        { name = "vim-dadbod-completion" },
        { name = "nvim_lsp_signature_help" },
      }),
      formatting = {
        format = function(entry, item)
          local icons = require("lazyvim.config").icons.kinds
          local source = entry.source.name
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
            item.menu = string.format("  [%s]", string.upper(source))
          end
          return item
        end,
      },
      experimental = {
        ghost_text = {
          hl_group = "LspCodeLens",
        },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    }
  end,
}
