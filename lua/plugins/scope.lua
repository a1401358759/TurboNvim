return {
  "tiagovla/scope.nvim",
  event = { "UIEnter" },
  config = function()
    require("scope").setup({})
  end,
}
