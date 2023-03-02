return {
  "norcalli/nvim-colorizer.lua",
  lazy = true,
  event = "VeryLazy",
  config = function()
    vim.cmd("ColorizerReloadAllBuffers")
  end,
}
