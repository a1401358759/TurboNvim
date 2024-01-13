return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
    icons = {
      group = "",
    },
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
    defaults = {
      ["gp"] = { name = " Preview" },
      ["gy"] = { name = " Yank" },
      ["<leader><tab>"] = { name = "󰓩 Tabs" },
      ["<leader>b"] = { name = "󰖯 Buffer" },
      ["<leader>c"] = { name = " Code" },
      ["<leader>d"] = { name = " Debug/Duck" },
      ["<leader>f"] = { name = " File/Find" },
      ["<leader>g"] = { name = " Git" },
      ["<leader>m"] = { name = " Markdown" },
      ["<leader>q"] = { name = "󰗼 Quit/Session" },
      ["<leader>r"] = { name = " Fun" },
      ["<leader>s"] = { name = " Search" },
      ["<leader>t"] = { name = " Translate/Terminal" },
      ["<leader>u"] = { name = " UI" },
      ["<leader>w"] = { name = "󱂬 Windows" },
      ["<leader>x"] = { name = "󰁨 Diagnostics/Quickfix" },
    },
  },
}
