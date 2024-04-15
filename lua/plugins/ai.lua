local options = require("config.options")

return {
  {
    "luozhiya/fittencode.nvim",
    cond = options.use_ai_plugins,
    event = { "InsertEnter" },
    config = function()
      require("fittencode").setup({
        disable_specific_inline_completion = {
          -- Disable auto-completion for some specific file suffixes by entering them below
          -- For example, `suffixes = {'lua', 'cpp'}`
          suffixes = {},
        },
        inline_completion = {
          -- Enable inline code completion.
          enable = true,
        },
        -- Set the mode of the completion.
        -- Available options:
        -- - 'inline' (default)
        -- - 'source'
        completion_mode = "source",
        log = {
          level = vim.log.levels.WARN,
        },
      })
    end,
  },
  {
    "David-Kunz/gen.nvim",
    lazy = true,
    cond = options.use_ai_plugins,
    cmd = "Gen",
    config = function()
      local gen = require("gen")
      gen.setup({
        model = "llama2",
        display_mode = "float", -- The display mode. Can be "float" or "split".
        show_prompt = true, -- Shows the prompt submitted to Ollama.
        show_model = true, -- Displays which model you are using at the beginning of your chat session.
        no_auto_close = false, -- Never closes the window automatically.
        debug = false, -- Prints errors and the command which is run.
      })
      gen.prompts["Explain_Code"] = {
        prompt = "Explain the following code in $filetype:\n```\n$text\n```",
      }
      gen.prompts["Fix_Code"] = {
        prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = true,
        extract = "```$filetype\n(.-)```",
      }
    end,
    keys = {
      {
        "<leader>sm",
        function()
          require("gen").select_model()
        end,
        desc = "Select Ollama Model",
      },
    },
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
