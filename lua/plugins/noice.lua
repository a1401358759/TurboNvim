return {
  "folke/noice.nvim",
  lazy = true,
  event = "VeryLazy",
  opts = {
    cmdline = {
      enabled = false, -- enables the Noice cmdline UI
    },
    views = { ---@see section on views
      ["mini"] = {
        reverse = false,
        align = "message-left",
        timeout = 3000,
        position = { row = -2, col = -2 },
        size = {
          max_height = math.ceil(0.8 * vim.o.lines),
          max_width = math.ceil(0.8 * vim.o.columns),
          width = "auto",
          height = "auto",
        },
        win_options = { winblend = 0 },
      },

      ["cmdline"] = {
        backend = "mini",
        relative = "editor",
        align = "message-left",
        timeout = 100,
        reverse = true,
        position = { row = -2, col = 0 },
        size = "auto",
        zindex = 60,

        border = {
          style = {
            { "╭", "" },
            { "─", "" },
            { "╮", "" },
            { "│", "" },
            { "╯", "" },
            { "─", "" },
            { "╰", "" },
            { "│", "" },
          },
          padding = { left = 1, right = 1 },
        },
        win_options = {
          winblend = 0,
          winhighlight = { Normal = "", IncSearch = "", Search = "" },
        },
      },
    },
  },
}
