---@diagnostic disable: missing-fields
local options = require("config.options")

return {
  {
    "luozhiya/fittencode.nvim",
    cond = options.use_ai_plugins,
    event = { "InsertEnter" },
    config = function()
      require("fittencode").setup({
        disable_specific_inline_completion = {
          -- For example, `suffixes = {'lua', 'cpp'}`
          suffixes = {},
        },
        inline_completion = {
          -- Enable inline code completion.
          enable = true,
          disable_completion_within_the_line = true,
        },
        -- Available options:
        -- - 'inline' (default)
        -- - 'source'
        completion_mode = "source",
      })
    end,
  },
  {
    "Exafunction/codeium.nvim",
    cond = options.use_ai_plugins,
    event = { "InsertEnter" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        detect_proxy = true,
        enable_chat = true,
        enable_local_search = true,
        enable_index_service = true,
      })
    end,
  },
}
