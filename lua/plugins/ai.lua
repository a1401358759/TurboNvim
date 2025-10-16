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
          http = {
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
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        mux = {
          backend = "zellij",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<c-.>",
        function()
          require("sidekick.cli").focus()
        end,
        desc = "Sidekick Switch Focus",
        mode = { "n", "v" },
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle({ name = "gemini", focus = true })
        end,
        desc = "Sidekick Toggle CLI",
        mode = { "n", "v" },
      },
      {
        "<leader>as",
        function()
          require("sidekick.cli").select()
        end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = "Select CLI",
      },
      {
        "<leader>ad",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>at",
        function()
          require("sidekick.cli").send({ msg = "{this}" })
        end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send File",
      },
      {
        "<leader>av",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        desc = "Sidekick Ask Prompt",
        mode = { "n", "v" },
      },
    },
  },
}
