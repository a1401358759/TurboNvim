local options = require("config.options")

return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "moon",
      transparent = options.transparent,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "luisiacc/gruvbox-baby",
    config = function()
      if options.transparent then
        vim.g.gruvbox_baby_transparent_mode = 1
      end
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-baby",
    },
  },
}
