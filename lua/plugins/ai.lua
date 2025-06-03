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
          chat = {
            adapter = "deepseek",
            keymaps = {
              send = {
                modes = { n = "<C-s>", i = "<C-s>" },
              },
              close = {
                modes = { n = "<C-c>", i = "<C-c>" },
              },
            },
            opts = { completion_provider = "blink" },
          },
          inline = { adapter = "deepseek" },
          agent = { adapter = "deepseek" },
        },
        display = {
          action_palette = {
            provider = "snacks",
            opts = { show_default_actions = true },
          },
        },
        opts = { language = "Chinese" },
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              show_result_in_chat = true, -- Show mcp tool results in chat
              make_vars = true, -- Convert resources to #variables
              make_slash_commands = true, -- Add prompts as /slash commands
            },
          },
        },
      })
    end,
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "TurboLoad",
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup()
    end,
  },
}
