return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local icons = require("config.icons").icons

    local function diff_source()
      ---@diagnostic disable-next-line: undefined-field
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end

    local colors = {
      darkgray = "#16161d",
      gray = "#928374",
      innerbg = nil,
      -- outerbg = "#16161D",
      outerbg = nil,
      -- normal = "#7e9cd8", -- for tokyonight
      normal = "#a89984", -- gor gruvbox
      insert = "#98bb6c",
      visual = "#ffa066",
      replace = "#e46876",
      command = "#e6c384",
    }

    local my_lualine_theme = {
      normal = {
        a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
      inactive = {
        a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
      visual = {
        a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
      replace = {
        a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
      insert = {
        a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
      command = {
        a = { fg = colors.darkgray, bg = colors.command, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
    }

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = my_lualine_theme,
        component_separators = "|",
        section_separators = { left = icons.ui.PowerlineArrowRight, right = icons.ui.PowerlineArrowLeft },
        disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return icons.ui.NeoVim .. str
            end,
          },
        },
        lualine_b = {},
        lualine_c = {
          {
            "branch",
            icon = string.gsub(icons.ui.Branch, "%s+", ""),
          },
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          {
            "diff",
            colored = true, -- Displays a colored diff status if set to true
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = diff_source,
          },
          { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
        },
        lualine_x = {
          { "encoding" },
          { "fileformat" },
          { "filetype" },
          { "progress" },
        },
        lualine_y = {},
      },
      extensions = {
        "nvim-tree",
        "aerial",
        "toggleterm",
        "nvim-dap-ui",
        "lazy",
        "man",
        "mason",
        "overseer",
        "quickfix",
        "trouble",
        "neo-tree",
        "symbols-outline",
      },
    })
  end,
}
