-- https://github.com/rachartier/tiny-inline-diagnostic.nvim

return {
  "rachartier/tiny-inline-diagnostic.nvim",
  lazy = true,
  event = "TurboLoad",
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "ghost", -- Can be: "modern", "classic", "minimal", "ghost", "simple", "nonerdfont"
      options = {
        show_source = true,
      },
    })
  end,
}
