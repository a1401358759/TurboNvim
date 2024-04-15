-- Done
local options = require("config.options")

return {
  filetypes = { "python" },
  single_file_support = true,
  cmd = { "ruff", "server", "--preview", "--config", "~/.config/nvim/pyproject.toml" },
  settings = {
    args = options.ruff_args,
  },
}
