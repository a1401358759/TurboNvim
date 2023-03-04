-- https://github.com/hrsh7th/vscode-langservers-extracted

local util = require("lspconfig.util")

return {
  -- lazy-load schemastore when needed
  on_new_config = function(new_config)
    new_config.settings.json.schemas = new_config.settings.json.schemas or {}
    ---@diagnostic disable-next-line: missing-parameter
    vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
  end,
  settings = {
    json = {
      format = {
        enable = true,
      },
      validate = { enable = true },
    },
    single_file_support = true,
    filetypes = { "json", "jsonc" },
    cmd = { "vscode-json-language-server", "--stdio" },
    init_options = {
      provideFormatter = true,
    },
    root_dir = util.find_git_ancestor,
  },
}
