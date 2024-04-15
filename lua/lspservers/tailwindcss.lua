-- Done
-- https://github.com/tailwindlabs/tailwindcss-intellisense

local util = require("lspconfig.util")

local root_files = {
  "tailwind.config.js",
  "tailwind.config.cjs",
  "tailwind.config.mjs",
  "tailwind.config.ts",
  "postcss.config.js",
  "postcss.config.cjs",
  "postcss.config.mjs",
  "postcss.config.ts",
  "package.json",
  "node_modules",
  ".git",
}

return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "aspnetcorerazor",
    "astro",
    "blade",
    "clojure",
    "django-html",
    "htmldjango",
    "edge",
    "eelixir",
    "elixir",
    "ejs",
    "erb",
    "eruby",
    "gohtml",
    "gohtmltmpl",
    "haml",
    "handlebars",
    "hbs",
    "html",
    "html-eex",
    "heex",
    "jade",
    "leaf",
    "liquid",
    "mdx",
    "mustache",
    "njk",
    "nunjucks",
    "php",
    "razor",
    "slim",
    "twig",
    "css",
    "less",
    "postcss",
    "sass",
    "scss",
    "stylus",
    "sugarss",
    "javascript",
    "javascriptreact",
    "reason",
    "rescript",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "templ",
  },
  init_options = {
    userLanguages = {
      eelixir = "html-eex",
      eruby = "erb",
      templ = "html",
    },
  },
  root_dir = function(fname)
    return util.root_pattern(unpack(root_files))(fname)
      or util.find_package_json_ancestor(fname)
      or util.find_node_modules_ancestor(fname)
      or util.find_git_ancestor(fname)
      or vim.fn.getcwd()
  end,
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
    },
  },
}
