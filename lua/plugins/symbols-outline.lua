return {
  "simrat39/symbols-outline.nvim",
  keys = { { "<leader>2", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
  cmd = "SymbolsOutline",
  event = "VeryLazy",
  opts = function()
    local Config = require("lazyvim.config")
    local defaults = require("symbols-outline.config").defaults
    local opts = {
      symbols = {},
      symbol_blacklist = {},
    }

    for kind, symbol in pairs(defaults.symbols) do
      opts.symbols[kind] = {
        icon = Config.icons.kinds[kind] or symbol.icon,
        hl = symbol.hl,
      }
      if not vim.tbl_contains(Config.kind_filter.default, kind) then
        table.insert(opts.symbol_blacklist, kind)
      end
    end
    return opts
  end,
}
