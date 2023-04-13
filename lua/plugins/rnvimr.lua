vim.g.rnvimr_ranger_cmd = { "ranger", "--cmd=set draw_borders both" }
vim.g.rnvimr_draw_border = 1

return {
  "kevinhwang91/rnvimr",
  lazy = true,
  event = "VeryLazy",
  config = function() end,
  keys = {
    {
      "<leader>tR",
      "<cmd>RnvimrToggle<CR>",
      desc = "Rnvimr Toggle",
    },
  },
}
