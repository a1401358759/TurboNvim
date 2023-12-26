local Util = require("lazyvim.util")
local options = require("config.options")

return {
  {
    "a1401358759/codeium.nvim",
    cond = options.use_ai_plugins,
    cmd = "Codeium",
    build = ":Codeium Auth",
    opts = {},
  },
  {
    "tzachar/cmp-tabnine",
    cond = options.use_ai_plugins,
    build = {
      Util.is_win() and "pwsh -noni .\\install.ps1" or "./install.sh",
      ":CmpTabnineHub",
    },
    dependencies = "hrsh7th/nvim-cmp",
    opts = {
      max_lines = 1000,
      max_num_results = 3,
      sort = true,
    },
    config = function(_, opts)
      require("cmp_tabnine.config"):setup(opts)
    end,
  },
}
