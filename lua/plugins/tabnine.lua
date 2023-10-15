return {
  "tzachar/cmp-tabnine",
  event = { "UIEnter" },
  build = "./install.sh",
  dependencies = "hrsh7th/nvim-cmp",
  opts = {
    max_lines = 1000,
    max_num_results = 3,
    sort = true,
  },
  config = function(_, opts)
    local tabnine = require("cmp_tabnine.config")
    tabnine:setup(opts)
  end,
}
