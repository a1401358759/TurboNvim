-- Done
-- https://github.com/aca/emmet-ls

return {
  cmd = { "emmet-ls", "--stdio" },
  filetypes = {
    "astro",
    "css",
    "eruby",
    "html",
    "htmlangular",
    "htmldjango",
    "javascriptreact",
    "less",
    "pug",
    "sass",
    "scss",
    "svelte",
    "templ",
    "typescriptreact",
    "vue",
  },
  root_markers = { ".git" },
}
