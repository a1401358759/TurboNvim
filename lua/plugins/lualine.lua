return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "TurboLoad",
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
      bg = "#202328",
      fg = "#bbc2cf",
      yellow = "#ECBE7B",
      springYellow = "#e0af68",
      cyan = "#008080",
      darkblue = "#081633",
      green = "#98be65",
      orange = "#FF8800",
      violet = "#a9a1e1",
      magenta = "#c678dd",
      blue = "#51afef",
      springBlue = "#7FB4CA",
      red = "#ec5f67",
      pink = "#d27e99",
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config
    local config = {
      options = {
        component_separators = "",
        section_separators = "",
        -- globalstatus = vim.o.laststatus == 3,
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        theme = {
          normal = { c = { fg = colors.fg } },
          inactive = { c = { fg = colors.fg } },
        },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
      extensions = {
        "aerial",
        "toggleterm",
        "nvim-dap-ui",
        "lazy",
        "man",
        "mason",
        "quickfix",
        "trouble",
        "symbols-outline",
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    local mode_color = {
      n = colors.blue,
      i = colors.green,
      v = colors.red,
      [""] = colors.red,
      V = colors.red,
      c = colors.magenta,
      no = colors.blue,
      s = colors.orange,
      S = colors.orange,
      [""] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ["r?"] = colors.cyan,
      ["!"] = colors.red,
      t = colors.red,
    }

    ins_left({
      function()
        return icons.ui.Separator
      end,
      color = { fg = colors.blue },
      padding = { left = 0, right = 2 },
    })
    ins_left({
      function()
        return ""
      end,
      color = function()
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { right = 1 },
    })
    ins_left({
      "mode",
      color = function()
        return { fg = mode_color[vim.fn.mode()], gui = "bold" }
      end,
      padding = { left = 0, right = 1 },
    })
    ins_left({
      "filesize",
      cond = conditions.buffer_not_empty,
      color = { fg = colors.green, gui = "bold" },
    })
    ins_left({
      "branch",
      icon = icons.ui.Branch,
      color = { fg = colors.violet, gui = "bold" },
      on_click = function()
        vim.cmd([[Gitsigns toggle_signs]])
      end,
    })
    -- ins_left({
    --   "diff",
    --   colored = true,
    --   symbols = { added = icons.git.added, modified = icons.git.modified, removed = icons.git.removed },
    --   diff_color = {
    --     added = { fg = colors.green },
    --     modified = { fg = colors.orange },
    --     removed = { fg = colors.red },
    --   },
    --   sources = diff_source,
    --   cond = conditions.hide_in_width,
    -- })
    -- ins_left({
    --   "filetype",
    --   icon_only = true,
    --   padding = { left = 1, right = 0 },
    --   color = { gui = "bold" },
    -- })
    -- ins_left({
    --   "filename",
    --   padding = { left = 0 },
    --   cond = conditions.buffer_not_empty,
    --   color = { gui = "bold" },
    -- })
    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left({
      function()
        return "%="
      end,
    })

    ins_left({
      "lsp_status",
      icon = icons.ui.Gear,
      symbols = { done = "", separator = " " },
      ignore_lsp = {},
      show_name = true,
      color = { fg = colors.orange, gui = "bold" },
    })

    -- Add components to right sections
    -- ins_right({
    --   "diagnostics",
    --   sources = { "nvim_diagnostic" },
    --   symbols = {
    --     error = icons.diagnostics.Error,
    --     warn = icons.diagnostics.Warn,
    --     info = icons.diagnostics.Info,
    --     hint = icons.diagnostics.Hint,
    --   },
    --   diagnostics_color = {
    --     color_error = { fg = colors.red },
    --     color_warn = { fg = colors.yellow },
    --     color_info = { fg = colors.cyan },
    --   },
    -- })
    ins_right({
      function()
        local reg = vim.fn.reg_recording()
        return "󰃽 [" .. reg .. "]"
      end,
      cond = function()
        return vim.fn.reg_recording() ~= ""
      end,
      color = { fg = colors.magenta, gui = "bold" },
    })
    ins_right({
      "searchcount",
      color = { fg = colors.green, gui = "bold" },
    })
    ins_right({
      "venv-selector",
      color = { fg = colors.cyan, gui = "bold" },
    })
    ins_right({
      "o:encoding",
      cond = conditions.hide_in_width,
      color = { fg = colors.violet, gui = "bold" },
    })
    ins_right({
      "fileformat",
      icons_enabled = true,
      color = { fg = colors.springYellow, gui = "bold" },
    })
    ins_right({ "location", color = { fg = colors.springBlue, gui = "bold" } })
    ins_right({
      "progress",
      color = { fg = colors.green, gui = "bold" },
      on_click = function()
        vim.cmd("1")
      end,
    })
    ins_right({
      function()
        return icons.ui.Separator
      end,
      color = { fg = colors.blue },
      padding = { left = 1 },
    })
    lualine.setup(config)
  end,
}
