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
      provider = "ollama",
      behaviour = {
        auto_suggestions = false,
        support_paste_from_clipboard = true,
      },
      vendors = {
        deepseek_3 = {
          __inherited_from = "openai",
          endpoint = "https://api.deepseek.com",
          -- deepseek-reasoner, deepseek-coder, deepseek-chat
          model = "deepseek-chat",
          api_key_name = "DEEPSEEK_API_KEY",
        },
        ollama = {
          __inherited_from = "openai",
          api_key_name = "",
          endpoint = "http://127.0.0.1:11434/v1",
          model = "deepseek-r1:7b",
        },
        qianwen = {
          __inherited_from = "openai",
          api_key_name = "DASHSCOPE_API_KEY",
          endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
          model = "qwen-plus",
        },
      },
      windows = {
        input = {
          prefix = " ",
          height = 8, -- Height of the input window in vertical layout
        },
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
