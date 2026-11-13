-- AI。vim.g.use_ai 为真时才安装。

return {
  {
    name = "supermaven",
    "https://github.com/supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    cmd = { "SupermavenStart", "SupermavenStop", "SupermavenToggle", "SupermavenUseFree", "SupermavenUsePro" },
    enabled = function()
      return vim.g.use_ai
    end,
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = nil, -- handled by nvim-cmp / blink.cmp
        },
        ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
      })
    end,
  },

  {
    name = "codecompanion",
    "https://github.com/olimorris/codecompanion.nvim",
    needs = { "plenary" },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionCmd", "CodeCompanionActions" },
    enabled = function()
      return vim.g.use_ai
    end,
    config = function()
      require("codecompanion").setup({
        adapters = {
          http = {
            deepseek = function()
              return require("codecompanion.adapters").extend("deepseek", {
                env = {
                  api_key = "DEEPSEEK_API_KEY",
                },
                schema = {
                  model = {
                    default = "deepseek-v4-flash",
                    choices = {
                      ["deepseek-chat"] = { opts = { can_reason = true } },
                    },
                  },
                },
              })
            end,
          },
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
      })
    end,
  },
}
