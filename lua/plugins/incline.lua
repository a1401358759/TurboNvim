return {
  "b0o/incline.nvim",
  lazy = true,
  event = "TurboLoad",
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
          local signs = vim.b[props.buf].gitsigns_status_dict
          local labels = {}
          if signs == nil then
            return labels
          end
          local icons = {
            { kind = "added", icon = mine_icons.git.added },
            { kind = "changed", icon = mine_icons.git.modified },
            { kind = "removed", icon = mine_icons.git.removed },
          }
          local diff_color = {
            added = "#b8db87",
            changed = "#7ca1f2",
            removed = "#e26a75",
          }
          for _, item in pairs(icons) do
            local name = item.kind
            if tonumber(signs[name]) and signs[name] > 0 then
              table.insert(labels, { item.icon .. signs[name] .. " ", guifg = diff_color[name] })
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
