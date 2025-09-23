-- Done

local conf_path = vim.fn.stdpath("config") .. "/pyproject.toml"

return {
  enabled = true,
  init_options = {
    filetypes = { "python" },
    single_file_support = true,
    cmd = { "ruff", "server", "--preview" },
    root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
    settings = {
      configuration = conf_path,
      organizeImports = true,
      lint = {
        enable = true,
        preview = true,
      },
    },
  },
}
