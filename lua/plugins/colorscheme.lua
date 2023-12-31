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
    "marko-cerovac/material.nvim",
    config = function()
      require("material").setup({
        disable = {
          colored_cursor = true, -- Disable the colored cursor
          borders = true, -- Disable borders between verticaly split windows
          background = options.transparent, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
          term_colors = true, -- Prevent the theme from setting terminal colors
          eob_lines = true, -- Hide the end-of-buffer lines
        },
        high_visibility = {
          lighter = false, -- Enable higher contrast text for lighter style
          darker = false, -- Enable higher contrast text for darker style
        },
        lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )
        async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)
      })
      vim.g.material_style = "darker"
    end,
  },
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
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        dim_inactive = false,
      })
    end,
  },
  {
    "olimorris/onedarkpro.nvim",
    config = function()
      require("onedarkpro").setup({
        options = {
          cursorline = options.show_cursorline, -- Use cursorline highlighting?
          transparency = options.transparent, -- Use a transparent background?
          terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
          highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
        },
      })
    end,
  },
  {
    "gbprod/nord.nvim",
    config = function()
      require("nord").setup({
        transparent = options.transparent, -- Enable this to disable setting the background color
        styles = {
          comments = { italic = true },
          keywords = {},
          functions = {},
          variables = {},
        },
        colorblind = {
          enable = false,
          preserve_background = false,
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
