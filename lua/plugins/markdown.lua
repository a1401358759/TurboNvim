return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  cmd = { "Markview", "Markview splitToggle" },
  ft = { "markdown" },
  keys = {
    {
      "<leader>mp",
      ft = "markdown",
      "<cmd>Markview splitToggle<cr>",
      desc = "Markdown Preview",
    },
  },
}
