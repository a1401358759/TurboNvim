return {
  "folke/which-key.nvim",
  lazy = true,
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  config = function()
    local wk = require("which-key")
    wk.setup({
      ---@type false | "classic" | "modern" | "helix"
      preset = "modern",
      icons = {
        group = "",
      },
    })
    wk.add({
      { "gp", group = "Preview" },
      { "<leader><tab>", group = "Tabs" },
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debug", icon = " " },
      { "<leader>e", group = "Explorer", icon = "󰙅 " },
      { "<leader>f", group = "File/Find", icon = " " },
      { "<leader>g", group = "Git", icon = "󰊢 " },
      { "<leader>m", group = "Markdown" },
      { "<leader>n", group = "Comments" },
      { "<leader>q", group = "Quit/Session" },
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Telescope/Terminal" },
      { "<leader>u", group = "UI" },
      { "<leader>w", group = "Windows" },
      { "<leader>x", group = "Diagnostics/Quickfix" },
    })
  end,
}
