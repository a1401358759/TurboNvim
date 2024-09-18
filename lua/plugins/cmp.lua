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
  hl(0, "CmpItemKindFittenCode", { fg = fgdark, bg = "#58B5A8" })
  hl(0, "CmpItemKindTypeParameter", { fg = fgdark, bg = "#6CC644" })
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
    "lukas-reineke/cmp-rg",
    {
      "garymjr/nvim-snippets",
      opts = {
        friendly_snippets = true,
      },
      dependencies = { "rafamadriz/friendly-snippets" },
    },
  },
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")

    return {
      -- Insert or Replace
      confirmation = {
        default_behavior = cmp.ConfirmBehavior.Insert,
      },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
          if vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          elseif cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "rg", keyword_length = 3, max_item_count = 5 },
        { name = "fittencode" },
        { name = "codeium" },
        { name = "path" },
        { name = "snippets" },
      }, {
        { name = "buffer" },
      }),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          local icons = require("config.icons").icons.lspkind
          local source = entry.source.name
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
    }
  end,
  config = function(_, opts)
    for _, source in ipairs(opts.sources) do
      source.group_index = source.group_index or 1
    end

    local parse = require("cmp.utils.snippet").parse
    ---@diagnostic disable-next-line: duplicate-set-field
    require("cmp.utils.snippet").parse = function(input)
      local ok, ret = pcall(parse, input)
      if ok then
        return ret
      end
      return require("utils.ui").snippet_preview(input)
    end

    local cmp = require("cmp")
    cmp.setup(opts)

    local cmd_mapping = {
      ["<Down>"] = {
        c = function()
          if cmp.visible() then
            cmp.select_next_item()
          else
            cmp.complete()
          end
        end,
      },
      ["<Up>"] = {
        c = function()
          if cmp.visible() then
            cmp.select_prev_item()
          else
            cmp.complete()
          end
        end,
      },
    }
    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(cmd_mapping),
      sources = {
        { name = "buffer" },
      },
      completion = {
        completeopt = "menu,menuone,noselect",
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(cmd_mapping),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
      completion = {
        completeopt = "menu,menuone,noselect",
      },
    })
    setCompHL()
  end,
}
