return {
  init_options = {
    filetypes = { "python" },
    single_file_support = true,
    cmd = { "ruff-lsp" },
    settings = {
      args = {
        "--preview",
        "--line-length=120",
        "--extend-select=E,N,W,ARG,RUF",
        "--ignore=E402,E501,RUF002,RUF003",
      },
    },
  },
}
