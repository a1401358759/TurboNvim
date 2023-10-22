return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    local keymaps = {
      mode = { "n", "v" },
      ["g"] = { name = "+Goto" },
      ["]"] = { name = "+Next" },
      ["["] = { name = "+Prev" },
      ["gp"] = { name = "+Preview" },
      ["gy"] = { name = "+Yank" },
      ["<leader><tab>"] = { name = "+Tabs" },
      ["<leader>a"] = { name = "+AI" },
      ["<leader>b"] = { name = "+Buffer" },
      ["<leader>c"] = { name = "+Code" },
      ["<leader>d"] = { name = "+Debug/Duck" },
      ["<leader>f"] = { name = "+File/Find" },
      ["<leader>g"] = { name = "+Git" },
      ["<leader>i"] = { name = "+Icon" },
      ["<leader>m"] = { name = "+Markdown" },
      ["<leader>q"] = { name = "+Quit/Session" },
      ["<leader>r"] = { name = "+Fun" },
      ["<leader>s"] = { name = "+Search" },
      ["<leader>t"] = { name = "+Translate/Terminal" },
      ["<leader>u"] = { name = "+UI" },
      ["<leader>w"] = { name = "+Windows" },
      ["<leader>x"] = { name = "+Diagnostics/Quickfix" },
    }
    wk.register(keymaps)
  end,
}
