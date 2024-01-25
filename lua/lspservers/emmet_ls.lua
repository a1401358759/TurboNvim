-- https://github.com/aca/emmet-ls

local util = require("lspconfig.util")

return {
  cmd = { "emmet-ls", "--stdio" },
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  },
  root_dir = util.find_git_ancestor,
  single_file_support = true,
}
