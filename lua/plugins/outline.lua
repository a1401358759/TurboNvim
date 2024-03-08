return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = { { "<leader>2", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
  opts = function()
    local icons = require("config.icons").icons
    local defaults = require("outline.config").defaults
    local opts = {
      symbols = {},
      symbol_blacklist = {},
    }
    local filter = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      "Package",
      "Property",
      "Struct",
      "Trait",
    }
    if type(filter) == "table" then
      filter = filter.default
      if type(filter) == "table" then
        for kind, symbol in pairs(defaults.symbols) do
          opts.symbols[kind] = {
            icon = icons.lspkind[kind] or symbol.icon,
            hl = symbol.hl,
          }
          if not vim.tbl_contains(filter, kind) then
            table.insert(opts.symbol_blacklist, kind)
          end
        end
      end
    end
    return opts
  end,
}
