return {
  "Bryley/neoai.nvim",
  lazy = true,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  cmd = {
    "NeoAI",
    "NeoAIOpen",
    "NeoAIClose",
    "NeoAIToggle",
    "NeoAIContext",
    "NeoAIContextOpen",
    "NeoAIContextClose",
    "NeoAIInject",
    "NeoAIInjectCode",
    "NeoAIInjectContext",
    "NeoAIInjectContextCode",
  },
  config = function()
    require("neoai").setup({
      ui = {
        output_popup_text = "NeoAI",
        input_popup_text = "Prompt",
        width = 30, -- As percentage eg. 30%
        output_popup_height = 80, -- As percentage eg. 80%
      },
      models = {
        {
          name = "openai",
          model = "gpt-3.5-turbo",
        },
      },
      register_output = {
        ["g"] = function(output)
          return output
        end,
        ["+"] = require("neoai.utils").extract_code_snippets,
      },
      inject = {
        cutoff_width = 75,
      },
      prompts = {
        context_prompt = function(context)
          ---@diagnostic disable-next-line: redundant-return-value
          return "Hey, I'd like to provide some context for future "
            .. "messages. Here is the code/text that I want to refer "
            .. "to in our upcoming conversations:\n\n"
            .. context
        end,
      },
      open_api_key_env = "OPENAI_API_KEY",
    })
  end,
  keys = {
    { "<leader>ai", ":NeoAIToggle<CR>", desc = "NeoAI Toggle" },
  },
}
