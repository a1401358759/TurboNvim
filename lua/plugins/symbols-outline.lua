return {
  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>2", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {
      -- add your options that should be passed to the setup() function here
      position = "right",
      auto_preview = true,
      auto_close = true,
      show_numbers = false,
      show_relative_numbers = false,
      show_symbol_details = false,
    },
  },
}
