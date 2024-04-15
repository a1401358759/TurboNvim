-- Done
-- https://github.com/hrsh7th/vscode-langservers-extracted

return {
  single_file_support = true,
  filetypes = { "css", "scss", "less" },
  cmd = { "vscode-css-language-server", "--stdio" },
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}
