local ignore_list = {
  "W391",
  "W293",
  "E701",
  "E266",
  "E309",
  "E306",
  "E501",
  "C901",
  "C0301",
  "W0142",
  "W0401",
  "W0402",
  "R0201",
  "E1101",
  "E1102",
  "C0103",
  "R0901",
  "R0903",
  "R0904",
  "C1001",
  "W0223",
  "W0232",
  "W0201",
  "E1103",
  "R0801",
  "C0111",
  "E722",
  "W292",
  "E402",
  "F821",
  "W503",
  "E203",
}

local util = require("lspconfig.util")

local root_files = {
  ".git",
  ".gitignore",
}

return {
  cmd = { "pylsp" },
  filetypes = { "python" },
  single_file_support = true,
  root_dir = function(fname)
    return util.root_pattern(unpack(root_files))(fname)
  end,
  settings = {
    pylsp = {
      configurationSources = { "flake8" },
      plugins = {
        flake8 = {
          enabled = false,
          ignore = ignore_list,
          maxLineLength = 140,
        },
        pycodestyle = {
          enabled = false,
          ignore = ignore_list,
          maxLineLength = 140,
        },
        autopep8 = {
          enabled = false,
          ignore = ignore_list,
          maxLineLength = 140,
        },
        pyflakes = {
          enabled = false,
          ignore = ignore_list,
          maxLineLength = 140,
        },
        mccabe = {
          enabled = false,
          threshold = 100,
        },
        pylint = {
          enabled = false,
          ignore = ignore_list,
          maxLineLength = 140,
        },
      },
    },
  },
}
