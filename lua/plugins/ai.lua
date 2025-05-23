return {
  {
    "supermaven-inc/supermaven-nvim",
    event = { "InsertEnter" },
    cmd = {
      "SupermavenUseFree",
      "SupermavenUsePro",
    },
    opts = {
      keymaps = {
        accept_suggestion = nil, -- handled by nvim-cmp / blink.cmp
      },
      ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
    },
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
      behaviour = {
        auto_suggestions = false,
        support_paste_from_clipboard = true,
        enable_cursor_planning_mode = true,
      },
      ollama = {
        api_key_name = "",
        endpoint = "http://127.0.0.1:11434",
        model = "deepseek-r1:8b",
        options = {
          num_ctx = 32768,
          temperature = 0,
        },
        stream = true,
      },
      vendors = {
        deepseek_3 = {
          __inherited_from = "openai",
          endpoint = "https://api.deepseek.com",
          -- deepseek-reasoner, deepseek-coder, deepseek-chat
          model = "deepseek-chat",
          api_key_name = "DEEPSEEK_API_KEY",
          max_tokens = 8192,
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
  {
    "olimorris/codecompanion.nvim",
    event = "TurboLoad",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              env = {
                api_key = "DEEPSEEK_API_KEY",
              },
              schema = {
                model = {
                  default = "deepseek-chat",
                  choices = {
                    ["deepseek-chat"] = { opts = { can_reason = true } },
                  },
                },
              },
            })
          end,
        },
        strategies = {
          chat = { adapter = "deepseek" },
          inline = { adapter = "deepseek" },
          agent = { adapter = "deepseek" },
        },
      })
    end,
  },
}
