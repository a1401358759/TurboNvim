-- Done

return {
  enabled = false,
  filetypes = { "python" },
  single_file_support = true,
  cmd = { "ruff", "server", "--preview" },
  settings = {
    configuration = "~/.config/nvim/pyproject.toml",
  },
}
