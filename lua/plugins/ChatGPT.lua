return {
  "jackMort/ChatGPT.nvim",
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  -- config = true,
  config = function(_, opts)
    require("chatgpt").setup(opts)
  end,
}
