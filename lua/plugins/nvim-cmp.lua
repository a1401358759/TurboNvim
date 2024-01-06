---@diagnostic disable: missing-fields
local setCompHL = function()
  local hl = vim.api.nvim_set_hl
  local fgdark = "#2E3440"
  hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
  hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
  hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
  hl(0, "CmpItemMenu", { fg = "#808080", bg = "NONE", italic = true })
  hl(0, "CmpItemKindField", { fg = fgdark, bg = "#B5585F" })
  hl(0, "CmpItemKindProperty", { fg = fgdark, bg = "#B5585F" })
  hl(0, "CmpItemKindEvent", { fg = fgdark, bg = "#B5585F" })
  hl(0, "CmpItemKindText", { fg = fgdark, bg = "#9FBD73" })
  hl(0, "CmpItemKindEnum", { fg = fgdark, bg = "#9FBD73" })
  hl(0, "CmpItemKindKeyword", { fg = fgdark, bg = "#9FBD73" })
  hl(0, "CmpItemKindConstant", { fg = fgdark, bg = "#D4BB6C" })
  hl(0, "CmpItemKindConstructor", { fg = fgdark, bg = "#D4BB6C" })
  hl(0, "CmpItemKindReference", { fg = fgdark, bg = "#D4BB6C" })
  hl(0, "CmpItemKindFunction", { fg = fgdark, bg = "#A377BF" })
  hl(0, "CmpItemKindStruct", { fg = fgdark, bg = "#A377BF" })
  hl(0, "CmpItemKindClass", { fg = fgdark, bg = "#A377BF" })
  hl(0, "CmpItemKindModule", { fg = fgdark, bg = "#A377BF" })
  hl(0, "CmpItemKindOperator", { fg = fgdark, bg = "#A377BF" })
  hl(0, "CmpItemKindVariable", { fg = fgdark, bg = "#7E8294" })
  hl(0, "CmpItemKindFile", { fg = fgdark, bg = "#7E8294" })
  hl(0, "CmpItemKindUnit", { fg = fgdark, bg = "#D4A959" })
  hl(0, "CmpItemKindSnippet", { fg = fgdark, bg = "#D4A959" })
  hl(0, "CmpItemKindFolder", { fg = fgdark, bg = "#D4A959" })
  hl(0, "CmpItemKindTabNine", { fg = fgdark, bg = "#D4A959" })
  hl(0, "CmpItemKindCodeium", { fg = fgdark, bg = "#D4A959" })
  hl(0, "CmpItemKindMethod", { fg = fgdark, bg = "#6C8ED4" })
  hl(0, "CmpItemKindValue", { fg = fgdark, bg = "#6C8ED4" })
  hl(0, "CmpItemKindEnumMember", { fg = fgdark, bg = "#6C8ED4" })
  hl(0, "CmpItemKindInterface", { fg = fgdark, bg = "#58B5A8" })
  hl(0, "CmpItemKindColor", { fg = fgdark, bg = "#58B5A8" })
  hl(0, "CmpItemKindTypeParameter", { fg = fgdark, bg = "#58B5A8" })
  hl(0, "CmpGhostText", { link = "Comment", default = true })
end

return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/vim-vsnip",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-emoji",
    "saadparwaiz1/cmp_luasnip",
    "friendly-snippets",
    "lukas-reineke/cmp-rg",
    { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
  },
  ---@diagnostic disable-next-line: unused-local
  config = function(_, opts)
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end
    local comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    }
    local sources = {
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "rg", keyword_length = 3 },
      { name = "luasnip" },
      { name = "vsnip" },
      { name = "path" },
      { name = "emoji" },
    }
    local options = require("config.options")
    if options.use_ai_plugins then
      table.insert(comparators, 0, require("cmp_tabnine.compare"))
      table.insert(sources, 3, { name = "codeium" })
      table.insert(sources, 4, { name = "cmp_tabnine" })
    end
    cmp.setup({
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
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<Down>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<Up>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      -- define sorting rules
      sorting = { comparators = comparators },
      sources = cmp.config.sources(sources),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          local icons = require("config.icons").icons.lspkind
          local source = entry.source.name
          if source == "cmp_tabnine" then
            source = "tabnine"
          end
          item.kind = string.format(" %s", icons[item.kind], item.kind)
          item.menu = string.format(" (%s)", string.upper(source))
          return item
        end,
      },
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      window = {
        completion = cmp.config.window.bordered({
          col_offset = -3,
          side_padding = 0,
        }),
        documentation = cmp.config.window.bordered(),
      },
    })

    local cmp_mapping = {
      ["<Tab>"] = {
        c = function(_)
          if cmp.visible() then
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            else
              cmp.select_next_item()
            end
          else
            cmp.complete()
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            end
          end
        end,
      },
      ["<S-Tab>"] = {
        c = function()
          if cmp.visible() then
            cmp.select_prev_item()
          else
            cmp.complete()
          end
        end,
      },
      ["<Down>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
      },
      ["<Up>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },
      ["<C-e>"] = {
        c = cmp.mapping.abort(),
      },
    }

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp_mapping,
      sources = {
        { name = "buffer" },
      },
    })

    setCompHL()
  end,
}
