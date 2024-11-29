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
        },
        -- Available options:
        -- - 'inline' (default)
        -- - 'source'
        completion_mode = "inline",
        source_completion = {
          -- Enable source completion.
          enable = false,
          -- engine support nvim-cmp and blink.cmp
          engine = "blink", -- "cmp" | "blink"
        },
      })
    end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    cond = options.use_ai_plugins,
    event = { "InsertEnter" },
    opts = {},
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)
    end,
  },
}
