return {
  "folke/which-key.nvim",
  lazy = true,
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    ---@type false | "classic" | "modern" | "helix"
    preset = "helix",
    icons = {
      group = "",
    },
    defaults = {},
    spec = {
      {
        mode = { "n", "v" },
        { "gp", group = "Preview" },
        { "<leader><tab>", group = "Tabs" },
        { "<leader>a", group = "AI", icon = "󱙺 " },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug", icon = " " },
        { "<leader>e", group = "Explorer", icon = "󰙅 " },
        { "<leader>f", group = "File/Find", icon = " " },
        { "<leader>g", group = "Git", icon = "󰊢 " },
        { "<leader>q", group = "Quit" },
        { "<leader>r", group = "Remote", icon = "󰢹 " },
        { "<leader>s", group = "Search/Session" },
        { "<leader>t", group = "Terminal" },
        { "<leader>u", group = "UI", icon = { icon = "󰙵 ", color = "cyan" } },
        { "<leader>x", group = "Diagnostics/Quickfix", icon = { icon = "󱖫 ", color = "green" } },
        { "[", group = "Prev" },
        { "]", group = "Next" },
        { "g", group = "Goto" },
        { "gs", group = "Surround" },
        { "z", group = "Fold" },
        {
          "<leader>b",
          group = "Buffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        {
          "<leader>w",
          group = "Windows",
          proxy = "<c-w>",
          expand = function()
            return require("which-key.extras").expand.win()
          end,
        },
        -- better descriptions
        { "gx", desc = "Open with system app" },
      },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
  end,
}
