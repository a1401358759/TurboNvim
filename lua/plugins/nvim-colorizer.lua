return {
  "norcalli/nvim-colorizer.lua",
  lazy = false,
  event = "VeryLazy",
  cmd = "ColorizerToggle",
  config = function()
    require("colorizer").setup({
      "*", -- Highlight all files, but customize some others.
    })
    vim.cmd("ColorizerReloadAllBuffers")
  end,
}
