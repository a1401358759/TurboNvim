-- https://github.com/hrsh7th/vscode-langservers-extracted

return {
  filetypes = { "html" },
  single_file_support = true,
  cmd = { "vscode-html-language-server", "--stdio" },
  settings = {},
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript" },
  },
}
