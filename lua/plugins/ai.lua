return {
  {
    "luozhiya/fittencode.nvim",
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
    "piersolenski/wtf.nvim",
    lazy = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {},
    keys = {
      {
        "<leader>gw",
        mode = { "n", "x" },
        function()
          require("wtf").ai()
        end,
        desc = "Debug diagnostic with AI",
      },
      {
        mode = { "n" },
        "<leader>gW",
        function()
          require("wtf").search()
        end,
        desc = "Search diagnostic with Google",
      },
    },
    config = function()
      require("wtf").setup({
        popup_type = "popup",
        -- openai_api_key = "sk-xxxxxxxxxxxxxx",
        openai_model_id = "gpt-3.5-turbo",
        context = true,
        language = "chinese",
        search_engine = "google",
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      })
    end,
  },
}
