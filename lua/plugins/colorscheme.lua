local options = require("config.options")

return {
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        transparent_mode = options.transparent,
        terminal_colors = true, -- add neovim terminal colors
        undercurl = false,
        underline = false,
        bold = false,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
      })
      -- vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    "luisiacc/gruvbox-baby",
    lazy = false,
    opts = {
      transparent_mode = options.transparent_mode,
      function_style = "NONE",
    },
    config = function()
      vim.g.gruvbox_baby_function_style = "NONE"
      vim.cmd([[colorscheme gruvbox-baby]])
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = options.transparent,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      -- vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
