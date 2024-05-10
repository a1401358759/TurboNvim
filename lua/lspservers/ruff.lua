-- Done

return {
  enabled = true,
  init_options = {
    filetypes = { "python" },
    single_file_support = true,
    cmd = { "ruff", "server", "--preview" },
    settings = {
      configuration = "~/.config/nvim/pyproject.toml",
    },
  },
}
