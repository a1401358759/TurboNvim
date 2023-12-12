---@diagnostic disable: missing-fields
return {
  "lewis6991/satellite.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("satellite").setup({
      current_only = true,
      winblend = 50,
      zindex = 40,
      excluded_filetypes = { "neo-tree", "nvim-tree", "alpha", "dashboard" },
      width = 2,
      handlers = {
        cursor = {
          enable = false,
          symbols = { "⎺", "⎻", "⎼", "⎽" },
        },
        search = {
          enable = true,
        },
        diagnostic = {
          enable = true,
          signs = { "-", "=", "≡" },
          min_severity = vim.diagnostic.severity.HINT,
        },
        gitsigns = {
          enable = false,
        },
        marks = {
          enable = true,
          show_builtins = false, -- shows the builtin marks like [ ] < >
          key = "m",
        },
        quickfix = {
          signs = { "-", "=", "≡" },
        },
      },
    })
  end,
}
