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
    "supermaven-inc/supermaven-nvim",
    cond = options.use_ai_plugins,
    event = { "InsertEnter" },
    opts = {
      keymaps = {
        accept_suggestion = nil, -- handled by nvim-cmp / blink.cmp
      },
    },
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)
    end,
  },
}
