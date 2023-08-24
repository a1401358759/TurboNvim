return {
  "theniceboy/joshuto.nvim",
  very_lazy = true,
  cmd = "Joshuto",
  config = function()
    vim.g.joshuto_floating_window_scaling_factor = 0.8
    vim.g.joshuto_use_neovim_remote = 1
    vim.g.joshuto_floating_window_winblend = 0
  end,
  keys = {
    { "<leader>tr", ":Joshuto<cr>", desc = "Joshuto float" },
  },
}
