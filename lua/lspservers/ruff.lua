-- Done

local conf_path = vim.fn.stdpath("config") .. "/pyproject.toml"

return {
  enabled = true,
  init_options = {
    filetypes = { "python" },
    single_file_support = true,
    cmd = { "ruff", "server", "--preview" },
    settings = {
      configuration = conf_path,
      lineLength = 200,
      organizeImports = true,
      lint = {
        enable = true,
        preview = true,
      },
    },
  },
}
