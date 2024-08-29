return {
  "folke/persistence.nvim",
  lazy = true,
  opts = { options = vim.opt.sessionoptions:get() },
  -- stylua: ignore
  keys = {
    { "<leader>ss", function() require("persistence").load() end, desc = "Restore Session" },
    { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    { "<leader>sd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
  },
}
