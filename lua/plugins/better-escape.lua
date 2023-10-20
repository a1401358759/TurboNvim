return {
  "max397574/better-escape.nvim",
  event = { "UIEnter" },
  config = function()
    require("better_escape").setup({
      mapping = { "jk", "jj" },
      clear_empty_lines = true,
    })
  end,
}
