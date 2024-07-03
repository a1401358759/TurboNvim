-- Done
-- npm install -g @vtsls/language-server

local util = require("lspconfig.util")

local root_files = {
  "tsconfig.json",
  "package.json",
  "jsconfig.json",
  ".git",
}

return {
  cmd = { "vtsls", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = function(fname)
    return util.root_pattern(unpack(root_files))(fname) or vim.fn.getcwd()
  end,
  single_file_support = true,
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}
