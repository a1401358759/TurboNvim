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
    config = function()
      local config = require("gruvbox-baby.config")
      local colors = require("gruvbox-baby.colors")
      local c = colors.config(config)

      vim.g.gruvbox_baby_use_original_palette = false
      vim.g.gruvbox_baby_function_style = "NONE"
      vim.g.gruvbox_baby_background_color = "medium"
      vim.g.gruvbox_baby_transparent_mode = options.transparent
      vim.g.gruvbox_baby_highlights = {
        MatchParen = { bg = "#665c54", style = c.none },
        Search = { bg = c.bright_yellow, fg = "#ffffff" },
        IncSearch = { bg = c.orange, fg = "#ffffff" },
        CurSearch = { link = "IncSearch" },
      }
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
