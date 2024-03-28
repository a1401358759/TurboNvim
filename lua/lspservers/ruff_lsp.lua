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
        "--ignore=E402,E501,N802,N803,N806,N801,N813,RUF001,RUF002,RUF003,RUF012",
      },
    },
  },
}
