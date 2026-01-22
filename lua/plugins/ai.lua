return {
  {
    "supermaven-inc/supermaven-nvim",
    cond = vim.g.use_ai,
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
    cond = vim.g.use_ai,
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
    "NickvanDyke/opencode.nvim",
    cond = vim.g.use_ai,
    event = "TurboLoad",
    dependencies = {
      ---@diagnostic disable-next-line: missing-fields
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      -- Recommended/example keymaps.
      vim.keymap.set({ "n", "x" }, "<leader>oa", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Ask opencode" })
      vim.keymap.set({ "n", "x" }, "<leader>os", function()
        require("opencode").select()
      end, { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<C-.>", function()
        require("opencode").toggle()
      end, { desc = "Toggle opencode" })

      vim.keymap.set({ "n", "x" }, "go", function()
        return require("opencode").operator("@this ")
      end, { expr = true, desc = "Add range to opencode" })
      vim.keymap.set("n", "goo", function()
        return require("opencode").operator("@this ") .. "_"
      end, { expr = true, desc = "Add line to opencode" })

      vim.keymap.set("n", "<S-C-u>", function()
        require("opencode").command("session.half.page.up")
      end, { desc = "opencode half page up" })
      vim.keymap.set("n", "<S-C-d>", function()
        require("opencode").command("session.half.page.down")
      end, { desc = "opencode half page down" })
    end,
  },
}
