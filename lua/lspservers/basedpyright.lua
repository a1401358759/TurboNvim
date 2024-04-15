-- Done
-- https://github.com/DetachHead/basedpyright

local util = require("lspconfig.util")

local root_files = {
  ".git",
  ".gitignore",
}

return {
  filetypes = { "python" },
  single_file_support = true,
  cmd = { "basedpyright-langserver", "--stdio" },
  ---@diagnostic disable-next-line: deprecated
  root_dir = util.root_pattern(unpack(root_files)),
  handlers = {
    -- If you want to disable pyright's diagnostic prompt, open the code below
    ["textDocument/publishDiagnostics"] = function(...) end,
  },
  settings = {
    basedpyright = {
      disableLanguageServices = false,
      disableOrganizeImports = true,
      openFilesOnly = true,
      analysis = {
        ignore = { "*" },
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
        typeCheckingMode = "off",
      },
    },
  },
}
