return {
  "ur4ltz/surround.nvim",
  lazy = true,
  event = "VeryLazy",
  config = function()
    require"surround".setup {
      mappings_style = "surround",
      space_on_closing_char = true,
    }
  end
}
