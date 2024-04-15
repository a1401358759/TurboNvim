-- Done
-- https://github.com/hrsh7th/vscode-langservers-extracted
-- npm i -g vscode-langservers-extracted

return {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "templ" },
  settings = {},
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript" },
  },
  single_file_support = true,
}
