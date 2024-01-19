-- tab management
return {
  "tiagovla/scope.nvim",
  lazy = true,
  config = function()
    require("scope").setup({})
  end,
  keys = {
    { "<leader>tc", "<cmd>tabnew<CR>", desc = "Tab Create" },
    { "<leader>tp", "<cmd>tabprevious<CR>", desc = "Tab Previous" },
    { "<leader>tn", "<cmd>tabnext<CR>", desc = "Tab Next" },
    { "<leader>tx", "<cmd>tabclose<CR>", desc = "Tab Close" },
  },
}
