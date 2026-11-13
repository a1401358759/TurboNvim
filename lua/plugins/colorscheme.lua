-- 配色。只加载当前主题，其余在 :colorscheme 时加载。

return {
  {
    name = "tokyonight",
    "https://github.com/folke/tokyonight.nvim",
    colorscheme = { "tokyonight", "tokyonight-moon", "tokyonight-night", "tokyonight-day", "tokyonight-storm" },
    config = function()
      local options = require("config.options")
      require("tokyonight").setup({
        transparent = options.transparent,
        style = "moon",
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
        on_colors = function(colors)
          -- Because lualine broke stuff with the latest commit
          colors.bg_statusline = colors.none
        end,
        on_highlights = function(hl, colors)
          -- TabLineFill is currently set to black
          hl.TabLineFill = {
            bg = colors.none,
          }
        end,
      })
    end,
  },

  {
    name = "gruvbox",
    "https://github.com/ellisonleao/gruvbox.nvim",
    colorscheme = "gruvbox",
    config = function()
      local options = require("config.options")
      require("gruvbox").setup({
        transparent_mode = options.transparent,
        terminal_colors = true,
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
    end,
  },

  {
    name = "gruvbox-baby",
    "https://github.com/luisiacc/gruvbox-baby",
    colorscheme = "gruvbox-baby",
    config = function()
      local options = require("config.options")
      local config = require("gruvbox-baby.config")
      local colors = require("gruvbox-baby.colors").config(config)
      vim.g.gruvbox_baby_use_original_palette = false
      vim.g.gruvbox_baby_function_style = "NONE"
      vim.g.gruvbox_baby_background_color = "medium"
      vim.g.gruvbox_baby_transparent_mode = options.transparent
      vim.g.gruvbox_baby_highlights = {
        MatchParen = { bg = "#665c54", style = colors.none },
        Search = { bg = colors.bright_yellow, fg = "#ffffff" },
        IncSearch = { bg = colors.orange, fg = "#ffffff" },
        CurSearch = { link = "IncSearch" },
        Visual = { bg = "#665c54" },
        FloatBorder = { bg = colors.none },
      }
    end,
  },

  {
    name = "onedarkpro",
    "https://github.com/olimorris/onedarkpro.nvim",
    colorscheme = { "onedark", "onedark_dark", "onedark_vivid", "onelight", "vaporwave" },
    config = function()
      local options = require("config.options")
      require("onedarkpro").setup({
        cursorline = options.show_cursorline,
        transparency = options.transparent,
        terminal_colors = true,
        lualine_transparency = true,
        highlight_inactive_windows = false,
      })
    end,
  },

  {
    name = "monokai",
    "https://github.com/polirritmico/monokai-nightasty.nvim",
    colorscheme = "monokai-nightasty",
    config = function()
      require("monokai-nightasty").setup({
        dark_style_background = "transparent",
        hl_styles = {
          keywords = { italic = true },
          comments = { italic = true },
          floats = "transparent",
          sidebars = "transparent",
        },
        color_headers = true,
        dim_inactive = true,
        hide_inactive_statusline = true,
      })
    end,
  },
}
