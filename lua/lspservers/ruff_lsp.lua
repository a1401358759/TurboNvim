return {
  init_options = {
    filetypes = { "python" },
    single_file_support = true,
    cmd = { "ruff-lsp" },
    settings = {
      args = {
        "--ignore=E402,E501",
        "--line-length=120",
      },
    },
  },
}
