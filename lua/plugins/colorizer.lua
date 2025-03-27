return {
  "brenoprata10/nvim-highlight-colors",
  lazy = true,
  event = { "BufReadPost", "BufWritePre", "BufNewFile" },
  config = function()
    require("nvim-highlight-colors").setup({
      render = "background",
      enable_tailwind = true,
    })
  end,
}
