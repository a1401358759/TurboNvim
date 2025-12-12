return {
  {
    "echasnovski/mini.comment",
    enabled = vim.fn.has("nvim-0.10") == 0,
    event = { "TurboLoad" },
    lazy = true,
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  {
    "echasnovski/mini.move",
    lazy = true,
    opts = {},
    keys = {
      -- Visual
      { "<A-h>", "<cmd>lua MiniMove.move_selection('left')<CR>", desc = "Move left", mode = { "v", "x" } },
      { "<A-l>", "<cmd>lua MiniMove.move_selection('right')<CR>", desc = "Move right", mode = { "v", "x" } },
      { "<A-j>", "<cmd>lua MiniMove.move_selection('down')<CR>", desc = "Move down", mode = { "v", "x" } },
      { "<A-k>", "<cmd>lua MiniMove.move_selection('up')<CR>", desc = "Move up", mode = { "v", "x" } },
      -- Normal
      { "<A-h>", "<cmd>lua MiniMove.move_line('left')<CR>", desc = "Move line left", mode = "n" },
      { "<A-l>", "<cmd>lua MiniMove.move_line('right')<CR>", desc = "Move line right", mode = "n" },
      { "<A-j>", "<cmd>lua MiniMove.move_line('down')<CR>", desc = "Move line down", mode = "n" },
      { "<A-k>", "<cmd>lua MiniMove.move_line('up')<CR>", desc = "Move line up", mode = "n" },
    },
  },
  {
    "nvim-mini/mini.nvim",
    version = "*",
    lazy = true,
    opts = {
      mappings = {
        add = "ys", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        replace = "cs", -- Replace surrounding
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
  },
}
