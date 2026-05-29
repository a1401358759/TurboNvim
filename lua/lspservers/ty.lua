return {
  single_file_support = true,
  cmd = { "ty", "server" },
  filetypes = { "python" },
  root_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  settings = {
    ty = {
      disableLanguageServices = false,
      showSyntaxErrors = true,
      diagnosticMode = "openFilesOnly", -- "off" | "workspace" | "openFilesOnly"
      inlayHints = {
        variableTypes = false,
        callArgumentNames = true,
      },
      completions = {
        autoImport = true,
      },
      configuration = {
        rules = {
          ["possibly-unresolved-reference"] = "error", -- "all", "ignore" | "warn" | "error"
          ["possibly-unresolved-import"] = "ignore",
          ["unresolved-import"] = "ignore",
        },
      },
    },
  },
}
