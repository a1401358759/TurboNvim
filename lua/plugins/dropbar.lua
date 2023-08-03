return {
  "Bekaboo/dropbar.nvim",
  lazy = true,
  event = { "UIEnter" },
  enabled = true,
  config = function()
    require("dropbar").setup({})
  end,
}
