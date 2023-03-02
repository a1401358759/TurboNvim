return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false,
  lazy = true,
  opts = {
    defaults = {
      prompt_prefix = "  ",
      selection_caret = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal", -- bottom_pane
      color_devicons = true,
      entry_prefix = " ",
      multi_icon = "  ",
      file_ignore_patterns = { "node_modules" },
      -- config
      layout_config = {
        bottom_pane = {
          height = 15,
          preview_cutoff = 100,
          prompt_position = "bottom",
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  },
}
