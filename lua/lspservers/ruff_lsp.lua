-- Done

local options = require("config.options")

return {
  enabled = true,
  init_options = {
    filetypes = { "python" },
    single_file_support = true,
    cmd = { "ruff-lsp" },
    settings = {
      args = options.ruff_args,
    },
  },
}
