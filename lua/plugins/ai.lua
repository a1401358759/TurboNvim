---@diagnostic disable: missing-fields
local options = require("config.options")

return {
  {
    "luozhiya/fittencode.nvim",
    cond = options.ai_plugin == "fittencode",
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
    cond = options.ai_plugin == "supermaven",
    event = { "InsertEnter" },
    opts = {},
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)
    end,
  },
  {
    "yetone/avante.nvim",
    event = "TurboLoad",
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = "deepseek_3",
      auto_suggestions_provider = "deepseek_3", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
      vendors = {
        deepseek_3 = {
          __inherited_from = "openai",
          endpoint = "https://api.deepseek.com",
          -- deepseek-reasoner, deepseek-coder, deepseek-chat
          model = "deepseek-chat",
          api_key_name = "DEEPSEEK_API_KEY",
        },
      },
      behaviour = {
        auto_suggestions = false,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  },
}
