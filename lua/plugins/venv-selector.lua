return {
  "linux-cultist/venv-selector.nvim",
  lazy = true,
  cmd = "VenvSelect",
  opts = {
    options = {
      notify_user_on_venv_activation = true,
      override_notify = false,
      -- Picker backend to prefer: "telescope", "fzf-lua", "snacks", "native", "mini-pick", or "auto".
      picker = "snacks",
      statusline_func = {
        lualine = function() -- called by lualine
          local venv_path = require("venv-selector").venv()
          if not venv_path or venv_path == "" then
            return ""
          end

          local venv_name = vim.fn.fnamemodify(venv_path, ":t")
          if not venv_name then
            return ""
          end

          local output = "🐍 " .. venv_name -- Changes only the icon but you can change colors or use powerline symbols here.
          return output
        end,
      },
    },
  },
  --  Call config for Python files and load the cached venv automatically
  ft = "python",
  keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
}
