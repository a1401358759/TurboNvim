return {
  "b0o/incline.nvim",
  event = "VeryLazy",
  config = function()
    local devicons = require("nvim-web-devicons")
    local mine_icons = require("config.icons").icons
    require("incline").setup({
      window = {
        margin = {
          horizontal = 0,
          vertical = 1,
        },
        placement = {
          horizontal = "right",
          vertical = "top",
        },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.api.nvim_get_option_value("modified", { buf = props.buf })

        local function get_git_diff()
          local icons =
            { removed = mine_icons.git.removed, changed = mine_icons.git.modified, added = mine_icons.git.added }
          local signs = vim.b[props.buf].gitsigns_status_dict
          local labels = {}
          if signs == nil then
            return labels
          end
          for name, icon in pairs(icons) do
            if tonumber(signs[name]) and signs[name] > 0 then
              table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
            end
          end
          if #labels > 0 then
            table.insert(labels, { "| ", guifg = "grey" })
          end
          return labels
        end

        local function get_diagnostic_label()
          local icons = mine_icons.diagnostics
          local label = {}

          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
            if n > 0 then
              table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
            end
          end
          if #label > 0 then
            table.insert(label, { "| ", guifg = "grey" })
          end
          return label
        end

        return {
          { get_diagnostic_label(), guibg = nil },
          { get_git_diff(), guibg = nil },
          { (ft_icon or "") .. " ", guifg = ft_color, guibg = nil },
          {
            filename,
            gui = modified and "bold,italic" or "bold",
            guibg = nil,
          },
        }
      end,
    })
  end,
}
