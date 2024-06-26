return {
  "folke/which-key.nvim",
  lazy = true,
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  config = function()
    local wk = require("which-key")
    wk.setup({
      plugins = { spelling = true },
      icons = {
        group = "",
      },
      window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
      },
    })
    wk.register({
      ["gp"] = { name = " Preview" },
      ["gy"] = { name = " Yank" },
      ["<leader><tab>"] = { name = "󰓩 Tabs" },
      ["<leader>b"] = { name = "󰖯 Buffer" },
      ["<leader>c"] = { name = " Code" },
      ["<leader>d"] = { name = " Debug/Duck" },
      ["<leader>f"] = { name = "󰈔 File/Find" },
      ["<leader>g"] = { name = "󰊢 Git" },
      ["<leader>h"] = { name = "󰍎 Harpoon" },
      ["<leader>m"] = { name = "󰍔 Markdown" },
      ["<leader>n"] = { name = " Comments" },
      ["<leader>q"] = { name = "󰗼 Quit/Session" },
      ["<leader>s"] = { name = "󱁴 Search" },
      ["<leader>t"] = { name = " Telescope/Terminal" },
      ["<leader>u"] = { name = " UI" },
      ["<leader>w"] = { name = "󱂬 Windows" },
      ["<leader>x"] = { name = "󰁨 Diagnostics/Quickfix" },
    })
  end,
}
