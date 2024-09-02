-- https://github.com/rachartier/tiny-inline-diagnostic.nvim

return {
  "rachartier/tiny-inline-diagnostic.nvim",
  lazy = true,
  event = "TurboLoad",
  config = function()
    require("tiny-inline-diagnostic").setup({
      options = {
        show_source = true,
      },
    })
  end,
}
