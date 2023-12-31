return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
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

    return {
      options = {
        theme = "auto",
        icons_enabled = true,
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        component_separators = "|",
        section_separators = { left = icons.ui.PowerlineRightRound, right = icons.ui.PowerlineLeftRound },
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
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
        lualine_b = {
          {
            "branch",
            icon = string.gsub(icons.ui.Branch, "%s+", ""),
          },
        },
        lualine_c = {
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
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
        },
        lualine_x = {
          { "searchcount" },
        },
        lualine_y = {
          { "encoding" },
          { "progress", padding = { left = 1, right = 1 } },
          { "location", padding = { left = 1, right = 1 } },
        },
        lualine_z = {
          {
            "datetime",
            style = " " .. "%H:%M", -- '%A, %B %d | %H:%M' '%Y-%m-%d'
          },
        },
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
    }
  end,
}
