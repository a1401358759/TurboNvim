local options = require("config.options")

return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
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
    end,
  },
  {
    "luisiacc/gruvbox-baby",
    lazy = true,
    priority = 1000,
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
        Visual = { bg = "#665c54" },
        FloatBorder = { bg = c.none },
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent = options.transparent,
      style = "moon",
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(c)
        -- Because lualine broke stuff with the latest commit
        c.bg_statusline = c.none
      end,
      on_highlights = function(hl, c)
        -- TabLineFill is currently set to black
        hl.TabLineFill = {
          bg = c.none,
        }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
    end,
  },
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    priority = 1000, -- Ensure it loads first
    opts = {
      cursorline = options.show_cursorline, -- Use cursorline highlighting?
      transparency = options.transparent, -- Use a transparent background?
      terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
      lualine_transparency = true, -- Center bar transparency?
      highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
    },
  },
  {
    "polirritmico/monokai-nightasty.nvim",
    priority = 1000,
    opts = {
      dark_style_background = "transparent", -- default, dark, transparent, #color
      markdown_header_marks = "true",
      -- Style to be applied to different syntax groups. See `:help nvim_set_hl`
      hl_styles = {
        keywords = { italic = true },
        comments = { italic = true },
        floats = "transparent",
        sidebars = "transparent",
      },
      color_headers = true,
      dim_inactive = true,
      hide_inactive_statusline = true,
    },
    config = function(_, opts)
      vim.opt.cursorline = options.show_cursorline
      require("monokai-nightasty").load(opts)
    end,
  },
}
